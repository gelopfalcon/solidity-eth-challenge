// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Ability {
        string name;
        string description;
    }
    
    struct Pokemon {
      uint id;
      string name;
      Ability[] abilities;
      string[] types;
      string[] weaknesses;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;

    // evento que se va a disparar
    event eventNewPokemon(Pokemon pokemon);

    function createPokemon (
      string memory _name,
      uint _id,
      string[] memory _abilityNames,
      string[] memory _abilityDescriptions,
      string[] memory _types,
      string[] memory _weaknesses
    ) public isGreaterZero(_id) pokemonNameRule(_name) {
      uint _newPokemonIndex = pokemons.length;
      pokemons.push();
      pokemons[_newPokemonIndex].name = _name;
      pokemons[_newPokemonIndex].id = _id;
      
      addAbilities(_newPokemonIndex, _abilityNames, _abilityDescriptions);
      pokemons[_newPokemonIndex].weaknesses = _weaknesses;
      pokemons[_newPokemonIndex].types = _types;

      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon (pokemons[_newPokemonIndex]);
    }

    modifier isGreaterZero(uint _number) {
        require(_number > 0, "Require id greater 0");
        _;
    }

    modifier pokemonNameRule(string memory _name) {
        require(bytes(_name).length > 2, "Name require 2 or more characters");
        _;
    }

    function getAllPokemons() external view returns (Pokemon[] memory) {
      return pokemons;
    }

    function addAbilities(uint _indexPokemon, string[] memory _abilityNames, string[] memory _abilityDescriptions) private {
      require(_abilityNames.length == _abilityDescriptions.length, "Debera tener el mismo tamabo");
      for (uint i = 0 ; i < _abilityNames.length; i++) {
        pokemons[_indexPokemon].abilities.push(
          Ability(_abilityNames[i], _abilityDescriptions[i])
        );
      }
    }

    function getResult() external pure returns(uint product, uint sum){
      // Pure solo usa los parametros, no lee el estado ni tampoco lo modifica.
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
    }

}
