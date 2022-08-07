// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    string[] pokemonType;
    string[] pokemonWeaknesses;
    Ability[] ability;
  }

    struct Ability {
      string name;
      string description;
    }


    Pokemon[] private pokemons;


    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(address, string _name, uint _id, string _msg);

     function createPokemon (
        string memory _name, 
        uint _id,
        string[] memory _pokemonType,
        string[] memory _pokemonWeaknesses,
        string[] memory _abilityName,
        string[] memory _abilityDescription
       ) public {
         require(_id > 0, 'id should be greater than 0' );
         require(bytes(_name).length != 0 && bytes(_name).length > 2, 'name should contain at least 3 characters' );
        pokemons.push();
        pokemons[pokemons.length - 1].id = _id;
        pokemons[pokemons.length - 1].name = _name;

        addPokemonType( pokemons.length -1, _pokemonType);
        addPokemonWeaknesses( pokemons.length -1, _pokemonWeaknesses);
        addPokemonAbilities( pokemons.length -1, _abilityName, _abilityDescription);

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender,  _name, _id, 'pokemon created');
    }

    function addPokemonType( uint _index, string[] memory _pokemonTypes) private {
      for(uint i=0; i < _pokemonTypes.length; i++) {
        pokemons[_index].pokemonType.push(_pokemonTypes[i]);
      }
    }

    function addPokemonWeaknesses( uint _index, string[] memory _pokemonWeaknesses) private {
      for(uint i=0; i < _pokemonWeaknesses.length; i++) {
        pokemons[_index].pokemonWeaknesses.push(_pokemonWeaknesses[i]);
      }
    }

    function addPokemonAbilities( uint _index, string[] memory _abilityName, string[] memory _abilityDescription) private {
      for(uint i=0; i < _abilityName.length; i++) {
        pokemons[_index].ability.push(Ability(_abilityName[i], _abilityDescription[i]));
      }
    }


    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getPokemon(uint _index ) public view returns (Pokemon memory) { //Get pokemon by index array
      return pokemons[_index];
    }

 
    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
