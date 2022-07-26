// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Type{
        uint id;
        string name;
    }

    struct Ability{
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
        Type[] types;
        Type[] weakness;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon(string _name, uint _id);

    function createPokemon (string memory _name, uint _id,string memory _nameSkill, string memory _descriptionSkill, string[] memory _types, string[] memory _weakness) public {
        require(_id > 0, "Id must be greater than 0");
        require(bytes(_name).length != 0,"a name is required");
        require(bytes(_name).length > 2, "name must be greater than 2 characters");
        Pokemon storage _pokemon = pokemons.push();
        _pokemon.id = _id;
        _pokemon.name = _name;
        _pokemon.abilities.push(Ability(_nameSkill,_descriptionSkill));
        for(uint i = 0; i<_types.length;i++){
            _pokemon.types.push(Type(i,_types[i]));
        }
        for(uint i = 0; i<_weakness.length;i++){
            _pokemon.types.push(Type(i,_weakness[i]));
        }
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name,_id);
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