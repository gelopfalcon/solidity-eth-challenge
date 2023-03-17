const { expect } = require('chai');

describe('Pokemon contract', function () {

    // const [owner] = await ethers.getSigners(); // esta funcion realiza la creacion de pokemons en la blockchain
   // it('Pokemos Factory Shouldn pokemons', async function () {

    //   const PokemonFactory = await ethers.getContractFactory('PokemonFactory');
    // const pokemonFactory = await PokemonFactory.deploy();
    // await pokemonFactory.deployed();

    //const pokemons = await pokemonFactory.getAllPokemons();
    // expect(pokemons.length).to.equal(0);
  //});


it('Pokemos create', async function () {
   
    const [owner] = await ethers.getSigners(); 
    const PokemonFactory = await ethers.getContractFactory('PokemonFactory');
    const pokemonFactory = await PokemonFactory.deploy();
    await pokemonFactory.deployed();

    await pokemonFactory.createPokemon(  _id=[ 1 ], _name='pikachu',  _Type=[ 3 ], _Weaknesses=[ 1, 10 ]);
    await pokemonFactory.createPokemon(  _id=[ 2 ], _name='charmander',  _Type=[ 0 ], _Weaknesses=[ 1, 12 ]);
    const pokemons = await pokemonFactory.getAllPokemons();
    expect(pokemons.length).to.equal(2);
});

});