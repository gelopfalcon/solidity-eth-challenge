// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    uint16[] skills;
    uint8[] types;
    uint8[] weaknesses;
  }

  struct PokemonSkill{
    uint id;
    string name;
    string description;
  }

  struct PokemonType{
    uint id;
    string name;
    string description;
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    PokemonSkill[] public pokemonSkills;
    PokemonType[] public pokemonTypes;

    event eventNewPokemon (Pokemon _pokemon);
    event newPokemosSkill (uint _id,PokemonSkill _pokemonSkill);
    event newPokemosType (uint _id,PokemonType _pokemonType);

    constructor () {
      createPokemonType("Fire","Fire type pokemon are weak against water and grass type pokemon");
      createPokemonType("Water","Water type pokemon are weak against grass and electric type pokemon");
      createPokemonType("Grass","Grass type pokemon are weak against fire and ice type pokemon");
      createPokemonType("Electric","Electric type pokemon are weak against ground type pokemon");
      createPokemonType("Ice","Ice type pokemon are weak against fire and fighting type pokemon");
      createPokemonType("Fighting","Fighting type pokemon are weak against flying and psychic type pokemon");

      createPokemonSkill("Tackle","A physical attack in which the user charges and slams into the target with its whole body.");
      createPokemonSkill("Ember","The target is attacked with small flames. This may also leave the target with a burn.");
      createPokemonSkill("Vine Whip","The target is struck with slender, whiplike vines to inflict damage.");
      createPokemonSkill("Water Gun","The target is blasted with a forceful shot of water.");
      createPokemonSkill("Take Down","A reckless, full-body charge attack for slamming into the target. This also damages the user a little.");
      createPokemonSkill("Bite","The target is bitten with viciously sharp fangs. This may also make the target flinch.");
      createPokemonSkill("Flamethrower","The target is scorched with an intense blast of fire. This may also leave the target with a burn.");
    }


    function createPokemonSkill(string memory _name,string memory _description) public returns (uint){
      require(bytes(_name).length >= 2, "Name must be at least 2 characters long");
      require(pokemonSkills.length < 500, "Maximum number of skills reached");
      uint id = pokemonSkills.length;
      pokemonSkills.push(PokemonSkill(id,_name,_description));
      emit newPokemosSkill(id,PokemonSkill(id,_name,_description));
      return id;
    }

    function createPokemonType(string memory _name,string memory _description) public returns (uint){
      require(bytes(_name).length >= 2, "Name must be at least 2 characters long");
      require(pokemonTypes.length < 50, "Maximum number of types reached");
      uint id = pokemonTypes.length;
      pokemonTypes.push(PokemonType(id,_name,_description));
      emit newPokemosType(id,PokemonType(id,_name,_description));
      return id;
    }

    function createPokemon (string calldata _name, uint _id,uint16[] calldata _skills,uint8[] calldata _types,uint8[] calldata _weaknesses) public {
      require(_id>0, "Id must be greater than 0");
      require(bytes(_name).length >= 2, "Name must be at least 2 characters long");
      require(_types.length > 0, "Pokemon must have at least one type");
      require(_weaknesses.length > 0, "Pokemon must have at least one weakness");
      require(verifyPokemon(_skills,_types,_weaknesses), "Pokemon skills, types and weaknesses must be valid");
      pokemons.push(Pokemon(_id,_name,_skills,_types,_weaknesses));
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(Pokemon(_id,_name,_skills,_types,_weaknesses));
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function verifyPokemonSkill (uint16[] memory skills) private view returns (bool){
      require(skills.length > 0, "Pokemon must have at least one skill");
      require(skills.length <= 4, "Pokemon must have at most 4 skills");
      for (uint i = 0; i < skills.length; i++) {
        if(skills[i] >= pokemonSkills.length){
          return false;
        }
      }
      return true;
    }

    function verifyPokemonType (uint8[] memory types) private view returns (bool){
      for (uint i = 0; i < types.length; i++) {
        if(types[i] >= pokemonTypes.length){
          return false;
        }
      }
      return true;
    }

    function verifyPokemon(uint16[] memory _skills,uint8[] memory _types,uint8[] memory _weaknesses) public view returns (bool){
      return verifyPokemonSkill(_skills) && verifyPokemonType(_types) && verifyPokemonType(_weaknesses);
    }

}

// Goerli Contract address: 0x5FbDB2315678afecb367f032d93F642f64180aa3