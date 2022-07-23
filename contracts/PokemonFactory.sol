// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./StringUtils.sol";
import "./TypesUtils.sol";

contract PokemonFactory {

    struct Pokemon {
      uint id;
      string name;
      Type[] typesList;
      Ability[] abilities;
    }

    struct Ability {
      string name;
      string description;
    }

    struct Type {
      Types id;
      string name;
    }
  
    enum Types{
      Normal,
      Fighting,
      Flying,
      Poison,
      Ground,
      Rock,
      Bug,
      Ghost,
      Steel,
      Fire,
      Water,
      Grass,
      Electric,
      Psychic,
      Ice,
      Dragon,
      Fairy,
      Dark
    }
  
    Pokemon[] private pokemons;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => address) public pokemonToOwner;
    
    event eventNewPokemon(string name, uint id);  

    modifier validateEntries(string memory _name, uint _id, Ability[] memory _abilities, Types[] memory _type) {
      require(_id != 0, "Id must be greater than 0");
      require(StringUtils.strlen(_name) > 2, "Name must have more than 2 characters");
      require(_abilities.length > 0 && _abilities.length < 4, "Must have between 1 to 3 Abilities");
      require(_type.length  > 0 && _type.length  < 3, "Must have 1 or 2 Types");

      for (uint i = 0; i < _abilities.length; i++) {
        for (uint j = 1; j <_abilities.length; j++) {
          if(j != i && keccak256(abi.encodePacked((_abilities[i].name))) == keccak256(abi.encodePacked((_abilities[j].name)))){
            revert("You have duplicated Abilities");
          }
        }
      }

      for (uint i = 0; i < _type.length; i++) {
        for (uint j = 1; j <_type.length; j++) {
          if(j != i && _type[i] == _type[j]){
            revert("You have duplicated Types");
          }
        }
      }
      _;
    }

    /**
     * @dev create a pokemon
     *
     * @param _name Name of the Pokemon
     * @param _id id of the Pokemon
     * @param _abilities Abilities of the Pokemon
     * @param _type Type of Pokemon
     */
    function createPokemon (string memory _name, uint _id, Ability[] memory _abilities, Types[] memory _type) public validateEntries(_name, _id, _abilities, _type){
      //create first pokemon struct in pokemons
      Pokemon storage pokemon = pokemons.push();
      pokemon.id = _id;
      pokemon.name = _name;
      for (uint i = 0; i <_abilities.length; i++) {
        pokemon.abilities.push(Ability(_abilities[i].name, _abilities[i].description));
      }
      for (uint i = 0; i <_type.length; i++) {
        pokemon.typesList.push(Type(_type[i], TypesUtils.typeName(uint8(_type[i]))));
      }
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(_name, _id);
    }

    /**
     * @dev get weaknesses of a Pokemon
     *
     * @param _pokemonIndex index of pokemons array
     * @return array of weaknesses
     */
    function getWeaknesses (uint _pokemonIndex) public view returns (string[] memory) {
      Pokemon memory pokemon = pokemons[_pokemonIndex];
      string[] memory weaknesses = new string[](pokemon.typesList.length);
      for (uint i = 0; i < pokemon.typesList.length; i++) {
        weaknesses[i] = TypesUtils.Weakness(uint8(pokemon.typesList[i].id));
      }
      return weaknesses;
    }

    /**
     * @dev get all Pokemons of pokemons array
     * @return array pokemons
     */
    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }
}
