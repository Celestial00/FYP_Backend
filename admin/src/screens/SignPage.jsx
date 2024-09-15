import { useContext, useEffect, useState } from "react";
import React from "react";
import { UserContext } from "../hooks/UserContext";

import {useNavigate} from 'react-router-dom'

export default function SignPage() {
  const [Email, setEmail] = useState("");
  const [Password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const { user, addUser } = useContext(UserContext);
  const Navigate = useNavigate()




  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch("http://localhost:5000/auth", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          Email,
          Password,
        }),
      });

      const data = await response.json();

      if (response.ok) {
        console.log("Login successful", data);    
        addUser(data.user)
        
        Navigate('/home')
   
        
      } else {
        console.error("Login failed", data);
        setError(data.error || "Authentication failed");
      }
    } catch (err) {
      console.error("An error occurred", err);
      setError("An error occurred");
    }
  };

  return (
    <div className="flex items-center justify-center min-h-screen bg-white">
      <div className="w-full max-w-md p-8 rounded-xl">
        <h1 className="text-3xl font-semibold text-center mb-6 text-gray-800">
          Sign In
        </h1>
        {error && <p className="text-red-500 text-center">{error}</p>}
        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label
              htmlFor="Email"
              className="block text-sm font-medium text-gray-700"
            >
              Admin Id
            </label>
            <input
              id="Email"
              type="text"
              value={Email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full mt-1 p-3 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
              placeholder="Enter your Email"
              required
            />
          </div>
          <div>
            <label
              htmlFor="password"
              className="block text-sm font-medium text-gray-700"
            >
              Password
            </label>
            <input
              id="Password"
              type="Password"
              value={Password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full mt-1 p-3 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
              placeholder="Enter your password"
              required
            />
          </div>
          <button
            type="submit"
            className="w-full py-3 px-4 bg-black text-white font-semibold rounded-[10px] hover:bg-gray-800 transition duration-200"
          >
            Sign In
          </button>
        </form>
      </div>
    </div>
  );
}
