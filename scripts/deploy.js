const hre = require("hardhat");
const { run } = require("hardhat")
async function main() {
  const ETHPool = await hre.ethers.getContractFactory("ETHPool");
  const ethpool = await ETHPool.deploy();
  await ethpool.deployed();

  console.log("ETHPool deployed to:", ethpool.address);
  
  const address = ethpool.address;

  // Verify Contract
  const args = [];
  // Verify Contract
  await run("verify:verify", {
    address: address,
    constructorArguments: args,
    contract: "contracts/ETHPool.sol:ETHPool"
 });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});


  