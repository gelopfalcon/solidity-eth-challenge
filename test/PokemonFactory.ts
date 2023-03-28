import { expect } from "chai";
import { ethers } from "hardhat";
import { PokemonFactory } from "../typechain-types";

describe("Deployment", async () => {
  let PokemonContract: PokemonFactory;

  beforeEach(async () => {
    const Contract = await ethers.getContractFactory("PokemonFactory");
    PokemonContract = await Contract.deploy();
    await PokemonContract.deployed();
  });
  it("Should get the correct result", async () => {
    expect((await PokemonContract.getResult()).product).to.equal(2);
  });
  it("Should can not create a new Pokemon", async () => {
    await expect(
      PokemonContract.createPokemon("Pikachu", 0)
    ).to.be.revertedWith("Id must be greater than 0");
  });
});
