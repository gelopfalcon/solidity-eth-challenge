// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {


  struct Abilities {
    string name;
    string description;
  }

struct Pokemon {
    uint8 id;
    string name;
    Abilities[] abilities;
    string[] types;
    string[] weaknesses;
}

Pokemon [] private pokemons; 

mapping (uint8 => address) public pokemonToOwner;
mapping (address => uint8) ownerPokemonCount;

event eventNewPokemon ( 
  Pokemon NewPokemon
  
);

 function acceptedTypes(uint8 id) private pure returns(string memory _type){
    require(id >= 0 && id <=16, "Tipo de Pokemon incorrecto, probar con otro");
    if (id == 0){
      return "Bicho";
    } else if (id == 1){
      return "Dragon";
    } else if (id == 2){
      return "Electrico";
    } else if (id == 3){
      return "Hada";
    } else if (id == 4){
      return "Lucha";
    } else if (id == 5){
      return "Fuego";
    } else if (id == 6){
      return "Volador";
    } else if (id == 7){
      return "Planta";
    } else if (id == 8){
      return "Tierra";
    } else if (id == 9){
      return "Hielo";
    } else if (id == 10){
      return "Normal";
    } else if (id == 11){
      return "Veneno";
    } else if (id == 12){
      return "Psiquico";
    } else if (id == 13){
      return "Roca";
    } else if (id == 14){
      return "Acero";
    } else if (id == 15){
      return "Agua";
    } else if (id == 16){
      return "Oscuro";
    } 
  } 


function createPokemon (
  string memory _name, 
  uint8 _id, 
      Abilities[] memory _abilities,
     uint8[] memory _types,
     uint8[] memory _weakness
 ) public  {

require(_id > 0, "El id del Pokemon debe ser mayor a 0");
require(bytes(_name).length > 2, "El nombre del Pokemon debe tener mas de 2 caracteres");

        
    pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount [msg.sender]++;

 pokemons.push();
    uint index = pokemons.length - 1;
    pokemons[index].id = _id;
    pokemons[index].name = _name;
    uint i;
    for (i = 0; i < _abilities.length; i++){
      pokemons[index].abilities.push(_abilities[i]);
    }
    for (i = 0; i < _types.length; i++){
      pokemons[index].types.push(acceptedTypes(_types[i]));
    }
    for (i = 0; i < _weakness.length; i++){
      pokemons[index].weaknesses.push(acceptedTypes(_weakness[i]));
    }


 emit eventNewPokemon (pokemons[index]);
}



function getAllPokemons() public view returns (Pokemon [] memory ){
return pokemons;
}

}
