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
  it("Must get the correct result", async () => {
    expect((await PokemonContract.getResult()).product).to.equal(2);
  });
  it("Must not create a new Pokemon", async () => {
    await expect(
      PokemonContract.createPokemon(
        "Pikachu",
        0,
        [{ name: "Placaje", description: "PlacajeDescription" }],
        [0],
        [0]
      )
    ).to.be.revertedWith("Id must be greater than 0");
  });
  it("Must have 2 Pokemons", async () => {
    await PokemonContract.createPokemon(
      "Pikachu",
      1,
      [{ name: "Placaje", description: "PlacajeDescription" }],
      [4],
      [8]
    );
    await PokemonContract.createPokemon(
      "Bulbassaur",
      2,
      [{ name: "LatigoCepa", description: "PlacajeDescription" }],
      [3],
      [2, 3]
    );
    expect((await PokemonContract.getAllPokemons()).length).to.be.equal(2);
  });
  /*   it("Just for explore", async () => {
    await PokemonContract.createPokemon(
      "Pikachu",
      1,
      [{ name: "Placaje", description: "PlacajeDescription" }],
      [0],
      [0]
    );
    console.log(await PokemonContract.getAllPokemons());
  }); */
});
