from flask import Flask, request, render_template, redirect, url_for, send_from_directory, jsonify
from werkzeug.utils import secure_filename
from feature_extraction import extract_features, build_index, save_index, load_index
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import numpy as np
import os
import uuid

app = Flask(__name__)


UPLOAD_FOLDER = 'static/images/'
app.config['IMAGE_FOLDER'] = 'static\images'
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = {'png', 'jpg', 'jpeg'}


# firebase Connection

cred = credentials.Certificate('config/firebase_credentials.json')
firebase_admin.initialize_app(cred)
db = firestore.client()


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

    product_name = request.form['productName']
    price = request.form['price']
    description = request.form['description']
    
    
    unique_id = str(uuid.uuid4())


    product_image = request.files['productImage']

    
    if product_image:
     
        _, file_extension = os.path.splitext(product_image.filename)
        new_image_name = f"{unique_id}{file_extension}"

        image_path = os.path.join(app.config['IMAGE_FOLDER'], new_image_name)
        product_image.save(image_path)
        
      
        doc_ref = db.collection('products').document(unique_id)
        doc_ref.set({
            'product_name': product_name,
            'price': price,
            'description': description,
            'image_name': new_image_name,
            'image_path': image_path
        })

        print(f'Product Name: {product_name}')
        print(f'Price: {price}')
        print(f'Description: {description}')
        print(f'Image Path: {image_path}')

    # Redirect to the home page or another page
    return redirect(url_for('index'))


    






Uploaled_Image_Query = ""
image_paths_ = []  # Initialize the image_paths list

os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

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

@app.route('/')
def index():
    return render_template('index.html')






@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename)


@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return redirect(request.url)
    file = request.files['file']
    if file.filename == '':
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)

        # Extract features and search
        query_features = extract_features(filepath)
        query_features = np.expand_dims(query_features, axis=0)

        # Perform the search
        try:
            distances, indices = index_.search(query_features, k=5)
        except Exception as e:
            return str(e)

        # Load image paths if not already loaded
        if not hasattr(app, 'image_paths_'):
            app.image_paths_ = get_all_image_paths(app.config['IMAGE_FOLDER'])

        # Map indices to image paths
        matching_image_paths = [app.image_paths_[i] for i in indices[0]]
        results = list(zip(matching_image_paths, distances[0]))

        # Pass the uploaded image and results to the template
        return render_template('results.html', results=results, Uploaled_Image_Query=filepath)

    return redirect(request.url)





if __name__ == '__main__':
    app.run(debug=True)
