// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  enum PokemonType {
    Grass,
    Poison,
    Fire, 
    Flying, 
    Ice, 
    Psychic
    }
  struct Habilities {
      uint idHability;
      string nameHability;
    }
  struct Weaknesses {
      uint idWeakness;
      string nameWeakness;
    }
  struct Pokemon {
    uint id;
    string name;
    PokemonType[] pokemonType;
  }

    Pokemon[] private pokemons;

    mapping(uint => Habilities[]) public habilities;
    mapping(uint => Weaknesses[]) public weaknesses;

    event eventNewPokemon(uint id, string value);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon (uint id, string memory name, PokemonType[] memory pokemonType) public {
      require(id > 0, "Id must be greater than 0");
      require(bytes(name).length >= 2, "Pokemon name lenght must be greater than 2");
      Pokemon memory pokemon = Pokemon(id, name, pokemonType);
      pokemons.push(pokemon);
      pokemonToOwner[id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(id, name);
    }
    function addHability(uint idHability, string memory nameHability, uint id) public{
      habilities[id].push(Habilities(idHability, nameHability));
      emit eventNewPokemon(idHability, nameHability);
    }
    function addWeakness(uint idWeakness, string memory nameWeakness, uint id) public{
      weaknesses[id].push(Weaknesses(idWeakness, nameWeakness));
      emit eventNewPokemon(idWeakness, nameWeakness);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }
}
