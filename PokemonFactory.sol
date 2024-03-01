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

    event eventNewPokemon(Pokemon _pokemon);

    function createPokemon (string memory _name, uint _id, string[] memory _abilitiesName, string[] memory _abilitiesDescription) public {
        require(_id > 0, "El id ingresado debe ser mayor a 0");
        require(bytes(_name).length >= 2, "El nombre del Pokemon debe tener mas de dos careacteres");
        uint index=pokemons.length;
        pokemons.push();
        pokemons[index].name=_name;
        pokemons[index].id=_id;
        addAbilitiesPokemon(index, _abilitiesName, _abilitiesDescription);
        emit eventNewPokemon(pokemons[index]);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
    }

    function addAbilitiesPokemon(uint _index, string[] memory _abilitiesName, string[] memory _abilitiesDescription) private {
      for(uint i=0; i < _abilitiesName.length; i++) {
        pokemons[_index].abilities.push(
          Ability(_abilitiesName[i], _abilitiesDescription[i])
        );
      }
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
