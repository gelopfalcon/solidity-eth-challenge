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
    Ability[] abilities;
  }
 
    Pokemon[] private pokemons;
    Ability[] private abilities;
    event PokemonCreated(uint8 _id, string _name);
    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Ability) abilityById;
    modifier greatherThan(string memory _name){
      require(bytes(_name).length >= 2, "name needs at least two letters");
      _;
    }
     function createPokemon (string memory _name,  uint8[] memory _abilitiesId) public greatherThan(_name) {
        // pokemons.push(Pokemon(_id, _name, _abilitiesId));
        pokemons.push();
        uint id = pokemons.length-1;
        pokemons[id].id = uint8(id);
        pokemons[id].name = _name;
        for(uint8 i=0;i<_abilitiesId.length;i++) {
          pokemons[id].abilities.push(abilityById[_abilitiesId[i]]);
        }
        pokemonToOwner[id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit PokemonCreated(uint8(id), _name);
    }
    function createAbility (string memory _name, string memory _description) public greatherThan(_name) {
        abilities.push(Ability(_name, _description, uint8(abilities.length)));
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
