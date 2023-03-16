const { expect } = require("chai");

describe("PokemonFactory", function () {
  let pokemonFactory;
  let owner;

  beforeEach(async function () {
    // Obtenemos la cuenta de la primera persona en el Hardhat Network
    [owner] = await ethers.getSigners();

    // Obtenemos la instancia del contrato
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    pokemonFactory = await PokemonFactory.deploy();
    await pokemonFactory.deployed();
  });

  it("Debe crear dos pokemones y validar que la fábrica tenga dos pokemones.", async function(){
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const pokemonFactory = await PokemonFactory.deploy();
    await pokemonFactory.deployed();

    const tx = await pokemonFactory.createPokemon("Bulbasaur", 1, [1, 2], ["Grass", "Poison"], ["Fire", "Flying", "Ice", "Psychic"]);
    await pokemonFactory.addHabilityToPokemon(1, 0, "Chlorophyll", "Doubles speed under sunshine");
    await pokemonFactory.addHabilityToPokemon(1, 1, "Overgrow", "Powers up Grass-type moves in a pinch");
    
    await tx.wait();
    expect(tx)
      .to.emit(pokemonFactory, "eventNewPokemon")
      .withArgs("Bulbasaur");


    await pokemonFactory.createPokemon("Charmander", 2, [3, 4], ["Fire"], ["Water", "Ground", "Rock"]);
    await pokemonFactory.addHabilityToPokemon(2, 0, "Blaze", "Powers up Fire-type moves in a pinch");
    await pokemonFactory.addHabilityToPokemon(2, 1, "Solar Power", "Powers up special attacks when sunny day is in effect");

    const pokemons = await pokemonFactory.getAllPokemons();
    expect(pokemons.length).to.equal(2);
  });  
});

// describe("PokemonFactory", function() {
//     it("Should create a new Pokemon", async function() {
//       const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
//       const pokemonFactory = await PokemonFactory.deploy();
//       await pokemonFactory.deployed();
  
//       const tx = await pokemonFactory.createPokemon("Pikachu", 1);
  
//       expect(tx)
//         .to.emit(pokemonFactory, "eventNewPokemon")
//         .withArgs("Pikachu");
//     });
// });