// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Skill {
      string name;
      string description;
    }

    struct Type {
      string name;
      string[] weaknesses;
    }

    struct Pokemon {
      uint8 id;
      string name;
    }

    Pokemon[] private pokemons;

    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;
    mapping (uint8 => Skill[]) public skills;
    mapping (uint8 => Type) public types;
    mapping (uint8 => uint8) public typesByPokemonId;

    modifier validaciones(uint8 _id, string memory _name, uint8 _idType){
        require(
            _id > 0,
            "EL id debe ser mayor a '0'"
        );
        _;
         require(
            bytes(_name).length > 2,
            "EL nombre debe ser mayor a 2 caracteres"
        );
        _;
         require(
            bytes(types[_idType].name).length > 0,
            "EL id de 'Tipo' debe coincidir con un id existente"
        );
        _;
    }

    event eventNewPokemon(Pokemon _pokemon);
    event eventAddedSkill(Skill[] _skill);
    event eventAddedType(Type _type);

    
    function createPokemon (string memory _name, uint8 _id, uint8 _idType) public validaciones(_id, _name, _idType) {
      pokemons.push(Pokemon(_id, _name));
      typesByPokemonId[_id] = _idType;
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(pokemons[(pokemons.length - 1)]);
    }

    function addSkills (uint8 _idPokemon, string memory _name, string memory _description) public {
      skills[_idPokemon].push(Skill(_name, _description));
      emit eventAddedSkill(skills[_idPokemon]);
    }

    function addTypes (uint8 _id, string memory _name, string[] memory _weaknesses) public {
      types[_id] = Type(_name, _weaknesses);
      emit eventAddedType(types[_id]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getSkillsByPokemon(uint8 _idPokemon) public view returns (Skill[] memory) {
      return skills[_idPokemon];
    }

    function getTypesByPokemon(uint8 _idPokemon) public view returns (Type memory) {
      return types[typesByPokemonId[_idPokemon]];
    }

    function getWeaknessesByPokemon(uint8 _idPokemon) public view returns (string[] memory) {
      return types[typesByPokemonId[_idPokemon]].weaknesses;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }
}
