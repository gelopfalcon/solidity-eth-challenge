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

    // evento que se va a disparar
    event eventNewPokemon(Pokemon pokemon);

    function createPokemon (string memory _name, uint _id) public isGreatZero(_id) pokemonNameRule(_name) {
        Pokemon memory _newPokemon = Pokemon(
            _id,
            _name
        );
        pokemons.push(_newPokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon (_newPokemon);
    }

    modifier isGreatZero(uint _number)
    {
        require(_number > 0, "Require id greater 0");
        _;
    }

    modifier pokemonNameRule(string memory _name)
    {
        require(bytes(_name).length > 2, "Name require 2 or more characters");
        _;
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
