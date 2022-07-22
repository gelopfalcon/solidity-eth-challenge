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

    struct Pokemon {
      uint id;
      string name;
      Ability[] abilities;
      Type[] types;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    // evento que se va a disparar
    event eventNewPokemon(Pokemon pokemon);

    function createPokemon (
      string memory _name,
      uint _id,
      string[] memory _abilityNames,
      string[] memory _abilityDescriptions,
      string[] memory _types
    ) public isGreaterZero(_id) pokemonNameRule(_name) {
      uint _newPokemonIndex = pokemons.length;
      pokemons.push();
      pokemons[_newPokemonIndex].name = _name;
      pokemons[_newPokemonIndex].id = _id;
      
      addAbilities(_newPokemonIndex, _abilityNames, _abilityDescriptions);
      addTypes(_newPokemonIndex, _types);


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

    function getAllPokemons() public view returns (Pokemon[] memory) {
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

    function addTypes(uint _indexPokemon, string[] memory _types) private {
      for (uint i = 0 ; i < _types.length; i++) {
        pokemons[_indexPokemon].types.push(
          Type(_types[i])
          );
      }
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
    }

}
