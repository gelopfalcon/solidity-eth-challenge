// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
        string[] abilities;
    }

    Pokemon[] private pokemons;

    string[] abilities;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;
    mapping(string => string) AbilityToDescription;

    function createPokemon(
        string memory _name,
        uint256 _id,
        string[] memory _abilitiesNames,
        string[] memory _abilitiesDescriptions
    ) public {
        require(
            _id > 0,
            "El id del pokemon debe ser mayor un numero valido mayor que 0"
        );
        require(
            bytes(_name).length > 2,
            "El nombre del pokemon debe contener al menos 3 letras"
        );

        for (uint8 pos = 0; pos < _abilitiesNames.length; pos++) {
            AbilityToDescription[_abilitiesNames[pos]] = _abilitiesDescriptions[
                pos
            ];
            abilities.push(_abilitiesNames[pos]);
        }

        pokemons.push(Pokemon(_id, _name, abilities));

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    event eventNewPokemon(address indexed _from, string _name);
}
