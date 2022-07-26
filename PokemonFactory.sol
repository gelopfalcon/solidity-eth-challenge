// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Type {
        string TypeName;
        string TypeDescription;
    }

    struct Ability {
        uint id;
        string name;
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

        Ability[] private abilities;

    event eventNewAbility(uint _id, string _name);

    mapping (uint => address) public AbilityToOwner;
    mapping (address => uint) ownerAbilityCount;

    function createAbility (uint _id, string memory _name) public {
        abilities.push(Ability(_id, _name));
        AbilityToOwner[_id] = msg.sender;
        ownerAbilityCount[msg.sender]++;
        emit eventNewAbility(_id, _name);
    }

    function getAllPokemons() public view returns (PokemonID[] memory) {
      return pokemons;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
