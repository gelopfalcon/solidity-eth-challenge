// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    
  event eventNewPokemon(string _name, uint8 _id);

  struct Ability {
      string name;
      string description;
  }

  struct Pokemon {
    uint8 id;
    string name;
    Ability[] abilities;
  }


    Pokemon[] private pokemons;

    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;

    function createPokemon (string memory _name, uint8 _id, string memory _abilityName, 
            string memory _abilityDescription) public {
            require(_id >= 0, "_id must be greater than 0");
            require(bytes(_name).length > 0, "_name must not be empty");
            require(bytes(_name).length > 2, "_name must be greater than 2");

            Pokemon storage pokemon = pokemons.push();
            pokemon.id=_id;
            pokemon.name=_name;
            pokemon.abilities.push(Ability(_abilityName, _abilityDescription));

            pokemonToOwner[_id] = msg.sender;
            ownerPokemonCount[msg.sender]++;
            emit eventNewPokemon(_name, _id);
    }

    function addAbility(uint8 _id, string memory _abilityName, string memory _abilityDescription) public {
        require(_id >= 0, "_id must be greater than 0");
        pokemons[_id].abilities.push(Ability(_abilityName, _abilityDescription));
    } 

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getResult() public pure returns(uint8 product, uint8 sum){
      uint8 a = 1; 
      uint8 b = 2;
      product = a * b;
      sum = a + b; 
   }

}
