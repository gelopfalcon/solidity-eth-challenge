// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

library TypesUtils {
   
    /**
     * @dev Returns Name
     *
     * @param id Type of pokemon
     * @return string Name
     */
    function typeName(uint8 id) internal pure returns (string memory){
        if (id == 0) {
            return "Normal";
        } else if (id == 1) {
            return "Fighting";
        } else if (id == 2) {
            return "Flying";
        } else if (id == 3) {
            return "Poison";
        } else if (id == 4) {
            return "Ground";
        } else if (id == 5) {
            return "Rock";
        } else if (id == 6) {
            return "Bug";
        } else if (id == 7) {
            return "Ghost";
        } else if (id == 8) {
            return "Steel";
        } else if (id == 9) {
            return "Fire";
        } else if (id == 10) {
            return "Water";
        } else if (id == 11) {
            return "Grass";
        } else if (id == 12) {
            return "Electric";
        } else if (id == 13) {
            return "Psychic";
        } else if (id == 14) {
            return "Ice";
        } else if (id == 15) {
            return "Dragon";
        } else if (id == 16) {
            return "Fairy";
        } else {
            return "Dark";
        }
    }

     /**
     * @dev Returns string of weaknesses per type
     *
     * @param id Type of pokemon
     * @return string of weaknesses
     */
    function Weakness(uint8 id) internal pure returns (string memory) {
        if (id == 0) {
            return "Rock, Ghost, Steel";
        } else if (id == 1) {
            return "Flying, Poison, Psychic,  Bug, Ghost, Fairy";
        } else if (id == 2) {
            return "Rock, Steel, Electric";
        } else if (id == 3) {
            return "Poison, Ground, Rock, Ghost, Steel";
        } else if (id == 4) {
            return "Flying, Bug, Grass";
        } else if (id == 5) {
            return "Fighting, Ground, Steel";
        } else if (id == 6) {
            return "Fighting, Flying, Poison, Ghost, Steel, Fire, Fairy";
        } else if (id == 7) {
            return "Normal, Dark";
        } else if (id == 8) {
            return "Steel, Fire, Water, Electric";
        } else if (id == 9) {
            return "Rock, Fire, Water, Dragon";
        } else if (id == 10) {
            return "Water, Grass, Dragon";
        } else if (id == 11) {
            return "Flying, Poison, Bug, Steel, Fire, Grass, Dragon";
        } else if (id == 12) {
            return "Flying, Steel, Electric";
        } else if (id == 13) {
            return "Steel, Psychic, Dark";
        } else if (id == 14) {
            return "Steel, Fire, Water, Ice";
        } else if (id == 15) {
            return "Steel, Fairy";
        } else if (id == 16) {
            return "Poison,  Steel,  Fire";
        } else {
            return "Fighting,  Dark,  Fairy";
        }
    }
}