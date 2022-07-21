// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
        uint id;
        string name;
        string[] habilities;
        string[] types;
        string[] weaknesses;
    }

    string[] pokemonTypes;
    mapping(string => bool) isAPokemonType;

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping(uint => bool) idAlreadyExists;

    event eventNewPokemon(uint _id, string _name, string[] _habilities, string[] _types, string[] _weaknesses);

    constructor() {   
        pokemonTypes = ["Normal","Fire","Water","Grass","Flying","Fighting","Poison","Electric","Ground","Rock","Psychic","Ice","Bug","Ghost","Steel","Dragon","Dark","Fairy"];
        for(uint i = 0; i < pokemonTypes.length; i++) {
            isAPokemonType[pokemonTypes[i]] = true;
        }
    }

    function createPokemon (string memory _name, uint _id, string[] memory _nameOfHabilities, string[] memory _descriptionOfHabilities, string[] memory _types, string[] memory _weaknesses) public {
        
        require(_id > 0, "The id must be at least 1");
        require(idAlreadyExists[_id] == false, "This id already exists");
        require(_nameOfHabilities.length == _descriptionOfHabilities.length, "You must have the same amount of name of habilities and descriptions of habilities");
        require(bytes(_name).length > 2, "The name must have at least 3 characters");
        require(_types.length > 0 && _types.length < 3, "The Pokemon can have just 1 or 2 types");
        require(!thereAreRepeatedStringsInArray(_types), "The types must be uniques");
        require(!thereAreRepeatedStringsInArray(_weaknesses), "The weaknesses must be uniques");
        for(uint i = 0; i < _types.length; i++) {
            require(isAPokemonType[_types[i]], "All the types must have a valid name");
        }
        for(uint i = 0; i < _weaknesses.length; i++) {
            require(isAPokemonType[_weaknesses[i]], "All the weaknesses must have valid type names");
        }

        for(uint i = 0; i < _nameOfHabilities.length; i++) {
            require(bytes(_nameOfHabilities[i]).length > 2, "The habilities must have at least 2 characters each one");
        }

        for(uint i = 0; i < _descriptionOfHabilities.length; i++) {
            require(bytes(_descriptionOfHabilities[i]).length > 9, "The descriptions of the habilities must have at least 10 characters each one");
        }

        string[] memory arrayOfConcatenatedHabilities = new string[](_nameOfHabilities.length);

        for(uint i = 0; i < _nameOfHabilities.length; i++) {
            arrayOfConcatenatedHabilities[i] = concatenateNameAndDescriptionOfHability(_nameOfHabilities[i], _descriptionOfHabilities[i]);
        }

        pokemons.push(Pokemon(_id, _name, arrayOfConcatenatedHabilities, _types, _weaknesses));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        idAlreadyExists[_id] = true;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function thereAreRepeatedStringsInArray(string[] memory _arrayOfStrings) private pure returns (bool) {
        bool result = false;
        for(uint i = 1; i < _arrayOfStrings.length; i++){
            for(uint j = 0; j < i; j++){  
                if(keccak256(abi.encodePacked(_arrayOfStrings[i])) == keccak256(abi.encodePacked(_arrayOfStrings[j]))){
                    result = true;
                    break;
                }
            }
            if(result) break;     
        }
        return result;
    }

    function concatenateNameAndDescriptionOfHability(string memory _nameOfHability, string memory _descriptionOfHability) private pure returns (string memory) {
        return string(abi.encodePacked(_nameOfHability, " - ", _descriptionOfHability));
    }

}
