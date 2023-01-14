require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "mumbai",
  networks: {
    mumbai: {
      url: "https://polygon-mumbai.g.alchemy.com/v2/eyoxJkmZpXOfJmP_SfhY8zBmGrTmAWIj",
      accounts: ["a7302f7b6ebaf0a78643ec610f30185fa058ba45ef137ba99fdcd4b07af858c1"],
    }
  }
};
