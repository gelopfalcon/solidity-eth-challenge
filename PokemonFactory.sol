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
    struct Type {
        string name;
        mapping(string => bool) weaknesses;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => Ability[]) abilities;
    mapping(uint256 => string[]) pokemonTypes;
    mapping(string => Type) Types;
    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    event eventNewPokemon(string pokemonName, uint256 pokemonId);
    event eventNewAbility(string name, string description, uint256 pokemonId);
    event eventNewType(string pokemonType);
    event eventNewTypeInPokemon(uint256 pokemonId, string pokemonType);
    event eventNewWeakness(string pokemonType, string typeWeakness);

    function createPokemon(string memory _name, uint256 _id) public {
        require(_id > 0, "The pokemon id should be greater than 0");
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
            "Abilities names should have more that two characters."
        );

        abilities[_pokemonId].push(Ability(_abilityName, _abilityDescription));
        emit eventNewAbility(_abilityName, _abilityDescription, _pokemonId);
    }

    function addType(string memory _type) public {
        require(
            bytes(_type).length > 2,
            "Types should contain a name larger than two characters."
        );
        Type storage newType = Types[_type];
        newType.name = _type;
        emit eventNewType(_type);
    }

    function addTypeToPokemon(uint256 _pokemonId, string memory _type) public {
        pokemonTypes[_pokemonId].push(_type);
        emit eventNewTypeInPokemon(_pokemonId, _type);
    }

    function addWeakness(string memory _type, string memory _weakness) public {
        Types[_type].weaknesses[_weakness] = true;
        emit eventNewWeakness(_type, _weakness);
    }

    function isWeakness(string memory _type, string memory _weakness)
        public
        view
        returns (bool)
    {
        return Types[_type].weaknesses[_weakness];
    }

    function getPokemonTypes(uint256 _pokemonId)
        public
        view
        returns (string[] memory)
    {
        return pokemonTypes[_pokemonId];
    }
}
