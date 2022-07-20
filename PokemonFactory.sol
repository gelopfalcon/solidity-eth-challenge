// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  //Reto #1 declaración del evento
  event eventNewPokemon (uint id, string name);

  struct Pokemon {
    uint id;
    string name;
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     function createPokemon (string memory _name, uint _id) public {
       //Reto #2 declaración de las condiciones y mensajes para el usuario
       require(_id > 0,"El id no puede ser igual a 0");
       require(bytes(_name).length > 2,"El nombre debe tener mas de 2 caracteres");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        //Reto #1 emitir evento
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
