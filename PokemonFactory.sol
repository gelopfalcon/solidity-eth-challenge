// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
  } 
  struct Ability {
      string name;
      string description;
  }
  Pokemon[] private pokemons;
  event eventNewPokemon(
        uint id,
        string name
    );
  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
// VALIDATIONS
  modifier validPokemon(string memory _name ,uint _id){
    require(_id > 0, "El Id debe ser mayor de 0");
    bytes memory strinCheck = bytes(_name);
    require(strinCheck.length != 0,"El nombre no debe ser vacio");
    require(strinCheck.length > 2,"La longitud del nombre debe ser mayor de 2");
    _;
  }
//////////////
//
  function createPokemon (string memory _name, uint _id, Ability[] memory _abilities) validPokemon(_name, _id) public {
  
      Pokemon storage pokemon = pokemons.push();
      pokemon.id = _id;
      pokemon.name = _name;
      for (uint i = 0; i <_abilities.length; i++) {
        pokemon.abilities.push(Ability(_abilities[i].name, _abilities[i].description));
      }
  
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(_id, _name);
  }

// VIEWS
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


