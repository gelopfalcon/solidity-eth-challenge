// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    Skill[] skills;
  }

  struct Skill {
      string name;
      string description;
  }


    Pokemon[] private pokemons;

    event eventNewPokemon(Pokemon);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    

     function createPokemon (string memory _name, uint _id, string[] memory _skillsName , string[] memory _skillDescription) public {

        require(_id>0, "Id must be greater than zero"); 

        bytes memory b = bytes(_name);

        require(b.length > 0 ,"the pokemon name must not be empty");
        require(b.length > 2 ,"pokemon name must be greater than 2 characters");

        pokemons.push();
        uint index=pokemons.length-1;
        pokemons[index].name=_name;
        pokemons[index].id=_id;


        addSkills(_id, _skillsName, _skillDescription);


        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(pokemons[index]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function addSkills(uint _index, string[] memory _skillsName, string[] memory _skillsDescription) private {
         for(uint i=0; i < _skillsName.length; i++) {
            pokemons[_index].skills.push(
                Skill(_skillsName[i], _skillsDescription[i])
            );
        }
    } 

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }
    
}