// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event eventNewPokemon(Pokemon pokemon);

    enum Type {
        Normal,
        Fire,
        Water,
        Grass,
        Electric,
        Ice,
        Fighting,
        Poison,
        Ground,
        Flying,
        Psychic,
        Bug,
        Rock,
        Ghost,
        Dragon,
        Dark,
        Steel,
        Fairy
    }

    struct Ability {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
        Type[] types;
        Type[] weaknesses;
    }

    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    function createPokemon(
        string memory _name,
        uint _id,
        Ability[] memory _abilities,
        Type[] memory _types,
        Type[] memory _weaknesses
    ) public {
        require(_id > 0, "Id must be greater than 0");
        require(bytes(_name).length > 2, "Name must be greater than 2");

        pokemons.push();

        uint lastIndex = pokemons.length - 1;

        pokemons[lastIndex].name = _name;
        pokemons[lastIndex].id = _id;

        for (uint i = 0; i < _abilities.length; i++) {
            pokemons[lastIndex].abilities.push(_abilities[i]);
        }

        for (uint i = 0; i < _types.length; i++) {
            pokemons[lastIndex].types.push(_types[i]);
        }

        for (uint i = 0; i < _weaknesses.length; i++) {
            pokemons[lastIndex].weaknesses.push(_weaknesses[i]);
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(pokemons[pokemons.length - 1]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getResult() public pure returns (uint product, uint sum) {
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    }
}
