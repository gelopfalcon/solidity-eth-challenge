// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  // Structs
  struct Pokemon {
      uint id;
      string name;
    }
    struct Habilities {
      string name;
      string description;
  }
  // Events
  event NewPokemon(
      uint idNewPokemon,
      string nameNewPokemon
  );
  
  Pokemon[] public listOfPokemon;

  // Mappings
  mapping (uint => mapping(uint => string)) public pokemonTypes;
  mapping (uint => mapping(uint => Habilities)) public pokemonSkills;
  mapping (uint => mapping(uint => string)) public pokemonWeaknesses;
  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount; 
  
  // Modifiers
  modifier onlyOwner (uint _id) {
    require(pokemonToOwner[_id] == msg.sender,"You're not the owner");
    _;
  }
  // Functions
  function createPokemon (string memory _name, uint _id) public {
    require(_id > 0 ,"El id del nuevo pokemon debe ser mayor a 0");
    require(validatePokemonName(_name), "El nombre de tu Pokemon debe tener al menos 2 caracteres");
    listOfPokemon.push(Pokemon(_id, _name));
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit NewPokemon(_id, _name);
  }
  function getAllPokemon() public view returns (Pokemon[] memory) {
    return listOfPokemon;
  }  
  function validatePokemonName(string memory _name) internal pure returns (bool){
    bytes memory name = bytes(_name);
    return name.length > 2 ? true : false;
  }
  function setSkill(uint _id,uint _skillNumber , string memory _name, string memory _description) public onlyOwner(_id) {
    pokemonSkills[_id][_skillNumber] = Habilities(_name,_description);
  }
  function setType(uint _id, uint _typeNumber, string memory types) public onlyOwner(_id) {
    pokemonTypes[_id][_typeNumber] = types;
  }
  function setWeaknesses(uint _id, uint _typeNumber, string memory types) public  onlyOwner(_id){
    pokemonTypes[_id][_typeNumber] = types;
  }
  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }
}