// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Skill {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
    }
    
    enum Type { NORMAL, WATER, GRASS, FIRE, ELECTRIC, ICE, FIGHTING, PISON, GROUND, FLYING, PSYCHIC, BUG, ROCK, GHOST, DARK, DRAGON, STEEL, FAIRY }

    event eventNewPokemon(Pokemon pokemon);

    Pokemon[] private pokemons;

    mapping (uint => Skill[]) public pokemonToSkills;
    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Type[]) pokemonToTypes;
    mapping (uint => Type[]) pokemonToWeaknesses;


    function createPokemon (string memory _name, uint _id, Skill[] memory _skills, Type[] memory _types, Type[] memory _weaknesses) public {
        require(_id > 0, "Id should be more than 0.");
        require(bytes(_name).length >= 2, "Name needs at least two letters");
        pokemons.push(Pokemon(_id, _name));
        // loop skills to push in storage variable
        uint256 skillsLength = _skills.length;
        for (uint i = 0; i < skillsLength; i+=1) {
            pokemonToSkills[_id].push(Skill(_skills[i].name,_skills[i].description));
        }
        //loop types to push in storage variable
        uint256 typesLength = _types.length;
        for (uint j = 0; j < typesLength; j+=1) {
            pokemonToTypes[_id].push(_types[j]);
        }
        //loop types to push in storage variable
        uint256 weaknessesLength = _weaknesses.length;
        for (uint k = 0; k < weaknessesLength; k+=1) {
            pokemonToWeaknesses[_id].push(_weaknesses[k]);
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(Pokemon(_id, _name));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getPokemonSkills(uint256 _id) public view returns (Skill[] memory) {
      return pokemonToSkills[_id];
    }

    function getPokemonTypes(uint256 _id) public view returns (Type[] memory) {
      return pokemonToTypes[_id];
    }

    function getPokemonWeaknesses(uint256 _id) public view returns (Type[] memory) {
      return pokemonToWeaknesses[_id];
    }

    function getResult() public pure returns(uint product, uint sum, uint d){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
      d = bytes("pa").length;
   }

}
