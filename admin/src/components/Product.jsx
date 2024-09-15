import React from "react";
import { useNavigate } from "react-router-dom"; // Import useNavigate for navigation
import { TrashIcon } from "@heroicons/react/outline";

export default function product({ product }) {
  const navigate = useNavigate({ product });

  const handleClick = () => {
    navigate(`/ProductPage`);
  };

  return (
    <div
      className="border border-gray-300 rounded-[10px] overflow-hidden flex flex-col cursor-pointer"
      onClick={handleClick}
    >
      <div className="w-full h-48 bg-gray-200">
        {product.image && (
          <img
            src={product.image}
            alt={product.name}
            className="w-full h-full object-cover"
          />
        )}
      </div>
      <div className="p-4 flex flex-col justify-between flex-1">
        <h2 className="text-lg font-semibold text-gray-800">{product.name}</h2>
        <p className="text-sm text-gray-600 mb-2">{product.description}</p>
        <span className="text-xl font-bold text-gray-900">
          ${product.price}
        </span>
      </div>
    </div>
  );
}