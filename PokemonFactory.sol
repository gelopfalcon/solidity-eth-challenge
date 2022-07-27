// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event eventNewPokemon(string _name);

    struct Skill {
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
        Skill[] skills;
        Type[] types;
        Weakness[] weaknesses;
    }


    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    function createPokemon(
        string memory _name,
        uint _id,
        Skill[] memory _skill,
        Type[] memory _types,
        Weakness[] memory _weaknesses
    ) public {
        require(_id > 0, "The id must be greater than 0");
        require(
            bytes(_name).length > 2,
            "The name must have more than 2 characters"
        );

        pokemons.push();
        pokemons[pokemons.length - 1].id = _id;
        pokemons[pokemons.length - 1].name = _name;

        for (uint i = 0; i < _skill.length; i++) {
            pokemons[pokemons.length - 1].skills.push(
                Skill(_skill[i].name, _skill[i].description)
            );
        }

        for (uint i = 0; i < _types.length; i++) {
            pokemons[pokemons.length - 1].types.push(Type(_types[i].name));
        }

        for (uint i = 0; i < _weaknesses.length; i++) {
            pokemons[pokemons.length - 1].weaknesses.push(
                Weakness(_weaknesses[i].name)
            );
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(_name);
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