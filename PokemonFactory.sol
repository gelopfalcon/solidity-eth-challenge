// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Type[] types;
    Weaknesses[] weaknesses;
    Skill[] skills;
  }
  
  struct Weaknesses {
    string name;
  }

  struct Type {
    uint id;
    string name;
  }

  struct Skill {
    string name;
    string description;
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Pokemon) public pokemonToAttributes;
    mapping (uint => string) public pokemonType;
    uint public amountTypes;
    address public owner;

    event eventNewPokemon(string Pokemon_name);


    function createPokemon (uint _id, string memory _name, Type[] memory _types, Weaknesses[] memory _weaknesses, Skill[] memory _skills, string[] memory _skillDescription) public {
      require(_id > 0, "El ID debe ser mayor a 0");
      require(bytes(_name).length > 2, "Name must have three characters as minimum");
      require(pokemonToOwner[_id] == address(0), "id ocupado");
      require(_skills.length == _skillDescription.length, "La cantidad de nombres y descripciones debe coincidir");
      require(_types.length > 0, "El pokemon debe tene al menos un tipo");
      require(_weaknesses.length > 0, "El pokemon tener al menos una debilidad");
      pokemons.push(Pokemon(_id, _name, _types, _weaknesses, _skills));
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(_name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
  }

  function addingSkills(uint _id, string[] memory _skill, string[] memory _skillDescription) private {
    for(uint i=0; i < _skill.length; i++) {
      pokemons[_id].skills.push(Skill(_skill[i], _skillDescription[i]));
    }
  }
}
