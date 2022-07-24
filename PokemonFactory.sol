// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;

  event eventNewPokemon (string);

  modifier createValidation(string memory _name , uint _id ) {
    require(_id > 0, "id no debe estar vacio y tiene que ser mayor a 0");
    require(bytes(_name).length > 2, "El nombre debe ser mayor de 2 caracteres");
    _; 
  }

  function createPokemon (string memory _name, uint _id) public createValidation(_name, _id) {
    pokemons.push(Pokemon(_id, _name));
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit eventNewPokemon( _name);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }

}
