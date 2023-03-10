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
    string[] types;
    string[] debilities;
  }

  string[] public Types = ['Normal', 'Fire', 'Water', 'Grass', 'Flying', 'Fighting', 'Poison', 'Electric', 'Ground', 'Rock', 'Psychic', 'Ice', 'Bug', 'Ghost', 'Steel', 'Dragon', 'Dark', 'Fairy'];

  Pokemon[] private pokemons;
  Ability[] private abilities;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;

  event eventNewPokemon(
    uint id,
    string name
  );

  function createPokemon (string memory _name, uint _id, uint8[] memory _abilities, uint8[] memory _types, uint8[] memory _debilities) public {
    require(_id > 0, "El Id debe ser mayor a 0");
    require(bytes(_name).length != 0, "El nombre no puede estar vacio");
    require(bytes(_name).length > 2, "El nombre debe ser mayor a 2 caracteres");
    Pokemon storage p = pokemons.push();
    for(uint i = 0; i < _abilities.length; i++){
      p.abilities.push(abilities[i]);
    }
    for(uint i = 0; i < _types.length; i++){
      p.types.push(Types[_types[i]]);
    }
    for(uint i = 0; i < _debilities.length; i++){
      p.debilities.push(Types[_debilities[i]]);
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
