const {expect} = require("chai");
const { ethers } = require('hardhat');

describe('PokemonFactory', () => {
    it('should return a pokemon', async () => {
        const PokemonFactory = await ethers.getContractFactory('PokemonFactory');
        const pokemonFactory = await PokemonFactory.deploy();
        await pokemonFactory.createPokemon('pikachu',1,[0,1,2],[0,1],[0]);
        await pokemonFactory.createPokemon('charmander',2,[1,2,3],[1,2],[1,2]);
        const pokemons = await pokemonFactory.getAllPokemons();
        console.log(pokemons);
        expect(pokemons.length).to.equal(2);
    });
});