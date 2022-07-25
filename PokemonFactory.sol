// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint8 id;
    string name;
  }

  struct Ability {
    string name; 
    string description;
  }

  struct TypeAndWeakness {
    string name;
  }

  Pokemon[] private pokemons;
  Ability[] private abilities;
  TypeAndWeakness[] private types;
  TypeAndWeakness[] private weaknesses;


  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint8 => Ability[]) private pokemonToAbility;
  mapping (uint8 => TypeAndWeakness[]) private pokemonToType;
  mapping (uint8 => TypeAndWeakness[]) private pokemonToWeakness;


  event eventNewPokemon (string);
  event eventNewOthers (string,string);


  modifier createValidation(uint8 _id, string memory _name ) {
    require(_id > 0, "id no debe estar vacio y tiene que ser mayor a 0");
    require(bytes(_name).length > 2, "El nombre debe ser mayor de 2 caracteres");
    _; 
  }

  modifier createValidationAbility(uint8 _id, string memory _name, string memory _description ) {
    require(_id > 0, "id no debe estar vacio y tiene que ser mayor a 0");
    require(bytes(_name).length > 2, "El nombre debe ser mayor de 2 caracteres");
    require(bytes(_description).length > 2, "La descripcion debe ser mayor de 2 caracteres");

    _; 
  }

  function createPokemon (uint8 _id, string memory _name) public createValidation(_id, _name) {
    pokemons.push(Pokemon(_id, _name));
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    emit eventNewPokemon( _name);
  }

  function createAbility (uint8 _id, string memory _name, string memory _description) public createValidationAbility(_id, _name, _description) {
    pokemonToAbility[_id].push(Ability(_name, _description));
    emit eventNewOthers("Ability created", _name);
  }

  function createType (uint8 _id, string memory _name) public createValidation(_id, _name) {
    pokemonToType[_id].push(TypeAndWeakness(_name));
    emit eventNewOthers("Type created", _name);

  }

  function createWeakness (uint8 _id, string memory _name) public createValidation(_id, _name) {
    pokemonToWeakness[_id].push(TypeAndWeakness(_name));
    emit eventNewOthers("Weakness created", _name);

  }


  function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

  function getAllAbilities(uint8 _id) public view returns (Ability[] memory) {
    return pokemonToAbility[_id];
  }

  function getAllTypes(uint8 _id) public view returns (TypeAndWeakness[] memory) {
    return pokemonToType[_id];
  }
  function getAllWeaknesses(uint8 _id) public view returns (TypeAndWeakness[] memory) {
    return pokemonToWeakness[_id];
  }

  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }

}
