// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint32 id;
    uint32[4] idSkills; 
    string name;
  }

  struct Skill{
    string Name;
    string Description;
  }

    
    uint128 public currentIdxPokemon;
    uint128 public currentIdxSkill;
    Pokemon[] private pokemons;
    Skill[] private skills;
    

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    constructor(){
      addSkill("Tackle", "Charges the foe with a full-body tackle.");
      addSkill("Growl", "Lowers the Attack of all foes in the room by one level.");
      addSkill("Leech Seed", "Inflicts the Leech Seed status on the target. The target's HP is leeched every several turns to restore the user's HP.");
      addSkill("Vine Whip", "Strikes the foe with slender, whiplike vines.");
    }

    event eventNewPokemon( uint _id, string _name );
    event eventMessage( Pokemon pokemon );

    function createPokemon ( uint32 _id , uint32[4] memory _idSkills, string memory _name) public {
        require(_id > 0, "_id must be greater than 0.");
        require(bytes(_name).length > 2, "_name must be greater than 2 characters.");
        for(uint i = 0; i < 4; i++){
          getSkillsbyIndex(_idSkills[i]);
        }
        pokemons.push(Pokemon(_id, _idSkills,_name));
        currentIdxPokemon++;
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon( _id, _name );
    }

    function skillByPokemon (uint _idPokemon) public view returns (Skill[4] memory){
      Pokemon memory _pokemon = pokemons[_idPokemon];
      Skill[4] memory _skillsPokemon;
      for(uint i = 0; i < 4; i++){
        _skillsPokemon[i] = getSkillsbyIndex(_pokemon.idSkills[i]);
      }
      return _skillsPokemon;
    }

    function getSkillsbyIndex (uint _idxSkill) public view returns (Skill memory) {
      require(_idxSkill < currentIdxSkill, "No existe this skill index");
      return skills[_idxSkill];
    }

    function addSkill(string memory _name, string memory _description) public {
      skills.push(Skill(_name, _description));
      currentIdxSkill++;
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
