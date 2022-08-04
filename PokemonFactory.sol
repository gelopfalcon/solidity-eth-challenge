// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

 
  struct Ability {
    string name;
    string description;
  }

   struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
  
  }

  event eventNewPokemon(
    uint newPokemonId,
    string newPokemonName,
    string[] newHabilityName
  );

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
  


    modifier conditionId(uint _id){
      require(
       _id > 0,
       "El Id debe ser mayor a 0"
      );
      _;
    }

    modifier conditionName(string memory _name){
      require(
       bytes(_name).length > 2,
       "El nombre debe tener mas de dos carcateres"
      );
      _;
    }


     function createPokemon (string memory _name, uint _id, string[] memory _abilityName,string[] memory _abilityDescription) public conditionId(_id) conditionName(_name) {


        pokemons.push();
        uint index = pokemons.length - 1;
        pokemons[index].id= _id;
        pokemons[index].name=_name;
      

        for(uint i = 0; i < _abilityName.length; i++){
            pokemons[index].abilities.push(Ability({name: _abilityName[i], description: _abilityDescription[i]}));
        }



        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id, _name, _abilityName);
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
