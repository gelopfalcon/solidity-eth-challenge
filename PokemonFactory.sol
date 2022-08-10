// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Ability {
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
  }

  Pokemon[] private pokemons;
  Ability[] private abilities;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;

  event eventNewPokemon(
    uint id,
    string name
  );

  function createPokemon (string memory _name, uint _id, uint[] memory _abilities) public {
    require(_id > 0, "El Id debe ser mayor a 0");
    require(bytes(_name).length != 0, "El nombre no puede estar vacio");
    require(bytes(_name).length > 2, "El nombre debe ser mayor a 2 caracteres");
    Pokemon storage p = pokemons.push();
    for(uint i = 0; i < _abilities.length; i++){
      p.abilities.push(abilities[i]);
    } 
    p.id = _id;
    p.name = _name;
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit eventNewPokemon(_id, _name);
  }

  function createAbility (string memory _name, string memory _desc) public {
    abilities.push(Ability(_name, _desc));
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

}
