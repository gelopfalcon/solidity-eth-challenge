// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint8 id;
    string name;
  }

    Pokemon[] private pokemons;

    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;

    event NewPokemon(
        uint8 id,
        string name
    );

     function createPokemon (string memory _name, uint8 _id) public {
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit NewPokemon(_id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getResult() public pure returns(uint8 product, uint8 sum){
      uint8 a = 1; 
      uint8 b = 2;
      product = a * b;
      sum = a + b; 
   }

}