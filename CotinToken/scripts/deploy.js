const hre = require("hardhat");

async function main() {
  const CotinToken = await hre.ethers.getContractFactory("CotinToken");
  const cotinToken = await CotinToken.deploy(1000000000, 25, 575000000);

  await cotinToken.deployed();

  console.log("Cotin deployed: ", cotinToken.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
