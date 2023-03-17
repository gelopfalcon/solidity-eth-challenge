// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

 
 
  struct Pokemon {
    uint id;
    string name;
    Tipos [] Type;
    Tipos [] Weaknesses;
    uint[] Habilities;
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
  modifier onlyOwner(uint _id) {
    require(msg.sender == pokemonToOwner[_id], 
    "este pokemon no es tuyo");
    _;
  }

    Pokemon[] private pokemons;

    enum Tipos {fire, water, grass, electric, psychic, ghost, dragon, normal, fighting, flying, poison, ground, rock, bug, steel, fairy, ice, dark}

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Habilities[]) public pokemonHabilities;

     function createPokemon (uint _id, string memory _name, Tipos[] memory _Type, Tipos[] memory _Weaknesses, uint[] memory _habilities) public onlyId(_id) onlyName(_name) {
        pokemons.push(Pokemon(_id, _name, _Type, _Weaknesses, _habilities));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        for (uint i = 0; i < _habilities.length; i++) {
            pokemonHabilities[_id].push(Habilities("",""));
        }

        emit eventNewPokemon(_id, _name);
    }

    function pokemonEvolution (uint _pokemonId, uint _habilityIndex, string memory _name, string memory _description) public  onlyOwner(_pokemonId){
        pokemonHabilities[_pokemonId][_habilityIndex] = Habilities(_name, _description);

    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return (pokemons);
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}