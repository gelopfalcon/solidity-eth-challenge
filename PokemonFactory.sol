// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

  struct Ability {
    string name;
    string description;
    
  }
  struct Type {
    string name;
  }

  struct Weakness {
    string name;
  }

  struct PokemonInfo {
    uint pokemonId;
    Ability[] abilities;
    Type[] types;
    Weakness[] weaknesses;
  }

  Type[] private types;
  PokemonInfo[] private pokemonsInfo;  
  Pokemon[] private pokemons;

  mapping (address => uint) public ownerPokemonCount;
  mapping (uint => address) public pokemonIdToOwner;
  mapping (uint => PokemonInfo) pokemonIdToPokemonInfo;

  event eventNewPokemon(Pokemon pokemon);

  function createPokemon (string memory name) public returns (uint) {
      
    uint pokemonId = pokemons.length + 1; // Esta lógica hace que no sea necesario validar si el ID es mayor a 0
    require(bytes(name).length > 2 , "Nombre invalido");
    pokemons.push(Pokemon(pokemonId, name));
    pokemonIdToOwner[pokemonId] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    PokemonInfo storage pokemonInfo = (pokemonsInfo.push());
    pokemonInfo.pokemonId = pokemonId;
    pokemonIdToPokemonInfo[pokemonId] = pokemonInfo;
    emit eventNewPokemon(Pokemon(pokemonId, name));
    return pokemonId;
  }
  
  function addAbilityToPokemon(uint pokemonId, string memory name, string memory description) public {

    require(pokemonIdToOwner[pokemonId] == msg.sender, "No tienes este pokemon");
    pokemonIdToPokemonInfo[pokemonId].abilities.push(Ability(name, description));
  }

  function addATypeToPokemon(uint pokemonId, string memory name) public {

    require(pokemonIdToOwner[pokemonId] == msg.sender, "No tienes este pokemon");
    pokemonIdToPokemonInfo[pokemonId].types.push(Type(name));
  }

  function addAWeaknessToPokemon(uint pokemonId, string memory name) public {

    require(pokemonIdToOwner[pokemonId] == msg.sender, "No tienes este pokemon");
    pokemonIdToPokemonInfo[pokemonId].weaknesses.push(Weakness(name));

  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
   }

  function getAPokemonInfoByPokemonId(uint pokemonId) public view returns (PokemonInfo memory) {
    return pokemonIdToPokemonInfo[pokemonId];
  }
}