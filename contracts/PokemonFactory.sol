// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  event eventNewPokemon(uint256 id, string name);

  struct Pokemon {
    uint256 id;
    string name;
  }

  Pokemon[] private pokemons;

  mapping(uint256 => address) public pokemonToOwner;
  mapping(address => uint256) public ownerPokemonCount;
  mapping(address => mapping(uint256 => Pokemon)) ownedPokemons;

  function createPokemon(string memory _name) public {
    require(bytes(_name).length > 2, "The name must have at least 2 characters.");
    uint256 id = pokemons.length;
    pokemons.push(Pokemon(id, _name));
    pokemonToOwner[id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    ownedPokemons[msg.sender][ownerPokemonCount[msg.sender]] = pokemons[id];
    emit eventNewPokemon(id, _name);
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