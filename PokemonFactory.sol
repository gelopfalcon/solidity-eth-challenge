// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
      uint id;
      string name;
      string ability;
      string[] types;
    }

    Pokemon[] private pokemons;

    event eventNewPokemon(Pokemon _pokemon);

    mapping (uint => address) public pokemonToOwner;
    mapping (string => string[]) private weaknesessType;
    mapping (address => uint) ownerPokemonCount;

 
    function searchPokemon(uint _id) public view thereArePokemon returns(Pokemon memory resultingPokemon) {
      for (uint i = 0; i <= pokemons.length; i++) {
        if (pokemons[i].id == _id) {
          Pokemon memory _resultingPokemon = pokemons[i];
          return _resultingPokemon;
        }
      }
    }

    function addPokemonWeaknesess(string memory _pokemonName, string[] memory _weaknesess ) private {
      weaknesessType[_pokemonName] = _weaknesess; 
    }

    modifier thereArePokemon() {
      require(pokemons.length > 0, "There are no pokemons. Please, create your first pokemon.");
      _;
    }

    modifier greaterThanZero(uint _id, string memory _name) {
      require(_id > 0, "id must be greater than zero. You enter a number greater than zero.");
      require(bytes(_name).length > 2, "The pokemon's name must be greater than 2 characters. Please enter a name greater than 2 characters.");
      _;
    }
    

    function createPokemon (
          string memory _name, 
          uint _id, 
          string memory _initialAbilityName, 
          string memory _initialAbilityDescription,
          string[] memory _pokemonTypes,
          string[] memory _pokemonWeaknesess) public greaterThanZero(_id, _name) {

              string memory _initialAbility = string(bytes.concat(" - ", bytes(_initialAbilityName), " - ", bytes(_initialAbilityDescription)));

              pokemons.push(Pokemon(_id, _name, _initialAbility, _pokemonTypes));
              addPokemonWeaknesess(_name, _pokemonWeaknesess);
              pokemonToOwner[_id] = msg.sender;
              ownerPokemonCount[msg.sender]++;

              emit eventNewPokemon(searchPokemon(_id));
    }

    function queryPokemonType(uint _id) public view thereArePokemon returns(string memory pokemonName, string[] memory thePokemonTypes) {
      thePokemonTypes = searchPokemon(_id).types;
      pokemonName = searchPokemon(_id).name;
    }

    function queryPokemonAbilities(uint _id) public view thereArePokemon returns(string memory pokemonName, string memory thePokemonAbility) {
      thePokemonAbility = searchPokemon(_id).ability;
      pokemonName = searchPokemon(_id).name;
    }

    function queryPokemonWeaknesess(string memory _name) public view returns(string[] memory) {
      return weaknesessType[_name];
    }

    function getAllPokemons() public view thereArePokemon returns (Pokemon[] memory) {
      return pokemons;
    }
}