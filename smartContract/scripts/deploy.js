const { ethers } = require("hardhat");
const hre = require("hardhat");

async function main() {
  const SuperMarioWorld=await ethers.getContractFactory("SuperMarioWorld");
  const superMarioWorld=await SuperMarioWorld.deploy("SuperMarioWorld","SPRM");
  await superMarioWorld.deployed();
  console.log("Success! Contract Deployed to: ", superMarioWorld.address);

  await superMarioWorld.mint("https://ipfs.io/ipfs/QmZmTHwhbiPgXA7Se78MdChDzMt6omLa7uqWQgP1DFN7tY")
  console.log("Success! NFT Minted");
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
