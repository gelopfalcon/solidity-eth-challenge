// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/utils/Strings.sol";



contract PokemonType {
    mapping (uint32=> string) private pokemonsTypes;

    mapping (uint32=> uint32[]) private weaknesses;

    /*
    * Inizailizate type and weaknesses 
    */
    constructor(){
        pokemonsTypes[0] = "No Type";
        pokemonsTypes[1] = "Normal";
        pokemonsTypes[2] = "Fighting";
        pokemonsTypes[3] = "Flying";
        pokemonsTypes[4] = "Poison";
        pokemonsTypes[5] = "Ground";
        pokemonsTypes[6] = "Rock";
        pokemonsTypes[7] = "Bug";
        pokemonsTypes[8] = "Ghost";
        pokemonsTypes[9] = "Steel";
        pokemonsTypes[10] = "Fire";
        pokemonsTypes[11] = "Water";
        pokemonsTypes[12] = "Grass";
        pokemonsTypes[13] = "Electric";
        pokemonsTypes[14] = "Psychic";
        pokemonsTypes[15] = "Ice";
        pokemonsTypes[16] = "Dragon";
        pokemonsTypes[17] = "Dark";
        pokemonsTypes[18] = "Fairy";

        weaknesses[1] = [2];
        weaknesses[2] = [3, 14, 18];
        weaknesses[3] = [6, 13, 15];
        weaknesses[4] = [5, 14];
        weaknesses[5] = [11, 12, 15];
        weaknesses[6] = [11, 12, 2, 5, 9];
        weaknesses[7] = [3, 6, 10];
        weaknesses[8] = [8, 17];
        weaknesses[9] = [10, 2, 5];
        weaknesses[10] = [5, 6, 11];
        weaknesses[11] = [13, 12];
        weaknesses[12] = [3, 4, 7, 10, 15];
        weaknesses[13] = [5];
        weaknesses[14] = [7, 8, 17];
        weaknesses[15] = [2, 6, 9, 10];
        weaknesses[16] = [15, 16, 18];
        weaknesses[17] = [2, 7, 18];
        weaknesses[18] = [4, 9];
    }

    /*
    * return type weeknesses Id - Validate
    */
    function getIdWeaknesses(uint32 idWeaknesses) public view returns (uint32[] memory){
        require(idWeaknesses <= 18, "Not exist type");
        return weaknesses[idWeaknesses];
    }

    /*
    * Return type weeknesses String by type id  
    */
    function getWeaknessesArray(uint32 idWeaknesses) public view returns (string[] memory){
        uint32[] memory _idWeaknesses = getIdWeaknesses(idWeaknesses); 
        string[] memory _weaknesses = new string[](_idWeaknesses.length);
        for(uint32 i = 0; i < _idWeaknesses.length; i++){
            string memory foo = pokemonsTypes[_idWeaknesses[i]];
            _weaknesses[i] = foo;
        }
        return _weaknesses;
    }

    /*
    * Return All pokemon types in string "id - name"
    */
    function getAllPokemonTypes() public view returns ( string[18] memory){
        string[18] memory _pokemonsTypesReturn;
        for (uint32 i = 0; i < 18; i++) {
            string memory _idTextType = string(
                abi.encodePacked(
                    Strings.toString(i+1),
                    " - ",
                    pokemonsTypes[i+1]
                )
            );
            _pokemonsTypesReturn[i] = _idTextType;
        }
        return _pokemonsTypesReturn;
    }
}