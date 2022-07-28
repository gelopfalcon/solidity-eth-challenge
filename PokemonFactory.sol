// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory{

  struct Pokemon {
    uint256 id;
    string name;
    Type[] types;
    Ability[] abilities;
    Weakness[] weaknesses;
  }

  struct Ability{
    string name;
    string description;
  }

  struct Weakness{
    string name;
  }

  struct Type{
    string name;
  }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) public ownerPokemonCount;

  event newPokemon(uint id, string name);

  modifier validateData(uint _id, string memory _name){
    require(
      _id > 0, "Id must be greater than 0"
    );
    require(
      bytes(_name).length > 2 || bytes(_name).length == 0, "Name must be declared and bigger than 2 characters"
    );
    _;
  }

  function createPokemon(uint _id, string memory _name, string memory _abilityName, string memory _abilityDescription, string memory _weaknessName, string memory _typeName) public validateData(_id, _name){
    pokemons.push();
    uint _index = pokemons.length -1;
    pokemons[_index].id = _index;
    pokemons[_index].name = _name;
    addAbility(_index, _abilityName, _abilityDescription);
    addType(_index, _typeName);
    addWeakness(_index, _weaknessName);
    pokemonToOwner[_index] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit newPokemon(_id, _name);
  }

  function addType(uint _id, string memory _typeName) public {
    pokemons[_id].types.push(Type(_typeName));
  }

  function addAbility(uint _id, string memory _abilityName, string memory _abilityDescription) public{
    pokemons[_id].abilities.push(Ability(_abilityName, _abilityDescription));
  }

  function addWeakness(uint _id, string memory _weaknessName) public {
    pokemons[_id].weaknesses.push(Weakness(_weaknessName));
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

}
