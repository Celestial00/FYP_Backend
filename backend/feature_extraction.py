import numpy as np
import faiss
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.applications.resnet50 import preprocess_input
from tensorflow.keras.preprocessing import image
from tensorflow.keras.models import Model

# Load ResNet50 model
def load_model():
    base_model = ResNet50(weights='imagenet', include_top=False, pooling='avg')
    return Model(inputs=base_model.input, outputs=base_model.output)

model = load_model()

def extract_features(img_path):
    img = image.load_img(img_path, target_size=(224, 224))
    img_array = image.img_to_array(img)
    img_array = np.expand_dims(img_array, axis=0)
    img_array = preprocess_input(img_array)
    features = model.predict(img_array)
    return features.flatten()

def build_index(image_paths):
    features_list = []
    for img_path in image_paths:
        features = extract_features(img_path)
        features_list.append(features)
    
    features_array = np.array(features_list)
    index = faiss.IndexFlatL2(features_array.shape[1])
    index.add(features_array)
    return index

def save_index(index, filename):
    faiss.write_index(index, filename)

def load_index(filename):
    return faiss.read_index(filename)
