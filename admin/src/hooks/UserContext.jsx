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
  const addUser = (user, _id) => {
    let name = user.Name
    
    setUsers({ id: _id, Signed: true, name: name }); 
  };

  // Function to delete a user
  const deleteUser = () => {
    setUsers({});
  };

  const getId = () =>{

    return user

  }

  return (
    <UserContext.Provider value={{ user, addUser, deleteUser, getId }}>
      {children}
    </UserContext.Provider>
  );
};

export { UserContext, UserProvider };