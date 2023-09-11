import classNames from "classnames/bind";
import styles from "./result.module.scss";
import abi from "../src/contracts/Lending.json";
import { useState, useEffect } from "react";
import { ethers } from "ethers";
const cx = classNames.bind(styles);
const provider = new ethers.providers.Web3Provider(window.ethereum);
const signer = provider.getSigner();
const contract = new ethers.Contract("0xYourContractAddress", abi, signer);
function Results() {
  const checkLenderDeposit = async () => {};
  const Deposit = async (amount) => {
    await contract.methods.deposit(amount).send();
  };

  const handleDepositButtonClick = () => {
    const amount = document.getElementById("amount").value;
    depositMoney(amount);
  };

  document
    .getElementById("depositButton")
    .addEventListener("click", handleDepositButtonClick);
}
return (
  <div className={cx("wrapper")}>
    <div className={cx("cover")}>
      <div className={cx("content")}>
        hiển thị thông tin của mình trong này nhé
      </div>
      <button className={cx("click")}>checkLenderDeposit</button>
    </div>
    <div className={cx("cover")}>
      <div className={cx("content")}>
        <input type="text" placeholder="setInterestRate" />
      </div>
      <button className={cx("click")}>setInterestRate</button>
    </div>
    <div className={cx("cover")}>
      <div className={cx("content")}>
        <input type="text" placeholder="Deposit" />
      </div>
      <button className={cx("click")}>Deposit</button>
    </div>
    <div className={cx("cover")}>
      <div className={cx("content")}>hiển thị thông tin sau khi update</div>
      <button className={cx("click")}>updateNeedToPay</button>
    </div>
    <div className={cx("cover")}>
      <div className={cx("content")}>
        <input type="text" placeholder="withDraw" />
      </div>
      <button className={cx("click")}>withDraw</button>
    </div>
    <div className={cx("cover")}>
      <div className={cx("content")}>
        <input type="text" placeholder="Address" />
      </div>
      <button className={cx("click")}>claimToken</button>
    </div>
  </div>
);

export default Results;
