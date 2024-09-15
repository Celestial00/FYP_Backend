import { BrowserRouter as Router, Route, Routes, Link } from "react-router-dom";
import Home from "./screens/HomePage";
import SignPage from "./screens/SignPage";
import ProductPage from "./screens/ProductPage";
import AddProduct from "./screens/AddProductPage";
import { UserProvider } from './hooks/UserContext';

function App() {
  return (
    <>
    
    <UserProvider>
    <Router>
        <Routes>
          <Route path="/" element={<SignPage />} />
          <Route path="/home" element={<Home />} />
          <Route path="/ProductPage" element={<ProductPage />} />
          <Route path="/AddProduct" element={<AddProduct />} />
        </Routes>
      </Router>

    </UserProvider>

    </>
  );
}

export default App;