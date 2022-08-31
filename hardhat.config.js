require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      gasPrice: "auto",
      gasMultiplier: 2,
      chainId: 1337,
      allowUnlimitedContractSize: true
    },
    localhost: {
      url: "http://127.0.0.1:8545"
    },
    testnet: {
      // url: "//api-testnet.bscscan.com/api",
      url: "https://ropsten.infura.io/v3/17634bdcbec14cdcbdaffbcefbde6b17",
      chainId: 3,
      gasPrice: 20000000000,
      accounts: ["0x84a9548c2140eeeb4c657f878c08cf0b7b3dacce49a4b9c898de8307c3a102b0"]
    }
  },
  etherscan: {
    apiKey: "F9F31F8TUFD7WDMH3WN1C9BH9BVEV9D5QY"
  },
  solidity: "0.8.9",
};
