// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Hability {
        string name;
        string description;
    }

    enum Type {
        Normal,
        Fire,
        Water,
        Grass,
        Fighting,
        Flying,
        Electric,
        Steel,
        Dragon,
        Dark,
        Psychic,
        Ghost,
        Poison,
        Ground,
        Rock,
        Bug,
        Ice,
        Fairy
    }

    struct Pokemon {
        uint id;
        string name;
    }

    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    mapping(uint => Hability[]) public habilities;
    mapping(uint => Type[]) public types;
    mapping(uint => Type[]) public weaknesses;

    event eventNewPokemon(Pokemon);

    function createPokemon(string memory _name, uint _id) public {
        require(_id > 0, "Pokemon's Id must be greater than 0");
        bytes memory name = bytes(_name);
        require(
            name.length > 2,
            "Pokemon's Name should be greater than 2 characters"
        );

        Pokemon memory pokemon = Pokemon(_id, _name);

        pokemons.push(pokemon);
        // pokemonToOwner[_id] = msg.sender;
        // ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(pokemon);
    }

    function addType(uint _pokemonId, Type _type) public {
        types[_pokemonId].push(_type);
    }

    function addWeakness(uint _pokemonId, Type _type) public {
        weaknesses[_pokemonId].push(_type);
    }

    function addHability(
        uint _pokemonId,
        string memory _name,
        string memory _description
    ) public {
        habilities[_pokemonId].push(Hability(_name, _description));
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
