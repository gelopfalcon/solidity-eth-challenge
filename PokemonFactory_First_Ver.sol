//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    
    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities; /* @reto#3 Cada Pokemon cuenta con una lista de Habilidades */ 
        string[] types;
        string[] weaknesses;
    }

    struct Ability {
        string name;
        string description;
    }

    /* State Variables */
    Pokemon[] private pokemons;

    string[] private tempWeaknesses;
    string[] private tempTypes;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    //id => index  Recupera el indice del pokemon segun el id del pokemon
    mapping (uint => uint) private pokemonIndex;
    //types of pokemon
    mapping (uint => string) private pokemonType;
    mapping (uint => string[]) private pokemonWeakness;

    /* Constructor */ 
    constructor() {

        pokemonType[0] = "GRASS";
        pokemonType[1] = "POISON";
        pokemonType[2] = "FIRE";
        pokemonType[3] = "FLYING";
        pokemonType[4] = "ICE";
        pokemonType[5] = "PSYCHIC"; 
        pokemonType[6] = "ROCK";
        pokemonType[7] = "WATER";

        pokemonWeakness[0] = ["FIRE", "FLYING", "ICE", "PSYCHIC"];
        pokemonWeakness[1] = ["POISON", "PSYCHIC"];
        pokemonWeakness[2] = ["WATER", "ROCK", "ICE"];
        pokemonWeakness[3] = ["GRASS"];
        pokemonWeakness[4] = ["FIRE", "WATER", "ROCK"];
        pokemonWeakness[5] = ["POISON"];
        pokemonWeakness[6] = ["FLYING", "FIRE", "ICE"];
        pokemonWeakness[7] = ["ROCK", "FIRE"];
    }

    /* Events */       
    event EventNewPokemon(Pokemon indexed newPokemon);  

    /* Functions */
    function createPokemon (string memory _name, uint _id, string[] memory _abilities_name, string[] memory _abilities_description, uint[] memory types_id) public  {
        /* @reto#2  Agregar require para la validación de id y nombre */ 
        require(_id > 0, "Debe seleccionar un id valido para el pokemon");
        require(bytes(_name).length == 0 || bytes(_name).length > 2, "Digite el nombre del pokemon, no vacio y mayor a dos caracteres");
        
        uint _index = pokemons.length;

        pokemonIndex[_id] = _index;
        
        pokemons.push();
        pokemons[_index].id = _id;  
        pokemons[_index].name = _name;
        setPokemonAbilitiesById(_abilities_name, _abilities_description, _index);
        pokemons[_index].types = getPokemonTypes(types_id);
        pokemons[_index].weaknesses = getPokemonWeaknesses(types_id);

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;      

        /* @reto#1  implementar un evento que se llame eventNewPokemon */  
        emit EventNewPokemon(pokemons[_index]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getPokemonById(uint id) public view returns(Pokemon memory pokemon)
    {
        return pokemons[pokemonIndex[id]];
    }

    function setPokemonAbilitiesById(string[] memory _abilities_name, string[] memory _abilities_description, uint _indexPokemon) private
    {        
        for (uint abilitiesIndex = 0; abilitiesIndex < _abilities_name.length; abilitiesIndex++) {
            pokemons[_indexPokemon].abilities.push(Ability(_abilities_name[abilitiesIndex], _abilities_description[abilitiesIndex]));
        }
  
    }    

    function getPokemonTypes(uint[] memory types_id) private returns(string[] memory) {
        tempTypes = new string[](0);

        for(uint i =0; i < types_id.length; i++){
            string memory _type = pokemonType[types_id[i]];
            tempTypes.push(_type);
        }
        return tempTypes;
    }
  
    /* @reto#4  Cada Pokemon puede pertencer a varios tipos y a su vez devuelve sus tipos de debilidades */ 
    function getPokemonWeaknesses(uint[] memory types_id) private returns(string[] memory) {
        tempWeaknesses = new string[](0);

        for(uint i =0; i < types_id.length; i++){
            string [] memory _pokemonWeaknessTemp = pokemonWeakness[types_id[i]];

            for(uint j =0; j < _pokemonWeaknessTemp.length; j++)
            {    
                tempWeaknesses.push(_pokemonWeaknessTemp[j]);
            }
        }
        return tempWeaknesses;
    }    
}