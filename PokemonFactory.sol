// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  mapping (uint => Pokemon) public pokemons;
  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint => Ability[]) abilities;
  mapping (string => uint) pokeType;
  string[] arrayTypes;
  uint[][] weaknessTable;
  
  constructor() {
    weaknessTable.push([2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2]); //None
    weaknessTable.push([2, 2, 2, 2, 2, 2, 4, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2]); //Normal
    weaknessTable.push([2, 1, 4, 2, 1, 1, 2, 2, 4, 2, 2, 1, 4, 2, 2, 2, 1, 1]); //Fire
    weaknessTable.push([2, 1, 1, 4, 4, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2]); //Water
    weaknessTable.push([2, 2, 2, 1, 2, 2, 2, 2, 4, 1, 2, 2, 2, 2, 2, 2, 1, 2]); //Electric
    weaknessTable.push([2, 4, 1, 1, 1, 4, 2, 4, 1, 4, 2, 4, 2, 2, 2, 2, 2, 2]); //Grass
    weaknessTable.push([2, 4, 2, 2, 2, 1, 4, 2, 2, 2, 2, 2, 4, 2, 2, 2, 4, 2]); //Ice
    weaknessTable.push([2, 2, 2, 2, 2, 2, 2, 2, 2, 4, 4, 1, 1, 2, 2, 1, 2, 4]); //Fighting
    weaknessTable.push([2, 2, 2, 2, 1, 2, 1, 1, 4, 2, 4, 1, 2, 2, 2, 2, 2, 1]); //Poison
    weaknessTable.push([2, 2, 4, 0, 4, 4, 2, 1, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2]); //Ground
    weaknessTable.push([2, 2, 2, 4, 1, 4, 1, 2, 0, 2, 2, 1, 4, 2, 2, 2, 2, 2]); //Flying
    weaknessTable.push([2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 4, 2, 4, 2, 4, 2, 2]); //Psychic
    weaknessTable.push([2, 4, 2, 2, 1, 2, 1, 2, 1, 4, 2, 2, 4, 2, 2, 2, 2, 2]); //Bug
    weaknessTable.push([1, 1, 4, 2, 4, 2, 4, 1, 4, 1, 2, 2, 2, 2, 2, 2, 4, 2]); //Rock
    weaknessTable.push([0, 2, 2, 2, 2, 2, 0, 1, 2, 2, 2, 1, 2, 4, 2, 4, 2, 2]); //Ghost
    weaknessTable.push([2, 1, 1, 1, 1, 4, 2, 2, 2, 2, 2, 2, 2, 2, 4, 2, 2, 4]); //Dragon
    weaknessTable.push([2, 2, 2, 2, 2, 2, 4, 2, 2, 2, 0, 4, 2, 1, 2, 1, 2, 4]); //Dark
    weaknessTable.push([1, 4, 2, 2, 1, 1, 4, 0, 4, 1, 1, 1, 1, 2, 1, 2, 1, 1]); //Steel
    weaknessTable.push([2, 2, 2, 2, 2, 2, 1, 4, 2, 2, 2, 1, 2, 2, 0, 1, 4, 2]); //Fairy

    arrayTypes = ["None", "Normal", "Fire", "Water", "Electric", "Grass", "Ice", "Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug", "Rock", "Ghost", "Dragon", "Dark", "Steel", "Fairy"];

    pokeType["None"] = 1;
    pokeType["Normal"] = 2;
    pokeType["Fire"] = 3;
    pokeType["Water"] = 4;
    pokeType["Electric"] = 5;
    pokeType["Grass"] = 6;
    pokeType["Ice"] = 7;
    pokeType["Fighting"] = 8;
    pokeType["Poison"] = 9;
    pokeType["Ground"] = 10;
    pokeType["Flying"] = 11;
    pokeType["Psychic"] = 12;
    pokeType["Bug"] = 13;
    pokeType["Rock"] = 14;
    pokeType["Ghost"] = 15;
    pokeType["Dragon"] = 16;
    pokeType["Dark"] = 17;
    pokeType["Steel"] = 18;
    pokeType["Fairy"] = 19;
  }

  struct Pokemon {
    uint id;
    string name;
    string type1;
    string type2;
  }

  struct Ability {
    string name;
    string description;
  }

  event CreatePokemon(
    address creator,
    Pokemon newPokemon
  );

  modifier idValidator(uint _id){
    require(
      _id > 0,
      "The ID must be greater than 0."
      );
    _;
  }

  modifier nameValidator(string memory _name){
    require(
      bytes(_name).length > 2,
      "The name cannot be empty and must be at least 3 characters long."
      );
    _;
  }

    modifier typeValidator(string memory _type1, string memory _type2){
    require(
      pokeType[_type1] < 19 && pokeType[_type1] > 0 && pokeType[_type2] < 19 && pokeType[_type2] > 0,
      "Type is not valid"
      );
    _;
  }

  function createPokemon ( uint _id, string memory _name, string memory _type1, string memory _type2) public idValidator(_id) nameValidator(_name) typeValidator(_type1, _type2) {
    // create pokemon, asign to owner, and emit an event
    pokemons[_id] = Pokemon(_id, _name, _type1, _type2);
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit CreatePokemon(msg.sender, pokemons[_id]);
  }

  function addAbility (uint _id, string memory _name, string memory _description) public idValidator(_id) nameValidator(_name) {
    // add ability to pokemon ability list
    abilities[_id].push(Ability(_name, _description));
  }

  function getPokemonDetails(uint _id) public view returns (Pokemon memory pokemon, string[5] memory weakness) {
    pokemon = pokemons[_id];
    weakness = getResult(pokeType[pokemon.type1]-1, pokeType[pokemon.type2]-1);
  }

  function getAbility(uint _id) public view idValidator(_id) returns (Ability[] memory) {
    return abilities[_id];
  }

  function getResult(uint _type1, uint _type2) private view returns(string[5] memory weakness){
    uint count = 0;
    for(uint i = 0; i < 18; i++){
      if(weaknessTable[_type1][i] * weaknessTable[_type2][i] >= 8){
        weakness[count] = arrayTypes[i+1];
        count++;
      }
    }
  }
}
