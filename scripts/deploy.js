const { ethers, network } = require("hardhat");

async function main() {
  const ThePuffersPass = await ethers.getContractFactory("ThePuffersPass");
  console.log("Deploying contract...");

  const thePuffersPass = await ThePuffersPass.deploy(
    "https://gateway.pinata.cloud/ipfs/QmdGfgN2P1RgN3gJyg8zdGQTu6ezedPoDQBJqUmvcfw1r9/"
  );
  await thePuffersPass.deployed();
  console.log(`Deployed contract to: ${thePuffersPass.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
