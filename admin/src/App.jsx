import { BrowserRouter as Router, Route, Routes, Link } from "react-router-dom";
import Home from "./screens/HomePage";
import SignPage from "./screens/SignUp";
import ProductPage from "./screens/ProductPage";
import AddProduct from "./screens/AddProductPage";
import { UserProvider } from './hooks/UserContext';
import SignUp from "./screens/SignIn";

function App() {
  return (
    <>
    
    <UserProvider>
    <Router>
        <Routes>
          <Route path="/" element={<SignUp />} />
          <Route path="/home" element={<Home />} />
          <Route path="/ProductPage" element={<ProductPage />} />
          <Route path="/AddProduct" element={<AddProduct />} />
          <Route path="/Signup" element={<SignPage/>} />
        </Routes>
      </Router>

    </UserProvider>

    </>
  );
}

export default App;