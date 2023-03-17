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

    const tx = await pokemonFactory.createPokemon(  _id=[ 1 ], _name='pikachu',  _Type=[ 3 ], _Weaknesses=[ 1, 10 ], _Evolutions=[ 0, 1 ]);
    await pokemonFactory.pokemonEvolution(  _id=[ 1 ], _index=[ 0 ], _name='trueno',  _description="poder del trueno");
    await pokemonFactory.pokemonEvolution(  _id=[ 1 ], _index=[ 1 ], _name='rayo',  _description="poder del rayo");
    const rc = await tx.wait(); // 0ms, as tx is already confirmed
    const event = rc.events.find(event => event.event === 'eventNewPokemon');
    const [from, value] = event.args;
    console.log(from, value);

    const tx2 =await pokemonFactory.createPokemon(  _id=[ 2 ], _name='charmander',  _Type=[ 0 ], _Weaknesses=[ 1, 12 ], _Evolutions=[ 0, 1 ]);
    await pokemonFactory.pokemonEvolution(  _id=[ 2 ], _index=[ 0 ], _name='fuego',  _description="poder del fuego");
    await pokemonFactory.pokemonEvolution(  _id=[ 2 ], _index=[ 1 ], _name='llamas',  _description="poder de las llamas");
    const rc2 = await tx2.wait(); // 0ms, as tx is already confirmed
    const event2 = rc2.events.find(event2 => event2.event === 'eventNewPokemon');
    const [from2, value2] = event2.args;
    console.log(from2, value2);
    
    const pokemons = await pokemonFactory.getAllPokemons();
    expect(pokemons.length).to.equal(2);
});

});