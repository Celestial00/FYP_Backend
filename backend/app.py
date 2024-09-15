from flask import Flask, request, render_template, redirect, url_for, send_from_directory, jsonify
from werkzeug.utils import secure_filename
from feature_extraction import extract_features, build_index, save_index, load_index
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import numpy as np
from flask_cors import CORS
import os
import uuid
from PIL import Image
import io

app = Flask(__name__)
CORS(app, origins=['http://localhost:5173'])


UPLOAD_FOLDER = 'static/images/'
app.config['IMAGE_FOLDER'] = 'static\images'
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg'}
os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)
Uploaled_Image_Query = ""
image_paths_ = []  # Initialize the image_paths list


# firebase Connection

cred = credentials.Certificate('config/firebase_credentials.json')
firebase_admin.initialize_app(cred)
db = firestore.client()


# FunctionS 
def extract_ids(products):
    return [product['id'] for product in products]


def get_products_by_ids(product_ids):
    try:
        
        product_list = []

        # Reference to the products collection
        products_ref = db.collection('products')

        for product_id in product_ids:
            # Get the document by ID
            doc_ref = products_ref.document(product_id)
            doc = doc_ref.get()
            
            if doc.exists:
                # Add the document data to the list with the ID included
                product_list.append({'id': doc.id, **doc.to_dict()})
            else:
                print(f"Product with ID {product_id} does not exist.")

        return product_list
    
    except Exception as e:
        print(f"An error occurred: {e}")
        return []



def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

def get_all_image_paths(folder_path):
    image_paths = []
    for root, _, files in os.walk(folder_path):
        for file in files:
            if allowed_file(file):
                image_paths.append(os.path.join(root, file))
    return image_paths

# Build or load FAISS index
index_file = 'image_index.faiss'
if os.path.exists(index_file):
    index_ = load_index(index_file)  # This should be a FAISS index object
else:
    image_paths = get_all_image_paths(app.config['IMAGE_FOLDER'])
    index_ = build_index(image_paths)  # This should be a FAISS index object
    save_index(index_, index_file)



def create_file_list(file_list):
    file_dict_list = []
    
    for file in file_list:
        full_path = file[0]
        name = os.path.splitext(os.path.basename(full_path))[0]  # Get file name without extension
        file_dict = {'id': name, 'location': full_path}
        file_dict_list.append(file_dict)
    
    return file_dict_list




def convert_image_to_jpg_if_needed(file_storage):
    # Check if the input is a FileStorage object
    if not hasattr(file_storage, 'read'):
        raise ValueError("Input must be a FileStorage object")

    # Check if the file is already a JPG
    if file_storage.filename.lower().endswith(('.jpg', '.jpeg')):
        # Create a file-like object from the FileStorage object
        img_byte_arr = io.BytesIO(file_storage.read())
        img_byte_arr.seek(0)
        return img_byte_arr, '.jpg'

    # Open the image from the FileStorage object
    img_byte_arr = io.BytesIO(file_storage.read())
    with Image.open(img_byte_arr) as img:
        # Convert the image mode to 'RGB' (JPEG doesn't support alpha channels)
        img = img.convert('RGB')

        # Create an in-memory buffer to store the image as a file-like object
        img_byte_arr = io.BytesIO()
        img.save(img_byte_arr, format='JPEG')
        img_byte_arr.seek(0)  # Reset the pointer to the beginning of the stream
        return img_byte_arr, '.jpg'



#routes 


@app.route('/images/<path:filename>')
def serve_image(filename):
    return send_from_directory('static/images', filename)


# For get all the data 

@app.route("/getProducts", methods=["GET"])
def Get_All_Products():
    try:
        # Get reference to 'products' collection
        products_ref = db.collection('products')
        
        # Fetch all documents in the 'products' collection
        products = products_ref.stream()
        
        # Prepare a list to hold all product data
        all_products = []
        
        # Loop through the documents and append their data to the list
        for product in products:
            product_data = product.to_dict()
            product_data['id'] = product.id  # Include document ID if needed
            all_products.append(product_data)
        
        # Return the list of products as JSON response
        return jsonify(all_products), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500




# for Admin Validation 




