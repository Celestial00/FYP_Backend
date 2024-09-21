import { useContext, useEffect, useState } from "react";
import React from "react";
import { UserContext } from "../hooks/UserContext";
import { useNavigate, Link } from "react-router-dom";
import { AiOutlineEye, AiOutlineEyeInvisible } from "react-icons/ai"; // Importing eye icons

export default function SignUp() {
  const [Name, setName] = useState(""); // State for Name
  const [Email, setEmail] = useState("");
  const [Password, setPassword] = useState("");
  const [RetypePassword, setRetypePassword] = useState("");
  const [error, setError] = useState(null);
  const [passwordMatchError, setPasswordMatchError] = useState(null);
  const [showPassword, setShowPassword] = useState(false); // State to toggle password visibility
  const [showRetypePassword, setShowRetypePassword] = useState(false); // State to toggle retype password visibility
  const { user, addUser } = useContext(UserContext);
  const Navigate = useNavigate();

  // Function to check if passwords match in real-time
  useEffect(() => {
    if (Password !== RetypePassword) {
      setPasswordMatchError("Passwords do not match");
    } else {
      setPasswordMatchError(null);
    }

    if(user.sigined){

      Navigate('/home')

    }


  }, [RetypePassword]);

  const handleSubmit = async (e) => {
    e.preventDefault();

    // Ensure passwords match before sending the form
    if (Password !== RetypePassword) {
      setError("Passwords do not match");
      return;
    }

    try {
      const response = await fetch("http://localhost:5000/auth/signUp", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          Name,
          Email,
          Password,
        }),
      });

      const data = await response.json();

      if (response.ok) {
        console.log("Sign Up successful", data);
        Navigate("/signIn");
      } else {
        console.error("Sign Up failed", data);
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
          Sign Up
        </h1>
        {error && <p className="text-red-500 text-center">{error}</p>}
        <form onSubmit={handleSubmit} className="space-y-6">
          <div>
            <label htmlFor="Name" className="block text-sm font-medium text-gray-700">
              Name
            </label>
            <input
              id="Name"
              type="text"
              value={Name}
              onChange={(e) => setName(e.target.value)}
              className="w-full mt-1 p-3 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
              placeholder="Enter your Name"
              required
            />
          </div>

          <div>
            <label htmlFor="Email" className="block text-sm font-medium text-gray-700">
              Email
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

          <div className="relative">
            <label htmlFor="Password" className="block text-sm font-medium text-gray-700">
              Password
            </label>
            <input
              id="Password"
              type={showPassword ? "text" : "password"} // Toggling between text and password
              value={Password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full mt-1 p-3 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
              placeholder="Enter your password"
              required
            />
            <span
              onClick={() => setShowPassword(!showPassword)} // Toggle password visibility
              className="absolute top-[38px] right-4 cursor-pointer"
            >
              {showPassword ? (
                <AiOutlineEye className="text-xl" />
              ) : (
                <AiOutlineEyeInvisible className="text-xl" />
              )}
            </span>
          </div>

          <div className="relative">
            <label htmlFor="RetypePassword" className="block text-sm font-medium text-gray-700">
              Retype Password
            </label>
            <input
              id="RetypePassword"
              type={showRetypePassword ? "text" : "password"} // Toggling between text and password
              value={RetypePassword}
              onChange={(e) => setRetypePassword(e.target.value)}
              className="w-full mt-1 p-3 border border-gray-300 rounded-[10px] bg-white text-gray-900 focus:outline-none focus:ring-2 focus:ring-black"
              placeholder="Retype your password"
              required
            />
            <span
              onClick={() => setShowRetypePassword(!showRetypePassword)} // Toggle retype password visibility
              className="absolute top-[38px] right-4 cursor-pointer"
            >
              {showRetypePassword ? (
                <AiOutlineEye className="text-xl" />
              ) : (
                <AiOutlineEyeInvisible className="text-xl" />
              )}
            </span>
          </div>

          {passwordMatchError && (
            <p className="text-red-500 text-center">{passwordMatchError}</p>
          )}

          <button
            type="submit"
            className="w-full py-3 px-4 bg-black text-white font-semibold rounded-[10px] hover:bg-gray-800 transition duration-200"
          >
            Sign Up
          </button>

          <Link className="text-center ml-[100px] mt-[100px]" to="/">
          Signed up? Click here to login
          
          </Link>
        </form>
      </div>
    </div>
  );
}
