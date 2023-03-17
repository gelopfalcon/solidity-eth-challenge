// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Tipos [] Type;
    Tipos [] Weaknesses;
  }

  struct Habilities {
    string Name;
    string Description;
  }

  event eventNewPokemon(
    uint id, 
    string name
  );

  modifier onlyId (uint _id) {
    require( _id > 0,
    "El id de tu pokemon debe ser mayor a 0");
    _;
  }

  modifier onlyName (string memory _name) {
    require( bytes(_name).length > 2,
    "El nombre de tu pokemon debe ser mayor a 2 caracteres");
    _;
  }

    Pokemon[] private pokemons;
    Habilities[] private habilities;

    enum Tipos {fire, water, grass, electric, psychic, ghost, dragon, normal, fighting, flying, poison, ground, rock, bug, steel, fairy, ice, dark}

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     function createPokemon (uint _id, string memory _name, Tipos[] memory _Type, Tipos[] memory _Weaknesses) public onlyId(_id) onlyName(_name) {
        pokemons.push(Pokemon(_id, _name, _Type, _Weaknesses));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id, _name);
    }

    function evolutionPokemon (string memory _Name, string memory _Description, uint _id) public {
        habilities.push(Habilities(_Name, _Description));
        pokemonToOwner[_id] = msg.sender;
    }

    function getAllPokemons() public view returns (Pokemon[] memory, Habilities[] memory) {
        return (pokemons, habilities);
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}