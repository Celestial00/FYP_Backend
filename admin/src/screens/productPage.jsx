// src/components/ProductPage.js

import React from 'react';
import { TrashIcon } from '@heroicons/react/outline'; // Import Heroicons for the delete icon
import { useLocation } from 'react-router-dom';

const ProductPage = ({ product, onDelete }) => {

  const location = useLocation();
  const productData = location.state; // Access the data here

  
  const normalizePath = (path) => {
    return path.replace(/\\/g, "/"); // Replace backslashes with forward slashes
  };

  const imagePath = normalizePath(productData.image_path);



  return (
    <div className="min-h-screen bg-white flex flex-col">
      {/* Top Section: Image */}
      <div className="w-full h-[50vh] bg-gray-200">
        <img
          src={`http://192.168.10.5:5000/${imagePath}`} // Assuming you want to use the first image for the top section
          alt={"shoe"}
          className="w-full h-full object-fill"
        />
      </div>

      {/* Bottom Section: Details */}
      <div className="p-8 flex flex-col space-y-6">
        <h1 className="text-4xl font-semibold text-gray-800">{productData.product_name}</h1>
        <p className="text-sm text-gray-600">{productData.description}</p>
        <span className="text-2xl font-bold text-gray-900">${productData.price}</span>
        <button
          onClick={() => onDelete(product.id)}
          className="flex items-center mt-4 py-2 px-4 bg-red-600 text-white font-semibold rounded-[10px] hover:bg-red-700 transition duration-200"
        >
          <TrashIcon className="h-5 w-5 mr-2" aria-hidden="true" />
          <span>Delete</span>
        </button>
      </div>
    </div>
  );
};

export default ProductPage;