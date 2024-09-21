import React, { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import Cookies from 'js-cookie'; // Importing js-cookie
import { AiOutlineEye, AiOutlineEyeInvisible } from "react-icons/ai";

export default function SignUp() {
  const [Email, setEmail] = useState("");
  const [Password, setPassword] = useState("");
  const [error, setError] = useState(null);
  const [showPassword, setShowPassword] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await fetch("http://localhost:5000/auth/signIn", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ Email, Password }),
      });

      const data = await response.json();

      if (response.ok) {
        console.log("Login successful", data);
        // Save user data in cookies
        Cookies.set('userData', JSON.stringify({ user: data.user, id: data.id, signed: true }), { expires: 7 }); // expires in 7 days
        navigate('/home');
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
        <h1 className="text-3xl font-semibold text-center mb-6 text-gray-800">Sign In</h1>
        {error && <p className="text-red-500 text-center">{error}</p>}
        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label htmlFor="Email" className="block text-sm font-medium text-gray-700">Email</label>
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

          <div className="relative">
            <label htmlFor="Password" className="block text-sm font-medium text-gray-700">Password</label>
            <input
              id="Password"
              type={showPassword ? "text" : "password"}
              value={Password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full mt-1 p-3 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
              placeholder="Enter your password"
              required
            />
            <span onClick={() => setShowPassword(!showPassword)} className="absolute top-[38px] right-4 cursor-pointer">
              {showPassword ? <AiOutlineEye className="text-xl" /> : <AiOutlineEyeInvisible className="text-xl" />}
            </span>
          </div>

          <button type="submit" className="w-full py-3 px-4 bg-black text-white font-semibold rounded-[10px] hover:bg-gray-800 transition duration-200">Sign In</button>
          <Link className="text-center ml-[100px] mt-[100px]" to="/signup">Not registered? Click here to sign up</Link>
        </form>
      </div>
    </div>
  );
}
