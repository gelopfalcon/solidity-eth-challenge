// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  //Reto #1 declaración del evento
  event eventNewPokemon (Pokemon pokemon);

//Reto #3 declaración de la estructura habilidad 
  struct Ability {
    string name;
    string description;
  }

  //Reto #4 declaración de la estructura tipo 
  struct Type {
    string nombre;
    string descripcion;
  }

 struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
    Type[] types;
    Type [] weakness;
  }

    Pokemon[] private pokemons;
 mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Ability) pokeToAbilitie;
    mapping (uint => Type) pokeToType;
    mapping (uint => Type) pokeToWeakness;

     function createPokemon (
         string memory _name, 
         uint _id, 
         string[] memory _abname, 
         string[] memory _abdesc,
         string[] memory _typename,
         string[] memory _typedesc,
         string[] memory _weakname, 
         string[] memory _weakdesc
         ) public {
       //Reto #2 declaración de las condiciones y mensajes para el usuario
       require(_id > 0,"El id no puede ser igual a 0");
       require(bytes(_name).length > 2,"El nombre debe tener mas de 2 caracteres");
       
       
       for(uint i=0; i < _abname.length; i++) {
       pokeToAbilitie[_id] = Ability(_abname[i], _abdesc[i]);
       }

       for(uint i=0; i < _typename.length; i++) {
       pokeToType[_id] = Type(_typename[i], _typedesc[i]);
       }

       for(uint i=0; i < _weakname.length; i++) {
       pokeToWeakness[_id] = Type(_weakname[i], _weakdesc[i]);
       }

       pokemons[_id].name = _name;
       pokemons[_id].id = _id; 
       pokemons.push(pokemons[_id]);

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        //Reto #1 emitir evento
        emit eventNewPokemon(pokemons[_id]);
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
