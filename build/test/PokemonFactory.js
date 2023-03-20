const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Pokemon contract", function () {
	it("Pokemon Factory shouldn't have pokemons", async function () {
		// const [owner] = await ethers.getSigners(); // Esto lo ocuparán para crear un pokemon

		const PokemonFactory = await ethers.getContractFactory(
			"PokemonFactory"
		);

		const hardhatPokemon = await PokemonFactory.deploy();

		const pokemons = await hardhatPokemon.getAllPokemons();

		expect(pokemons.length).to.equal(0);
	});
	it("Pokemon Factory should create 2 pokemons", async function () {
		const PokemonFactory = await ethers.getContractFactory(
			"PokemonFactory"
		);

		const hardhatPokemon = await PokemonFactory.deploy();

		await hardhatPokemon.createPokemon("Charizard", 1);
		await hardhatPokemon.createPokemon("Pikachu", 2);

		const pokemons = await hardhatPokemon.getAllPokemons();

		expect(pokemons.length).to.equal(2);
	});
});
