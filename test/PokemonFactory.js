const { expect } = require("chai");

describe("Pokemon contract", function() {

    it("Pokemon Factory shouldn't pokemons", async function () {

        // const [owner] = await ethers.getSigners(); // Esto lo ocuparán para crear un pokemon

        const PokemonFactory = await ethers.getContractFactory("PokemonFactory");

        const hardhatPokemon = await PokemonFactory.deploy();

        const pokemons = await hardhatPokemon.getAllPokemons();

        expect(pokemons.length).to.equal(0);

    });

    it("Pokemon Factory gets only two pokemons", async function () {
        /*
        * Reto #5
        */        
        const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
        const hardhatPokemon = await PokemonFactory.deploy();

        hardhatPokemon.createPokemon('Charmander', 1);
        hardhatPokemon.createPokemon('Charizard', 2);

        const pokemons = await hardhatPokemon.getAllPokemons();

        expect( pokemons.length ).to.equal(2);
    });    

});
