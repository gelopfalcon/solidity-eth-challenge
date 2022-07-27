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

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint => Ability[]) abilities;

  function createPokemon (string memory _name, uint _id) public idValidator(_id) nameValidator(_name) {
    // create pokemon, asign to owner, and emit an event
    pokemons.push(Pokemon(_id, _name));
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit CreatePokemon(msg.sender, Pokemon(_id, _name));
  }

  function addAbility (uint _id, string memory _name, string memory _description) public idValidator(_id) nameValidator(_name) {
    // add ability to pokemon ability list
    abilities[_id].push(Ability(_name, _description));
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getAbility(uint _id) public view idValidator(_id) returns (Ability[] memory) {
    return abilities[_id];
  }

  function getResult() public pure returns(uint product, uint sum){
    uint a = 1;
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }

}
