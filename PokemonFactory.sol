// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Hability[] habilities;
    Type[] types;
    Weekness[] weeknesses;
  }

  struct Hability {
    string name;
    string description;
  }
  
  struct Type {
    string name;
  }

  struct Weekness {
    string name;
  }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount; 
  mapping (uint => uint) public pokemonIdtoIndex; // match pokemon index with position array


  function createPokemon (uint _id, string memory _name) public {
    require(_id > 0, "The _id have to me greater than 0");
    require(bytes(_name).length == 0 || bytes(_name).length > 2, "The _name could not be empty or less than 2 chars");
    pokemonIdtoIndex[_id] = pokemons.length;
    Pokemon storage poke = pokemons.push();
    poke.id = _id;
    poke.name = _name;
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit eventNewPokemon(poke);
  }

  function addHability(uint _id, string memory _name, string memory _description) public {
    require(_id > 0, "The _id have to me greater than 0");
    require(bytes(_name).length == 0 || bytes(_name).length > 2, "The _name could not be empty or less than 2 chars");
    uint pokemonIndex = pokemonIdtoIndex[_id];
    Hability storage newHability = pokemons[pokemonIndex].habilities.push();
    newHability.name = _name;
    newHability.description = _description;
    emit eventNewHability(_id, newHability);
  }
  
  function addType(uint _id, string memory _name) public {
    require(_id > 0, "The _id have to me greater than 0");
    require(bytes(_name).length == 0 || bytes(_name).length > 2, "The _name could not be empty or less than 2 chars");
    uint pokemonIndex = pokemonIdtoIndex[_id];
    Type storage newType = pokemons[pokemonIndex].types.push();
    newType.name = _name;
    emit eventNewType(_id, newType);
  }

  function addWeekness(uint _id, string memory _name) public {
    require(_id > 0, "The _id have to me greater than 0");
    require(bytes(_name).length == 0 || bytes(_name).length > 2, "The _name could not be empty or less than 2 chars");
    uint pokemonIndex = pokemonIdtoIndex[_id];
    Weekness storage newWeekness = pokemons[pokemonIndex].weeknesses.push();
    newWeekness.name = _name;
    emit eventNewWeekness(_id, newWeekness);
  }
  

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getPokemon(uint _pokemonId) public view returns (Pokemon memory){
    require(_pokemonId > 0, "The _id have to me greater than 0");
    uint pokemonIndex = pokemonIdtoIndex[_pokemonId];
    return pokemons[pokemonIndex];
  }


  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }

  event eventNewPokemon(Pokemon pokemon);
  event eventNewHability(uint pokemonId, Hability hability);
  event eventNewWeekness(uint pokemonId, Weekness weekness);
  event eventNewType(uint pokemonId, Type newType);

}
