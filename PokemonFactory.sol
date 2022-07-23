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
         Ability[] memory abilities,
         Type[] memory types,
         Type[] memory weakness  
         ) public {
       //Reto #2 declaración de las condiciones y mensajes para el usuario
       require(_id > 0,"El id no puede ser igual a 0");
       require(bytes(_name).length > 2,"El nombre debe tener mas de 2 caracteres");
       
       pokemons.push();
       uint256 index = pokemons.length - 1;
       
       for(uint i=0; i < abilities.length; i++) {
       pokeToAbilitie[index] = Ability(abilities[i].name, abilities[i].description);
       }

       for(uint i=0; i < types.length; i++) {
       pokeToType[index] = Type(types[i].nombre, types[i].descripcion);
       }

       for(uint i=0; i < weakness.length; i++) {
       pokeToWeakness[index] = Type(weakness[i].nombre, weakness[i].descripcion);
       }

       pokemons[index].name = _name;
       pokemons[index].id = _id; 
       pokemons.push(pokemons[index]);

        pokemonToOwner[index] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        //Reto #1 emitir evento
        emit eventNewPokemon(pokemons[index]);
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
