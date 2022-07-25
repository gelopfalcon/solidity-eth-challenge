// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event eventNewPokemon(uint _id, string _name);

    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
        Type[] types;
        Weakness[] weaknesses;
    }

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

    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    function createPokemon(
        string memory _name,
        uint _id,
        Ability[] memory _ability,
        Type[] memory _types,
        Weakness[] memory _weaknesses
    ) public {
        require(_id > 0, "The id must be greater than 0");
        require(
            bytes(_name).length > 2,
            "The name cannot be empty and be greater than 2"
        );
        require(
            _ability.length > 0 && _ability.length <= 4,
            "Abilities must be greater than 0 and less than 4"
        );
        require(_types.length > 0, "Types must be greater than 0");
        require(
            _weaknesses.length > 0,
            "Weaknesses must be greater than 0 and less than 4"
        );

        pokemons.push();
        pokemons[pokemons.length - 1].id = _id;
        pokemons[pokemons.length - 1].name = _name;

        for (uint i = 0; i < _ability.length; i++) {
            pokemons[pokemons.length - 1].abilities.push(
                Ability(_ability[i].name, _ability[i].description)
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
        emit eventNewPokemon(_id, _name);
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
