import React, { useEffect, useState } from "react";
import ProductCard from "../components/product";
import { useNavigate } from "react-router-dom";
import Cookies from "js-cookie"; // Importing js-cookie

export default function HomePage() {
  const navigate = useNavigate();
  const [Data, setData] = useState(null);
  const [userId, setUserId] = useState("");
  const [products, setProducts] = useState([]);
  const [error, setError] = useState(null);

  const loadFromCookies = () => {
    const savedUser = Cookies.get("userData");

    if (savedUser) {
      const uData = JSON.parse(savedUser);
      setData(uData);
      setUserId(uData.id);
    } else {
      alert("No user found in cookies!");
      navigate("/"); // Redirect if no user found
    }
  };

  useEffect(() => {
    loadFromCookies();
  }, []);

  useEffect(() => {
    if (Data) {
      console.log(Data);
      fetchProducts();
    }
  }, [Data]);

  const HandleProductButton = () => {
    navigate("/addproduct");
  };

  const HandleSignOutButton = () => {
    Cookies.remove("userData"); // Remove user data cookie
    navigate("/");
  };

  const fetchProducts = async () => {
    try {
      const response = await fetch(`http://localhost:5000/products/${userId}`);
      if (!response.ok) {
        throw new Error("Network response was not ok");
      }
      const data = await response.json();
      setProducts(data);
      console.log("====================================");
      console.log(data);
      console.log("====================================");
      setError(null);
    } catch (error) {
      setError(error.message);
    }
  };

  return (
    <div className="min-h-screen bg-white p-8">
      <header className="w-full mb-8 flex justify-between">
        <h1 className="text-[70px] font-semibold text-gray-800">
          Hello, {Data?.user?.Name || "User"}!
        </h1>

        <div>
          <button
            className="bg-black w-[100px] font-semibold h-[60px] text-[15px] text-white rounded-[10px] p-[5px]"
            onClick={HandleProductButton}
          >
            Add Product
          </button>

          <button
            className="ml-2 bg-black w-[100px] font-semibold h-[60px] text-[15px] text-white rounded-[10px] p-[5px]"
            onClick={HandleSignOutButton}
          >
            Sign Out
          </button>
        </div>
      </header>

      <div className="flex flex-wrap justify-start"> {/* Use Flexbox for layout */}
        {products.map((product, index) => (
          <ProductCard key={index} product={product} />
        ))}
      </div>
    </div>
  );
}
