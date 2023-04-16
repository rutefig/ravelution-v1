import { ethers } from "hardhat";
import { expect } from "chai"
import { Contract, Signer } from "ethers";
import { Ravelution } from "../typechain-types";

describe("Ravelution", () => {
  let owner: Signer;
  let user: Signer;
  let contract: Ravelution;

  beforeEach(async () => {
    [owner, user] = await ethers.getSigners();
    const danceTimeRequiredInSeconds = 60 * 60 * 3; // 3 hours

    const contractFactory = await ethers.getContractFactory("Ravelution");
    contract = await contractFactory.deploy(danceTimeRequiredInSeconds);
    await contract.deployed();
  });

  it("should allow user to collect his rewards after dancing for more than required dance time", async () => {
    const userAddress = await user.getAddress();
    const userConnection = contract.connect(user)
    await userConnection.collect(60 * 60 * 4, { from: userAddress });
    const userBalance = await contract.balanceOf(userAddress)
    console.log(userBalance)
    expect(userBalance).to.equal(1)
  });
});
