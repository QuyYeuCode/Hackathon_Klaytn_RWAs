import classNames from "classnames/bind";
import styles from "./header.module.scss";
import { useState, useEffect } from "react";
import { ethers } from "ethers";
import { Link } from "react-router-dom";
const cx = classNames.bind(styles);
function Header() {
  const connectWallet = async () => {
    if (typeof window != "undefined" && typeof window.ethereum != "undefined") {
      try {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccount",
        });
        console.log(accounts[0]);
      } catch (error) {
        console.log.error(error.massage);
      }
    } else {
      console.log("Not install Metamask!!! Please install Wallet");
    }
  };
  return (
    <div className={cx("header_app")}>
      <div className={cx("header")}>
        <div className={cx("header_left")}>
          <svg
            width="35"
            height="40"
            viewBox="0 0 35 40"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            id="svg963199498_1349"
          >
            <path
              d="M30.4054 19.7436C27.2155 23.3076 22.5799 25.5506 17.4205 25.5506C12.261 25.5506 7.62542 23.3076 4.43555 19.7436C7.62542 16.1796 12.261 13.9367 17.4205 13.9367C22.5799 13.9367 27.2155 16.1796 30.4054 19.7436Z"
              fill="white"
            ></path>
            <path
              fillRule="evenodd"
              clipRule="evenodd"
              d="M0 31.3575C0 21.7362 7.79956 13.9367 17.4208 13.9367C12.2613 13.9367 7.62579 16.1796 4.43592 19.7436C7.62579 23.3076 12.2614 25.5506 17.4208 25.5506C22.5803 25.5506 27.2159 23.3076 30.4058 19.7436C33.1643 22.8257 34.8416 26.8957 34.8416 31.3575V37.9387C34.8416 38.7939 34.1483 39.4872 33.2931 39.4872H1.54852C0.693294 39.4872 0 38.7939 0 37.9387V31.3575ZM30.4058 19.7436C30.4058 19.7436 30.4057 19.7436 30.4058 19.7436Z"
              fill="#87C5FF"
            ></path>
            <path
              fillRule="evenodd"
              clipRule="evenodd"
              d="M10.8865 24.2836C8.39901 23.2764 6.19711 21.7114 4.43592 19.7436C7.62578 16.1796 12.2614 13.9367 17.4208 13.9367C22.5803 13.9367 27.2159 16.1796 30.4057 19.7436C30.4057 19.7436 30.4058 19.7436 30.4057 19.7436C33.1643 16.6615 34.8416 12.5915 34.8416 8.12972V1.54852C34.8416 0.693299 34.1483 2.91058e-06 33.2931 2.91058e-06L1.54852 0C0.693296 -7.47655e-08 6.50112e-07 0.693295 5.75347e-07 1.54852L0 8.12972C-1.15719e-06 15.4402 4.50293 21.6989 10.8865 24.2836Z"
              fill="#0084FF"
            ></path>
          </svg>
        </div>
        <div className={cx("header_right")}>
          <div className={cx("benefits")}>
            <a href="/#benefits">Benefits</a>
          </div>
          <div onclick={connectWallet} className={cx("login")}>
            Connect To Wallet
          </div>
        </div>
      </div>
    </div>
  );
}
export default Header;
