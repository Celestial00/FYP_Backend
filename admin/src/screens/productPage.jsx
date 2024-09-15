// src/components/ProductPage.js

import React from 'react';
import { TrashIcon } from '@heroicons/react/outline'; // Import Heroicons for the delete icon

const ProductPage = ({ product, onDelete }) => {
  return (
    <div className="min-h-screen bg-white flex flex-col">
      {/* Top Section: Image */}
      <div className="w-full h-[50vh] bg-gray-200">
        <img
          src={"https://cdn.thewirecutter.com/wp-content/media/2021/10/running-shoes-2048px-3128-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp"} // Assuming you want to use the first image for the top section
          alt={"shoe"}
          className="w-full h-full object-cover"
        />
      </div>

      {/* Bottom Section: Details */}
      <div className="p-8 flex flex-col space-y-6">
        <h1 className="text-4xl font-semibold text-gray-800">{"shoe"}</h1>
        <p className="text-sm text-gray-600">{"Description refers to the process of depicting or explaining the features or characteristics of something or someone through language, imagery, or other forms of representation1. It involves articulating the details, qualities, and attributes that define the subject1. In general, description is an act of describing, intended to give a mental image of something experienced"}</p>
        <span className="text-2xl font-bold text-gray-900">${200}</span>
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