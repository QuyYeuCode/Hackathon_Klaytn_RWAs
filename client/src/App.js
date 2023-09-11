import { Route, Routes } from "react-router-dom";
import Home from "./component/Home";
import Login from "./component/Login";
import Borrower from "./component/Borrower";
import Lender from "./component/Lender";
import Header from "./component/header";
import Footer from "./component/footer";
import abi from "../src/contracts/Lending.json";
import { useState, useEffect } from "react";
import { ethers } from "ethers";

// NOTE: Make sure to change this to the contract address you deployed
const LendingContractAddress = "";
// ABI so the web3 library knows how to interact with our contract
const LendingContractAbi = abi.abi;

function App() {
  return (
    <div className="App">
      <Header />
      <Routes>
        <Route path="/" element={<Home className="home" />} />
        <Route path="/login" element={<Login className="login" />} />
        <Route path="/lender" element={<Lender />} />
        <Route path="/borrower" element={<Borrower />} />
      </Routes>
      <Footer />
    </div>
  );
}

export default App;
