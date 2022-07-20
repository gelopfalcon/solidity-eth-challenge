// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  event eventNewPokemon(Pokemon pokemon);

  struct Pokemon {
    uint256 id;
    string name;
    Ability[] abilities;
  }

  struct Ability {
    string name;
    string description;
  }

  Pokemon[] public pokemons;

  mapping(uint => address) public pokemonToOwner;
  mapping(address => uint256) public ownerPokemonCount;
  mapping(address => mapping(uint => Pokemon)) ownedPokemons;

  function createPokemon(string memory _name, string[] memory _abilityName, string[] memory _abilityDscription) public {
    require(bytes(_name).length > 2, "The name must have at least 2 characters.");
    require((_abilityName).length == (_abilityDscription).length, "You have to provide the same number of abilitie and description.");
    
    uint id = pokemons.length;
    require(bytes((_abilityName)[id]).length > 3, "The name must have at least 3 characters.");
    require(bytes((_abilityDscription)[id]).length > 5, "The description must have at least 5 characters.");
    
    pokemons.push();
    pokemons[id].id = id;
    pokemons[id].name = _name;

    for(uint i=0; i<_abilityName.length; i++) {
      pokemons[id].abilities.push(
        Ability(_abilityName[i], _abilityDscription[i])
      );
    }

    pokemonToOwner[id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit eventNewPokemon(pokemons[id]);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getOwnedPokemons() public view returns (Pokemon[] memory) {
    uint256 counter = ownerPokemonCount[msg.sender];

    Pokemon[] memory ownedPokemonsArr = new Pokemon[](counter);
    for (uint8 i = 0; i < counter; i++) {
        ownedPokemonsArr[i] = ownedPokemons[msg.sender][i + 1];
    }
    return ownedPokemonsArr;
  }
}