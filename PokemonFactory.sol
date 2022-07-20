// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(string _name, uint _id);

    
     function createPokemon (string memory _name, uint _id) public{
        require(_id>0, 'The pokemon id must be greater than 0');
        require(bytes(_name).length>1, 'The name must be not empty and have 2 or more characters');
        pokemons.push(Pokemon(_id, _name));
        emit eventNewPokemon(_name, _id);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
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
