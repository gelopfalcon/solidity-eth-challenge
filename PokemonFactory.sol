// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct PokemonType {
        uint id;
        string name;
    }

    struct Ability {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
        uint[] types;
        uint[] weaknesses;
    }

    Pokemon[] private pokemons;
    PokemonType[] private pokemonTypes;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(uint _idPokemonCreated);

    function createPokemon (string memory _name, uint _id, string memory _abilityName, 
        string memory _abilityDescription, uint[] memory _types, uint[] memory _weaknesses) public {
        require(_id >= 0, "_id must be greater than 0");
        require(bytes(_name).length > 0, "_name must not be empty");
        require(bytes(_name).length > 2, "_name must be greater than 2");

        Pokemon storage pokemon = pokemons.push();
        pokemon.id=_id;
        pokemon.name=_name;
        pokemon.abilities.push(Ability(_abilityName, _abilityDescription));
        pokemon.types=_types;
        pokemon.weaknesses=_weaknesses;

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id);
    }

    function addAbility(uint _id, string memory _abilityName, string memory _abilityDescription) public {
        require(_id >= 0, "_id must be greater than 0");
        pokemons[_id].abilities.push(Ability(_abilityName, _abilityDescription));
    }

    function addPokemonType(uint _id, string memory _typeName) public {
        require(_id >= 0, "_id must be greater than 0");
        pokemonTypes.push(PokemonType(_id,_typeName));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getAllPokemonTypes() public view returns (PokemonType[] memory) {
      return pokemonTypes;
    }

    function getPokemonType(uint _id) public view returns (PokemonType memory) {
      return pokemonTypes[_id];
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}