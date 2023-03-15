// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

  struct Hability {
        string name;
        string description;
    }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint8 => Hability []) public habilities;

  event eventNewPokemon (address indexed_from, uint8 indexed_to);


  function createPokemon (string memory _name, uint8 _id) public {
        require( bytes(_name).length != 0, "Name can not be empty");
        require(_id > 0, "ID does not have to be less o equal than 0 ");
        Pokemon memory pokemon = Pokemon(_id, _name);
        pokemons.push(pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon (msg.sender, _id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function addHability (uint8 _id, string memory _name, string memory _description )public {
        habilities[_id].push(Hability(_name, _description));
    }

    function addType (uint8 _id, string memory _type )public {
        types[_id].push(_type);
    }

    function addWeakness(uint8 _id, string memory _weakness)public {
        weaknesses[_id].push(_weakness);
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
