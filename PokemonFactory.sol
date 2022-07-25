// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    // Structs
    struct Ability {
        string name;
        string description;
    }
    struct Type {
        string name;
    }
    struct Weakness {
        string name;
    }
    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
        Type[] types;
        Weakness[] weaknesses;
    }

    Pokemon[] private pokemons;

    // Mappings
    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    // Events
    event eventNewPokemon(uint newPokemonId, string newPokemonName, string newPokemonAbility, string newPokemonType, string newPokemonWeakness);

    // Functions
    function createPokemon (string memory _name, string memory _mainAbilityName, string memory _mainAbilityDescription, string memory _mainTypeName, string memory _mainWeaknessName) public {
        require(bytes(_name).length > 2, "El nombre del Pokemon tiene que tener mas de 2 caracteres");
        pokemons.push();
        uint _internalIndex = pokemons.length -1;
        pokemons[_internalIndex].id = _internalIndex;
        pokemons[_internalIndex].name = _name;
        addAbility(_internalIndex, _mainAbilityName, _mainAbilityDescription);
        addType(_internalIndex, _mainTypeName);
        addWeakness(_internalIndex, _mainWeaknessName);
        pokemonToOwner[_internalIndex] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_internalIndex, _name, _mainAbilityName, _mainTypeName, _mainWeaknessName);
    }

    function addAbility(uint _id, string memory _abilityName, string memory _abilityDescription) public {
        require(_id >= 0, "El id del Pokemon tiene que ser mayor que 0");
        pokemons[_id].abilities.push(Ability(_abilityName, _abilityDescription));
    }

    function addType(uint _id, string memory _typeName) public {
        require(_id >= 0, "El id del Pokemon tiene que ser mayor que 0");
        pokemons[_id].types.push(Type(_typeName));
    }

    function addWeakness(uint _id, string memory _weaknessName) public {
        require(_id >= 0, "El id del Pokemon tiene que ser mayor que 0");
        pokemons[_id].weaknesses.push(Weakness(_weaknessName));
    }

    function getAllPokemons() public view returns(Pokemon[] memory){
        return pokemons;
    }
}
