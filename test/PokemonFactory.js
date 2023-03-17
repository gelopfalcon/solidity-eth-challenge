const { expect } = require('chai');

describe('Pokemon contract', function () {

    // const ´[owner] = await ethers.getSigners(); // esta funcion realiza la creacion de pokemons en la blockchain
    it('Pokemos Factory Shouldn pokemons', async function () {

        const PokemonFactory = await ethers.getContractFactory('PokemonFactory');
        const pokemonFactory = await PokemonFactory.deploy();
        await pokemonFactory.deployed();

        const pokemons = await pokemonFactory.getAllPokemons();
        expect(pokemons.length).to.equal(0);
    });
});