// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Ability {
        string name;
        string description;
    }

    struct Pokemon {
        uint256 id;
        string name;
        Ability[] abilities;
        string[] types;
        string[] weakness;
    }

    event eventNewPokemon(Pokemon _createdPokemon);

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    function createPokemon(
        string memory _name,
        uint256 _id,
        string[] memory _abilitiesName,
        string[] memory _abilitiesDesc,
        string[] memory _types,
        string[] memory _weakness
    ) public {
        require(_id > 0, "Pokemon Id must be greater than 0");
        if (bytes(_name).length == 0) {
            revert("Name must not be empty");
        }
        if (bytes(_name).length <= 2) {
            revert("Name must be greater than 2 characters");
        }
        require(
            _abilitiesName.length > 0,
            "Pokemon must have at least 1 ability"
        );
        require(
            _abilitiesName.length == _abilitiesDesc.length,
            "List of abilities names and descs must be equals"
        );

        pokemons.push();

        uint256 newIndex = pokemons.length - 1;

        pokemons[newIndex].id = _id;
        pokemons[newIndex].name = _name;

        for (uint256 i; i < _abilitiesName.length; i++) {
            pokemons[newIndex].abilities.push(
                Ability(_abilitiesName[i], _abilitiesDesc[i])
            );
        }

        for (uint256 i; i < _types.length; i++) {
            pokemons[newIndex].types.push(_types[i]);
        }

        for (uint256 i; i < _weakness.length; i++) {
            pokemons[newIndex].weakness.push(_weakness[i]);
        }

        emit eventNewPokemon(pokemons[newIndex]);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}

