require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const key = process.env.GOERLI_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/aepOKNDTIBLPdK9IDN0-iRhMqVf2yC59",
      accounts: [key],
    },
  },
};
