require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/**
 * truffle network variables
 * for deploying contract to klaytn network.
 */
const NETWORK_ID = "1001";

/**
 * URL: URL for the remote node you will be using
 * PRIVATE_KEY: Private key of the account that pays for the transaction (Change it to your own private key)
 */
const URL = "https://api.baobab.klaytn.net:8651";

// Paste your `Private key` that has enough KLAY to truffle.js
const PRIVATE_KEY = process.env.PRIVATE_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  networks: {
    baobab: {
      url: URL,
      network_id: NETWORK_ID,

      account: [PRIVATE_KEY],
    },
  },
  solidity: "0.8.16",
};