@app.route('/auth' , methods=["POST"])
def user_Auth():
    Email = request.json.get('Email')
    Password = request.json.get('Password')
    
    if not Email or not Password:
        return jsonify({"error": "Email and Password are required"}), 400

    try:
        # Query Firestore collection 'Admin' for the user with the given Email
        admin_ref = db.collection('Admins').where('Email', '==', Email).stream()
        user_data = None

        for user in admin_ref:
            user_data = user.to_dict()

        
        print(user_data)
        
        # If user is not found
        if not user_data:
            return jsonify({"error": "Invalid Email or Password"}), 401

        # Verify Password (assume plain text Password, you may want to hash Passwords)
        if user_data['Password'] == Password:
            # Authentication successful
            return jsonify({"message": "Authentication successful", "user": user_data}), 200
        else:
            # Incorrect Password
            return jsonify({"error": "Invalid Email or Password"}), 401

    except Exception as e:
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500





#for result template 

@app.route('/search_product', methods=["POST","GET"])
def search_product( ):
    product_data = None
    error = None
    
    if request.method == 'POST':
        product_id = request.form['productId']

        doc_ref = db.collection('products').document(product_id)
        product = doc_ref.get()
        
        if product.exists:
            product_data = product.to_dict()
        else:
            error = "Product not found"
    
    return render_template('search_product.html', product=product_data, error=error)



#for rendering the template of form

@app.route('/form')
def form_handler():
    return render_template('product_form.html')


# pro adding product 

@app.route('/add_product', methods=['POST'])
def submit_product():
    try:
        product_name = request.form['productName']
        price = request.form['price']
        description = request.form['description']
        unique_id = str(uuid.uuid4())

        product_image = request.files['productImage']

        # Convert image to JPG if needed
        img_byte_arr, file_extension = convert_image_to_jpg_if_needed(product_image)

        # Generate a unique filename
        new_image_name = f"{unique_id}.jpg"

        # Save the image to the specified folder
        image_path = os.path.join(app.config['IMAGE_FOLDER'], new_image_name)
        with open(image_path, 'wb') as img_file:
            img_file.write(img_byte_arr.getvalue())

        # Save product details to Firestore
        doc_ref = db.collection('products').document(unique_id)
        doc_ref.set({
            'product_name': product_name,
            'price': price,
            'description': description,
            'image_name': new_image_name,
            'image_path': image_path
        })

        image_paths = get_all_image_paths(app.config['IMAGE_FOLDER'])
        index_ = build_index(image_paths)  # This should be a FAISS index object
        save_index(index_, index_file)

        print(f'Product Name: {product_name}')
        print(f'Price: {price}')
        print(f'Description: {description}')
        print(f'Image Path: {image_path}')

    except Exception as e:
        print(f"Error: {e}")
        return str(e), 500

    # Redirect to the home page or another page
    return redirect(url_for('index'))



@app.route('/')
def index():
    return render_template('index.html')

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)


@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No file part in the request'}), 400
    
    file = request.files['file']
     
    
    if file.filename == '':
        return jsonify({'error': 'No selected file'}), 400
    
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        # Extract features and search
        try:
            query_features = extract_features(filepath)
            query_features = np.expand_dims(query_features, axis=0)
            distances, indices = index_.search(query_features, k=10)
        except Exception as e:
            return jsonify({'error': str(e)}), 500

        # Load image paths if not already loaded
        if not hasattr(app, 'image_paths_'):
            app.image_paths_ = get_all_image_paths(app.config['IMAGE_FOLDER'])

        # Ensure we don't try to access out-of-range indices
        valid_indices = [i for i in indices[0] if i < len(app.image_paths_)]

        if not valid_indices:
            return jsonify({'message': 'No matching images found.'}), 404

        # Map valid indices to image paths
        matching_image_paths = [app.image_paths_[i] for i in valid_indices]
        valid_distances = distances[0][:len(valid_indices)]

        results = list(zip(matching_image_paths, valid_distances))
        product_list = create_file_list(results)
        product_ids_get = extract_ids(product_list)
        data = get_products_by_ids(product_ids_get)  
        
        return jsonify(data), 200

    return jsonify({'error': 'File upload failed, incorrect format'}), 400





if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')




