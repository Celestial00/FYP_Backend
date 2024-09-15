import React from 'react'
import { useState } from 'react';
import { UploadIcon } from '@heroicons/react/outline';

export default function AddProductPage() {

 const [image, setImage] = useState(null);
  const [price, setPrice] = useState('');
  const [description, setDescription] = useState('');
  const [category, setCategory] = useState('');

  // Handle file input change
  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      // Generate a URL for the selected file
      const fileURL = URL.createObjectURL(file);
      setImage(fileURL);

      // Revoke the object URL after the component is unmounted
      return () => URL.revokeObjectURL(fileURL);
    } else {
      setImage(null);
    }
  };

  // Handle form submission
  const handleSubmit = (e) => {
    e.preventDefault();
    // Handle add product logic here
    console.log('Image URL:', image);
    console.log('Price:', price);
    console.log('Description:', description);
    console.log('Category:', category);
  };

  return (
    <div className="min-h-screen bg-white flex items-start">
      <div className="w-full max-w-3xl p-8 flex space-x-8 mx-4 my-8">
        {/* Form Section */}
        <div className="w-full max-w-md flex-1">
          <h1 className="text-[60px] font-semibold mb-6 text-gray-800">Add Product</h1>
          <form onSubmit={handleSubmit} className="space-y-6">
            <div>
              <label htmlFor="image" className="block text-sm font-medium text-gray-700">Image</label>
              <div className="flex items-center mt-1">
                <label
                  htmlFor="image"
                  className="flex items-center cursor-pointer p-2 border border-gray-300 rounded-[10px] bg-gray-100 text-gray-900 hover:bg-gray-200 transition duration-200"
                >
                  <UploadIcon className="h-5 w-5 text-gray-600 mr-2" aria-hidden="true" />
                  <span className="text-sm">Choose File</span>
                  <input
                    id="image"
                    type="file"
                    onChange={handleImageChange}
                    className="hidden"
                    required
                  />
                </label>
              </div>
            </div>
            <div>
              <label htmlFor="price" className="block text-sm font-medium text-gray-700">Price</label>
              <input
                id="price"
                type="number"
                value={price}
                onChange={(e) => setPrice(e.target.value)}
                className="w-full mt-1 p-2 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
                placeholder="Enter price"
                required
              />
            </div>
            <div>
              <label htmlFor="description" className="block text-sm font-medium text-gray-700">Description</label>
              <textarea
                id="description"
                value={description}
                onChange={(e) => setDescription(e.target.value)}
                className="w-full mt-1 p-2 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
                placeholder="Enter description"
                rows="4"
                required
              />
            </div>
            <div>
              <label htmlFor="category" className="block text-sm font-medium text-gray-700">Category</label>
              <input
                id="category"
                type="text"
                value={category}
                onChange={(e) => setCategory(e.target.value)}
                className="w-full mt-1 p-2 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
                placeholder="Enter category"
                required
              />
            </div>
            <button
              type="submit"
              className="w-full py-3 px-4 bg-black text-white font-semibold rounded-[10px] hover:bg-gray-800 transition duration-200"
            >
              Add Product
            </button>
          </form>
        </div>

        {/* Image Preview Section */}
        <div className="w-1/3 flex-shrink-0 flex items-center justify-center">
          {image && (
            <div className="w-60 h-60 rounded-[10px] overflow-hidden border border-gray-300">
              <img src={image} alt="Product Preview" className="w-full h-full object-cover" />
            </div>
          )}
        </div>
      </div>
    </div>
  );
}