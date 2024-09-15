import React, { useContext, useEffect } from "react";
import ProductCard from "../components/product";
import { UserContext } from "../hooks/UserContext";
import { useNavigate } from "react-router-dom";

export default function HomePage() {
  const { user } = useContext(UserContext);
  const navigate = useNavigate();

  useEffect(() => {
    if (user.sigined === false) {
      navigate("/"); // Redirect to home or login page if user is not signed in
    }
    console.log(user); // Log user for debugging purposes
  }, [user, navigate]);

  const HandleProductButton = () => {
    navigate("/addproduct");
  };

  const categories = {
    Shoes: [
      {
        name: "Running Shoes",
        price: "89.99",
        description: "Comfortable running shoes for all-day wear.",
        image: "https://via.placeholder.com/400x300",
      },
      {
        name: "Casual Sneakers",
        price: "59.99",
        description: "Stylish sneakers for casual outings.",
        image: "https://via.placeholder.com/400x300",
      },
    ],
    Shirts: [
      {
        name: "Graphic Tee",
        price: "19.99",
        description: "Trendy graphic t-shirt for everyday wear.",
        image: "https://via.placeholder.com/400x300",
      },
      {
        name: "Dress Shirt",
        price: "49.99",
        description: "Elegant dress shirt for formal occasions.",
        image: "https://via.placeholder.com/400x300",
      },
    ],
  };
  return (
    <div className="min-h-screen bg-white p-8">
      {/* Main Header */}
      <header className=" w-[100%] mb-8 flex justify-between ">
        <h1 className="text-[70px] font-semibold text-gray-800">
          Hello, {user.name}!
        </h1>

        <button
          className=" bg-black w-[100px] font-semibold
           h-[60px] text-[15px] text-white rounded-[10px] p-[5px] "
          onClick={HandleProductButton}
        >
          {" "}
          Add Product{" "}
        </button>
      </header>

      {/* Categories and Products */}
      <div className="space-y-8">
        {Object.entries(categories).map(([category, products]) => (
          <div key={category}>
            {/* Category Header */}
            <h2 className="text-2xl font-semibold text-gray-800 mb-4">
              {category}
            </h2>
            {/* Products Grid */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
              {products.map((product, index) => (
                <ProductCard key={index} product={product} />
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
