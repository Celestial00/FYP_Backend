// src/context/UserContext.js

import React, { createContext, useState } from 'react';


// Create a Context object
const UserContext = createContext();

// Create a Provider component
const UserProvider = ({ children }) => {
  const [user, setUsers] = useState({
    id: "",
    name: "default",
    sigined: false,
    
  });

  // Function to add a user
  const addUser = (user) => {
    setUsers({Signed: true, name: user.Name }); // Generate a unique ID for each user
  };

  // Function to delete a user
  const deleteUser = (userId) => {
    setUsers({});
  };

  return (
    <UserContext.Provider value={{ user, addUser, deleteUser }}>
      {children}
    </UserContext.Provider>
  );
};

export { UserContext, UserProvider };