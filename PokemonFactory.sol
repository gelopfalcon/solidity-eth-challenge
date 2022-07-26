// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Type {
        uint id;
        string name;
        string description;
    }

    struct Ability {
        uint id;
        string name;
        string description;
    }

    struct PokemonID {
        uint id;
        string name;
    }

    PokemonID[] private pokemons;

    event eventNewPokemon(uint _id, string _name);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon (uint _id, string memory _name) public {
        require(_id > 0, "Pokemon's ID must be greater than 0");
        pokemons.push(PokemonID(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id, _name);
    }

    function getAllPokemons() public view returns (PokemonID[] memory) {
      return pokemons;
    }


    Ability[] private abilities;

    event eventNewAbility(uint _id, string _name, string _description);

    mapping (uint => address) public AbilityToOwner;
    mapping (address => uint) ownerAbilityCount;

    function createAbility (uint _id, string memory _name, string memory _description) public {
        require(_id > 0, "Ability's ID must be greater than 0");
        require(bytes(_name).length > 2, "Ability's Name must be longer than 2 characters");
        require(bytes(_description).length > 2, "Ability's Description must be longer than 2 characters");
        abilities.push(Ability(_id, _name, _description));
        AbilityToOwner[_id] = msg.sender;
        ownerAbilityCount[msg.sender]++;
        emit eventNewAbility(_id, _name, _description);
    }

    function getAllAbilities() public view returns (Ability[] memory) {
      return abilities;
    }


    Type[] private types;

    event eventNewType(uint _id, string _name, string _description);

    mapping (uint => address) public TypeToOwner;
    mapping (address => uint) ownerTypeCount;

    function createType (uint _id, string memory _name, string memory _description) public {
        require(_id > 0, "Type's ID must be greater than 0");
        require(bytes(_name).length > 2, "Types's Name must be longer than 2 characters");
        require(bytes(_description).length > 2, "Types's Description must be longer than 2 characters");
        types.push(Type(_id, _name, _description));
        TypeToOwner[_id] = msg.sender;
        ownerTypeCount[msg.sender]++;
        emit eventNewType(_id, _name, _description);
    }

    function getAllTypes() public view returns (Type[] memory) {
      return types;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
