// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Habilities {
    string name;
    string description;
  }

  struct Pokemon {
    uint8 id;
    string name;
    Habilities[] habilities;
    string[] types;
    string[] weaknesses;
  }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint8) ownerPokemonCount;

  event eventNewPokemon(string _pokemonName);

  function createPokemon (string memory _name, uint8 _id) public {
    require (_id > 0, "el id debe ser mayor a 0" );
    require(bytes(_name).length, "el nombre debe contener mas de 2 caracteres");
    pokemons.push(Pokemon(_id, _name));
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;

    emit eventNewPokemon(_name);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function addHabilityById(uint8 _id, string memory _hability, string memory _description) public {
    for(uint8 i = 0; i < pokemons.length; i++){
      if(pokemons[i].id == _id){
        pokemons[i].habilities.push(Habilities(_hability, _description));
      }
    }
  }

  function addTypeById(uint8 _id, string memory _type) public {
    for(uint8 i = 0; i < pokemons.length; i++){
      if(pokemons[i].id == _id){
        pokemons[i].types.push(Habilities(_type));
      }
    }
  }

  function addWeaknessById(uint8 _id, string memory _weakness) public {
    for(uint8 i = 0; i < pokemons.length; i++){
      if(pokemons[i].id == _id){
        pokemons[i].weaknesses.push(_weakness);
      }
    }
  }

  function getResult() public pure returns(uint8 product, uint8 sum){
    uint8 a = 1; 
    uint8 b = 2;
    product = a * b;
    sum = a + b; 
  }

}
