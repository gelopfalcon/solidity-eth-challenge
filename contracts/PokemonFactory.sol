// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Hability {
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    Hability[] habilities;
  }

    Pokemon[] private pokemons;
    Hability[] private habilities;
    event eventNewPokemon(address indexed _own, string _name);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    function createPokemon (string memory _name, uint _id, string memory _habilityName, string memory _habilityDesc) public {
      require(
            _id > 0,
            "Id must be greater than zero"
        );
      require(
          bytes(_name).length > 2,
          "Name must have at least three characters"
      );
      require(
          bytes(_habilityName).length > 2,
          "Hability name must have at least three characters"
      );
      require(
          bytes(_habilityDesc).length > 2,
          "Hability desc must have at least three characters"
      );
        pokemons.push();
        pokemons[pokemons.length - 1].id = _id;
        pokemons[pokemons.length - 1].name = _name;
        pokemons[pokemons.length - 1].habilities.push(createHability(_habilityName, _habilityDesc));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, _name);
    }

    function createHability (string memory _name, string memory _description) public returns(Hability memory hability){
      require(
          bytes(_name).length > 2,
          "Name must have at least three characters"
      );
      require(
          bytes(_name).length > 2,
          "Desc must have at least three characters"
      );
      hability = Hability(_name, _description);
      habilities.push(hability);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }
 function getAllSkills() public view returns (Hability[] memory) {
      return habilities;
    }

}