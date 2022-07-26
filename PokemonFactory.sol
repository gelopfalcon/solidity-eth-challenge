// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
    }

    struct Ability {
        string name;
        string description;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => Ability[]) abilities;
    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    event eventNewPokemon(string pokemonName, uint256 pokemonId);
    event eventNewAbility(string name, string description, uint256 pokemonId);

    function createPokemon(string memory _name, uint256 _id) public {
        require(_id > 0, "The pokemon id should be greather than 0");
        require(
            bytes(_name).length > 2,
            "The pokemon name should have more that two characters."
        );
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name, _id);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getResult() public pure returns (uint256 product, uint256 sum) {
        uint256 a = 1;
        uint256 b = 2;
        product = a * b;
        sum = a + b;
    }

    function addAbility(
        string memory _abilityName,
        string memory _abilityDescription,
        uint256 _pokemonId
    ) public {
        require(
            bytes(_abilityName).length > 2,
            "The abilities name should have more that two characters."
        );

        abilities[_pokemonId].push(Ability(_abilityName, _abilityDescription));
        emit eventNewAbility(_abilityName, _abilityDescription, _pokemonId);
    }
}
