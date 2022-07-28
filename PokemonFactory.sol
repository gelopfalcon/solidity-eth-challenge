// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
    string[] types;
    string[] weaknesses;
  }

  struct Ability {
    string name;
    string description;
  }

  event eventNewPokemon(uint idPokemon, string pokemonName);

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     function createPokemon (string memory _name, uint _id, string[] memory _abilitiesName, string[] memory _abilitiesDesc, string[] memory _types, string[] memory _weaknesses) public {
        require(_id > 0, "ID Must be greater than 0");
        require(bytes(_name).length > 2, "Name invalid, name length cannot be less than 2 chars");
        require(_abilitiesName.length == _abilitiesDesc.length, "Arrays must have same sizes");

        pokemons.push();
        pokemons[pokemons.length-1].id = _id;
        pokemons[pokemons.length-1].name = _name;
        pokemons[pokemons.length-1].types = _types;
        pokemons[pokemons.length-1].weaknesses = _weaknesses;
        
        for(uint i=0; _abilitiesName.length > i; i++){
          pokemons[pokemons.length-1].abilities.push(
            Ability(
                _abilitiesName[i],
                _abilitiesDesc[i]
            )
          );
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        

        emit eventNewPokemon(_id, _name);
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
