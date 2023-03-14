// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    string name;
    uint256 id;
    Abilities[] personalAbilities;
    Types[] personalTypes;
    Weaknesses [] weaknesses;
  }

  struct Abilities {
    string name;
    string description;
  }

  struct Weaknesses {
    string name;
  }

  enum Types {
    Normal,
    Fire,
    Water,
    Grass,
    Electric,
    Ice,
    Fighting,
    Poison,
    Ground,
    Flying,
    Psychic,
    Bug,
    Rock,
    Ghost,
    Dark,
    Dragon,
    Steel,
    Fairy
  }

    Pokemon[] private pokemons;
    Types[] public types;
    Abilities[] public abilities;

    event eventNewPokemon (uint256 id, string name);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;


     function createPokemon (string memory _name, uint256 _id, Abilities[] memory _abilities, Types[] memory _pokemonType, Weaknesses[] memory _weaknesses) public {
      require(_id > 0, "Id must be greater than zero");
      require(bytes(_name).length != 0 && bytes(_name).length > 2, "Name must not be empty and It has to have more than two characters");
      pokemons.push(Pokemon(_name, _id, _abilities, _pokemonType, _weaknesses));
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(_id, _name);
    }

    function createAbilities(string memory _name, string memory _description) public  {
      abilities.push(Abilities(_name, _description));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

}