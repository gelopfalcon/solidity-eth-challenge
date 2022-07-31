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


     function createPokemon (string memory _name, uint _id) public {
        require( bytes(_name).length != 0, "Name can not be empty");
        require(_id > 0, "ID does not have to be less o equal than 0 ");
        Pokemon memory pokemon = Pokemon(_id, _name);
        pokemons.push(pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        habilities[pokemon.id].push(Hability(name_hability, description_hability));
        emit eventNewPokemon (pokemonToOwner [_id], _id);
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
