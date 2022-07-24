// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Ability {
  string name;
  string description;
  uint8 id;
  }
  struct Pokemon {
    uint8 id;
    string name;
    uint8[] abilities;
  }
 
    Pokemon[] private pokemons;
    Ability[] private abilities;
    event PokemonCreated(uint8 _id, string _name);
    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    modifier greatherThan(string memory _name, uint8 _id){
      require(_id > 0, "id cannot be less than 0");
      require(bytes(_name).length >= 2, "name needs at least two letters");
      _;
    }
     function createPokemon (string memory _name, uint8 _id, uint8[] memory _abilitiesId) public greatherThan(_name, _id) {
        pokemons.push(Pokemon(_id, _name, _abilitiesId));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit PokemonCreated(_id, _name);
    }
    function createAbility (string memory _name, string memory _description, uint8 _id) public greatherThan(_name, _id) {
        abilities.push(Ability(_name, _description, _id));
    }
    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }
    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }
}
