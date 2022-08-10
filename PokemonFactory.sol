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

  event eventNewPokemon(
    uint id,
    string name
  );

    function createPokemon (string memory _name, uint _id) public {
      require(_id > 0, "El Id debe ser mayor a 0");
      require(bytes(_name).length != 0, "El nombre no puede estar vacio");
      require(bytes(_name).length > 2, "El nombre debe ser mayor a 2 caracteres");
      pokemons.push(Pokemon(_id, _name));
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(_id, _name);
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
