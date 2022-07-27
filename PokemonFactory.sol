// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Skill {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
    }
    

    event eventNewPokemon(Pokemon pokemon);

    Pokemon[] private pokemons;

    mapping (uint => Skill[]) public pokemonToSkills;
    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon (string memory _name, uint _id, Skill[] memory _skills) public {
        require(_id > 0, "Id should be more than 0.");
        require(bytes(_name).length >= 2, "Name needs at least two letters");
        uint256 length = _skills.length;
        for (uint256 i = 0; i < length; i+=1) {
            pokemonToSkills[_id].push(Skill(_skills[i].name,_skills[i].description));
        }
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(Pokemon(_id, _name));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getPokemonSkills(uint256 _id) public view returns (Skill[] memory) {
      return pokemonToSkills[_id];
    }

    function getResult() public pure returns(uint product, uint sum, uint d){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
      d = bytes("pa").length;
   }

}

contract PokemonFactory {

    struct Pokemon {
        uint id;
        string name;
    }

    event eventNewPokemon(Pokemon pokemon);

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon (string memory _name, uint _id) public {
        require(_id > 0, "Id should be more than 0.");
        require(bytes(_name).length >= 2, "name needs at least two letters");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(Pokemon(_id, _name));
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
