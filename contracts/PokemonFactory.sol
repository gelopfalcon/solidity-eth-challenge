// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) public ownerPokemonCount;
    mapping (address => mapping(uint => Pokemon)) ownedPokemons;

    function createPokemon (string memory _name) public {
      uint id = pokemons.length;
      pokemons.push(Pokemon(id, _name));
      pokemonToOwner[id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      ownedPokemons[msg.sender][ownerPokemonCount[msg.sender]] = pokemons[id];
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getOwnedPokemons() public view returns (Pokemon[] memory) {
      uint counter = ownerPokemonCount[msg.sender];

      Pokemon[] memory ownedPokemonsArr = new Pokemon[](counter);
      for(uint8 i=0; i<counter; i++) {
        ownedPokemonsArr[i] = ownedPokemons[msg.sender][i+1];
      }
      return ownedPokemonsArr;
    }
}
