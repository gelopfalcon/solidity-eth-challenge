// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";


contract PokemonFactory {


 struct Ability {
        string name;
        string description;
    }

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
    Type [] types;
    Type [] weakness;

  }
  enum Type{ NORMAL ,FIGHTING ,FLYING ,POISON ,GROUND ,ROCK ,BUG ,GHOST ,STEEL ,FIRE 
                ,WATER ,GRASS ,ELECTRIC ,PSYCHIC ,ICE ,DRAGON ,DARK ,FAIRY	}




    Pokemon[] private pokemons;
    Ability[] private abilities;

    

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(address indexed user, string message);

     function createPokemon (string memory _name, uint _id, Ability[] memory _abilities,
                                                Type[] memory _types, Type[] memory _weakness) public {

        require( _id > 0, "Debe ingresar un id que sea mayor a 0");
         bytes memory str = bytes(_name);
        require(str.length != 0, "El nombre no puede estar en blanco.");
        require(str.length > 2, "El nombre debe tener minimo mas de dos caracteres.");

       
        pokemons.push();
        uint index=pokemons.length-1;
        pokemons[index].name=_name;
        pokemons[index].id=_id;
        
    
         //Agregando abilidades
        for(uint8 i=0; i < _abilities.length; i++) 
            pokemons[index].abilities.push(_abilities[i]);

            //Agregando types
        for(uint8 i=0; i < _types.length; i++) 
            pokemons[index].types.push(_types[i]);

                 //Agregando debilidades
        for(uint8 i=0; i < _weakness.length; i++) 
            pokemons[index].weakness.push(_weakness[i]);
           

        //pokemons.push(Pokemon(_id, _name, _abilities));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(msg.sender, string.concat("The pokemon " , _name , "have been created"));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


}