import { ethers } from "hardhat";

async function main() {
  const danceTimeRequiredInSeconds = 60 * 60 * 3 // 3 hours

  const contractFactory = await ethers.getContractFactory("Ravelution")

  const contract = await contractFactory.deploy(danceTimeRequiredInSeconds)

  await contract.deployed()

  console.log(`Contract deployed to ${contract.address} with dance required time as ${danceTimeRequiredInSeconds} seconds`)

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
