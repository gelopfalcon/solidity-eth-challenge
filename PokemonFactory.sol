// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Ability {
        string name;
        string description;
    }

    enum Element {
        Bug,
        Dragon,
        Fairy,
        Fire,
        Ghost,
        Ground,
        Normal,
        Psychic,
        Steel,
        Dark,
        Electric,
        Fighting,
        Flying,
        Grass,
        Ice,
        Poison,
        Rock,
        Water
    }

    struct Pokemon {
        uint256 id;
        string name;
        Ability[] abilities;
        Element[] types;
        Element[] weaknesses;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    event eventNewPokemon(address owner, uint256 id, string name);

    modifier correctPokemonData(
        string memory _name,
        uint256 _id,
        Element[] memory types,
        Element[] memory weaknesses
    ) {
        // We need to verify if the id is greater than 0
        require(_id > 0, "The id must be greater than 0");
        // We need to verify if name is not empty
        require(
            bytes(_name).length > 2,
            "The name cannot be empty and must be longer than two characters"
        );
        // We need to verify if the types length is less or equal than 2
        require(types.length <= 2, "A pokemon can only have two types maximum");
        // We need to verify if the weaknesses length is less or equal than 5
        require(
            weaknesses.length <= 5,
            "A pokemon can only have two weaknesses maximum"
        );
        // We need to check if weaknesses and types are different
        for (uint256 i = 0; i < weaknesses.length; i++) {
            for (uint256 j = 0; j < types.length; i++) {
                require(
                    weaknesses[i] != types[j],
                    "Weaknesses and types must be different"
                );
            }
        }
        // The function is inserted where this symbol appears
        _;
    }

    function createPokemon(
        string memory _name,
        uint256 _id,
        Ability[] memory abilities,
        Element[] memory types,
        Element[] memory weaknesses
    ) public correctPokemonData(_name, _id, types, weaknesses) {
        pokemons.push();
        uint256 index = pokemons.length - 1;
        pokemons[index].id = _id;
        pokemons[index].name = _name;
        uint256 i = 0;
        for (i = 0; i < abilities.length; i++) {
            pokemons[index].abilities.push(abilities[i]);
        }
        for (i = 0; i < types.length; i++) {
            pokemons[index].types.push(types[i]);
        }
        for (i = 0; i < weaknesses.length; i++) {
            pokemons[index].weaknesses.push(weaknesses[i]);
        }
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, _id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}
