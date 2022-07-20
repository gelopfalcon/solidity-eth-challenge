// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Ability [] abilities;
    Type [] isType;
    Type [] weakness;
  }

  struct Ability {
      string name;
      string description;
  }

  enum Type{
      Grass,
      Poison,
      Fire,
      Flying,
      Psychic
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(Pokemon _pokemon);

    
     function createPokemon (string memory _name, uint _id, string[] memory _abilitiesNames, string[] memory _abilitiesDesc, Type[] memory _isType, Type[] memory _weakness) public{
        require(_id>0, 'The pokemon id must be greater than 0');
        require(bytes(_name).length>1, 'The name must be not empty and have 2 or more characters');

        uint index=pokemons.length;
        pokemons.push();
        pokemons[index].name=_name;
        pokemons[index].id=_id;

        for(uint i=0; i < _abilitiesNames.length; i++) {
            pokemons[index].abilities.push(
                Ability(_abilitiesNames[i], _abilitiesDesc[i])
            );
        }

        for(uint i=0; i < _isType.length; i++) {
            pokemons[index].isType.push(_isType[i]);
        }

         for(uint i=0; i < _weakness.length; i++) {
            pokemons[index].isType.push(_weakness[i]);
        }
        
        emit eventNewPokemon(pokemons[index]);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
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
