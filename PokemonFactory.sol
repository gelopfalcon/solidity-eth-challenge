// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

  struct Ability {
    uint id;
    string name;
    string description;
  }

  struct AbilityList {
    Ability[] listAbilities;
  }

  struct PokemonType {
    uint id;
    string name;
  }

  struct PokemonTypeList {
    PokemonType[] listTypes;
  }

  struct Weakness {
    uint id;
    string weakness;
  }

  struct WeaknessList {
    Weakness[] listWeakness;
  }

  Pokemon[] private pokemons;

  mapping (uint => Ability) public abilities;
  mapping (uint => PokemonType) public pokemonTypes;
  mapping (uint => Weakness) public weaknesses;

  event eventNewPokemon(Pokemon _pokemon);

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint => AbilityList) pokemonToAbility;
  mapping (uint => PokemonTypeList) pokemonToType;
  mapping (uint => WeaknessList) pokemonToWeakness;

  function createPokemon (string memory _name, uint _id) public {
    require(_id > 0, "El id tiene que ser mayor a cero");
    require(keccak256(abi.encodePacked(_name)) != keccak256(abi.encodePacked(" ")), "El nombre no puede ser vacio");
    require(len(_name) > 2, "El nombre debe ser mayor a 2 caracteres");
    Pokemon memory pokemon = Pokemon(_id, _name);
    pokemons.push(pokemon);
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit eventNewPokemon(pokemon);
  }

  function registerAbility(uint _id, string memory _name, string memory _description) public {
    Ability memory ability = Ability(_id, _name, _description);
    abilities[_id] = ability;
  }

  function registerPokemonType(uint _id, string memory _typePokemon) public {
    PokemonType memory pokemonType = PokemonType(_id, _typePokemon);
    pokemonTypes[_id] = pokemonType;
  }

  function registerWeakness(uint _id, string memory _weaknessName) public {
    Weakness memory weakness = Weakness(_id, _weaknessName);
    weaknesses[_id] = weakness;
  }

  function assignAbility(uint _pokemonId, uint _abilityId) public {
    Ability memory ability = abilities[_abilityId];
    pokemonToAbility[_pokemonId].listAbilities.push(ability);
  }

  function assignPokemonType(uint _pokemonId, uint _pokemonTypeId) public {
    PokemonType memory pokemonType = pokemonTypes[_pokemonTypeId];
    pokemonToType[_pokemonId].listTypes.push(pokemonType);
  }

  function assignWeakness(uint _pokemonId, uint _weaknessId) public {
    Weakness memory weakness = weaknesses[_weaknessId];
    pokemonToWeakness[_pokemonId].listWeakness.push(weakness);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getPokemonAbility(uint _pokemonId) public view returns (Ability[] memory) {
    return pokemonToAbility[_pokemonId].listAbilities;
  }

  function getPokemonType(uint _pokemonId) public view returns (PokemonType[] memory) {
    return pokemonToType[_pokemonId].listTypes;
  }

  function getPokemonWeakness(uint _pokemonId) public view returns (Weakness[] memory) {
    return pokemonToWeakness[_pokemonId].listWeakness;
  }

  function len(string memory str) public pure returns (uint256) {
    return bytes(str).length;
  }

  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }
}
