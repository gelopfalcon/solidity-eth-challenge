// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

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

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
    Type[] types;
    Weakness[] weaknesses;
  }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;

  event eventNewPokemon(string _name, uint _id);

  function createPokemon (string memory _name, uint _id) public {
    require(_id > 0, "El ID debe ser mayor a 0");
    require(bytes(_name).length != 0,"Requiere un nombre");
    require(bytes(_name).length > 2, "Requiere que el nombre sea mayor a 2 caracteres");

    Pokemon storage _pokemon = pokemons.push();
    _pokemon.id = _id;
    _pokemon.name = _name;
 
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;

    emit eventNewPokemon(_name,_id);
  }

  function addAbility (uint _id, string memory _name, string memory _description) public  {
    require(bytes(_name).length != 0,"Requiere un nombre");
    require(bytes(_description).length != 0,"Requiere una descripcion");

    uint _indexPokemon = getIndex(_id);

    pokemons[_indexPokemon].abilities.push(Ability(_name, _description));
  }

  function addType (uint _id, string[] memory _types) public  {
    require(_types.length > 0, "Los tipos deben ser mayores que 0");

    uint _indexPokemon = getIndex(_id);

    for(uint i = 0; i <_types.length; i++){
      pokemons[_indexPokemon].types.push(Type(_types[i]));
    }
  }
  
  function addWeakness (uint _id, string[] memory _weaknesses) public  {
    
    require(_weaknesses.length > 0, "Las debilidades deben ser mayores que 0");

    uint _indexPokemon = getIndex(_id);

    for(uint i = 0; i <_weaknesses.length; i++){
      pokemons[_indexPokemon].types.push(Type(_weaknesses[i]));
    }
    
  }

  function getIndex(uint _id) private view returns (uint) {
    for(uint i = 0; i <pokemons.length; i++){
      if (pokemons[i].id == _id) {
        return i;
      }
    }
  }

  function getPokemon(uint _id) public view returns (Pokemon memory) {
    for(uint i = 0; i <pokemons.length; i++){
      if (pokemons[i].id == _id) {
        return pokemons[i];
      }
    }
  }
  
  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

}
