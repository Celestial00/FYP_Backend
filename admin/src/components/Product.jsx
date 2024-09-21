import React from "react";
import { useNavigate } from "react-router-dom"; // Import useNavigate for navigation

export default function Product({ product }) {
  const navigate = useNavigate();

  const normalizePath = (path) => {
    return path.replace(/\\/g, "/"); // Replace backslashes with forward slashes
  };

  const imagePath = normalizePath(product.image_path);

  const handleClick = () => {
    console.log(`Image URL: http://192.168.10.5:5000/${imagePath}`);
    navigate(`/ProductPage`, {state : product, image : imagePath});
  };

  return (
    <div
      className="border border-gray-300 rounded-[10px] overflow-hidden flex flex-col cursor-pointer m-2" // Added margin
      onClick={handleClick}
      style={{ width: "200px" }} // Set a fixed width for consistency
    >
      <div className="w-full h-48 bg-gray-200">
        {imagePath && (
          <img
            src={`http://192.168.10.5:5000/${imagePath}`}
            alt={product.product_name}
            className="w-full h-full object-cover"
          />
        )}
      </div>
      <div className="p-4 flex flex-col justify-between flex-1">
        <h2 className="text-lg font-semibold text-gray-800">{product.product_name}</h2>
        <p className="text-sm text-gray-600 mb-2">{product.description}</p>
        <span className="text-xl font-bold text-gray-900">${product.price}</span>
      </div>
    </div>
  );
}
