// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Ability {
        string name;
        string description;
    }

    struct Type {
        string name;
    }

    enum Element {
        Normal, 
        Fire, 
        Water, 
        Grass, 
        Flying, 
        Fighting, 
        Poison, 
        Electric, 
        Ground, 
        Rock, 
        Psychic, 
        Ice, 
        Bug, 
        Ghost, 
        Steel, 
        Dragon, 
        Dark,
        Fairy
    }

    struct Weakness {
        string name;
    }
    
    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
        Type[] types;
        Weakness[] weaknesses;
    }

    Pokemon[] private pokemons;


    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(uint newPokemonId, string newPokemonName, string newPokemonAbility, string newPokemonType, string newPokemonWeakness);

    modifier isGreaterZero(uint _number) {
        require(_number > 0, "Require id greater 0");
        _;
    }

    modifier pokemonNameRule(string memory _name) {
        require(bytes(_name).length != 0, "the name must not be empty");
        require(bytes(_name).length > 2, "Name require 2 or more characters");
        _;
    }

    function createPokemon (string memory _name, string memory _mainAbilityName, string memory _mainAbilityDescription, string memory _mainTypeName, string memory _mainWeaknessName) public pokemonNameRule(_name) {
        pokemons.push();
        uint _internalIndex = pokemons.length -1;
        pokemons[_internalIndex].id = _internalIndex;
        pokemons[_internalIndex].name = _name;
        addAbility(_internalIndex, _mainAbilityName, _mainAbilityDescription);
        addType(_internalIndex, _mainTypeName);
        addWeakness(_internalIndex, _mainWeaknessName);
        pokemonToOwner[_internalIndex] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_internalIndex, _name, _mainAbilityName, _mainTypeName, _mainWeaknessName);
    }

    function addAbility(uint _id, string memory _abilityName, string memory _abilityDescription) public isGreaterZero(_id) {
        pokemons[_id].abilities.push(Ability(_abilityName, _abilityDescription));
    }

    function addType(uint _id, string memory _typeName) public isGreaterZero(_id) {
        pokemons[_id].types.push(Type(_typeName));
    }

    function addWeakness(uint _id, string memory _weaknessName) public isGreaterZero(_id){
        pokemons[_id].weaknesses.push(Weakness(_weaknessName));
    }

    function getAllPokemons() public view returns(Pokemon[] memory){
        return pokemons;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
