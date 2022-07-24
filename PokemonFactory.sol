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

  Pokemon[] private pokemons;
  Ability[] private abilities;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint8 => Ability[]) public pokemonToAbility;

  event eventNewPokemon (string);

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
  }


  function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

  function getAllHabilities(uint8 _id) public view returns (Ability[] memory) {
    return pokemonToAbility[_id];
  }

  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }

}
