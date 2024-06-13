require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    sepolia: {
      url: process.env.INFURA_SEPOLIA_ENDPOINT,
      accounts: [process.env.PRIVATE_KEY]
    },
    lineaETH:{
      url: process.env.INFURA_LINEAETH_ENDPOINT,
      accounts: [process.env.PRIVATE_KEY]
    },
    mainnet: {
      url: process.env.INFURA_MAINNET_ENDPOINT,
      accounts: [process.env.PRIVATE_KEY]
    }
  },
  etherscan: {
  apiKey: process.env.ETHERSCAN_API_KEY
  }
}  
