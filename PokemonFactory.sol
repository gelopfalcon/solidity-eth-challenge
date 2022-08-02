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

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon (Pokemon pokemon);

    function createPokemon (string memory _name, uint _id, Ability[] memory _abilities) public {
      require(_id > 0, "Pokemon's id should be greater than 0");     
      require(bytes(_name).length > 2, "Pokemon's name should have more that two characters.");
      Pokemon storage pokemon = pokemons.push();
      pokemon.id = _id;
      pokemon.name = _name;
      for (uint i = 0; i < _abilities.length; i++) {
          pokemon.abilities.push(_abilities[i]);
      }
      
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon (pokemon);
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
