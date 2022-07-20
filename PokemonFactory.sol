// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  // Challenge 1
  event NewPokemon(
      uint idNewPokemon,
      string nameNewPokemon
  );

  struct Pokemon {
    uint id;
    string name;
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;


    function createPokemon (string memory _name, uint _id) public {
        // Challenge 2
        require(_id > 0 ,"The id of your new pokemon must be greater than 0");
        require(validatePokemonName(_name), "The name of your pokemon cannot be empty and must be greater than two characters");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit NewPokemon(_id, _name);
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

    // Challenge 2
   function validatePokemonName(string memory _name) public pure returns (bool){
        bytes memory name = bytes(_name);
        return name.length > 2 ? true : false;
    }

}
