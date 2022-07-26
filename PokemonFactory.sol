// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Type {
        string name;
    }

    struct Weakness {
        string name;
    }

    struct Ability {
        string name;
        string description;
    }

    struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
    Type[] types;
    Weakness[] weaknesses;
    }

    Pokemon[] private pokemons;

    event eventNewPokemon(string _name, uint _id);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     function createPokemon (string memory _name, uint _id) public {
        require (_id > 0, "El Id debe ser mayor a 0");
        require (bytes(_name).length > 0 || bytes(_name).length > 2, "El nombre del Pokemon debe tener mas de 2 caracteres");
        Pokemon storage pokemon = pokemons.push();
        pokemon.id=_id;
        pokemon.name=_name;
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name, _id);
    }

    function addAbility(uint _pokemonId, string memory _abilityName, string memory _abilityDescription) public {
        require(_pokemonId >= 0, "El Id del pokemon debe ser mayor a 0");
        pokemons[_pokemonId].abilities.push(Ability(_abilityName, _abilityDescription));
    }

    function addType(uint _pokemonId, string memory _typeName) public {
        require(_pokemonId >= 0, "El Id del pokemon debe ser mayor a 0");
        pokemons[_pokemonId].types.push(Type(_typeName));
    }

     function addWeakness(uint _pokemonId, string memory _weaknessName) public {
        require(_pokemonId >= 0, "El Id del pokemon debe ser mayor a 0");
        pokemons[_pokemonId].weaknesses.push(Weakness(_weaknessName));
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
