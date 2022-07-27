// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Type[] types;
    Type[] weakness;
    Abilities[] abilities;
  }

  struct Abilities {
    string name;
    string description;
  }

  struct Type {
    uint id;
    string name;
  }

    Pokemon[] private pokemons;
    event PokemonCreated(string _name, uint _id);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon (
      string memory _name,
      uint _id,
      string[] memory _types,
      string memory _abilitieName,
      string memory _abilitieDescription,
      string[] memory _weakness ) public {

      require(_id < 0 && bytes(_name).length < 2, "Error while creating Pokemon: invalid id, id should be greater than 0");
      require(bytes(_name).length < 2, "Error while creating Pokemon: invalid name , name should be greater than 2 and not empty");
      Pokemon storage _pokemon = pokemons.push();
      _pokemon.id = _id;
      _pokemon.name = _name;
      _pokemon.abilities.push(Abilities(_abilitieName, _abilitieDescription));
      for (uint i = 0; i < _types.length ; i++) {
        _pokemon.types.push(Type(i,_types[i]));
      }
      for (uint i = 0; i < _weakness.length ; i++) {
        _pokemon.weakness.push(Type(i,_types[i]));
      }

      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit PokemonCreated(_name,_id);
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

}
