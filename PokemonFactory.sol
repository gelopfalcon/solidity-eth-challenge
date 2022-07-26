// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    enum PokemonType {
        Normal,
        Fighting,
        Flying,
        Poison,
        Ground,
        Rock,
        Bug,
        Ghost,
        Steel,
        Fire,
        Water,
        Grass,
        Electric,
        Psychic,
        Ice,
        Dragon,
        Dark,
        Fairy,
        Last
    }

    struct Ability {
        string name;
        string description;
    }

    struct Pokemon {
        uint8 id;
        string name;
        Ability[] abilities;
        PokemonType[] types;
        PokemonType[] weaknes;
    }

    Pokemon[] private pokemons;

    mapping(uint8 => address) public pokemonToOwner;
    mapping(address => uint8) ownerPokemonCount;
    mapping(uint8 => uint) idToIndex;
    event createPokemonEvent(uint8 id, string name);

    modifier pokemonDontExist(uint8 id) {
        require(idToIndex[id] > 0, "This id doesnt exist");
        _;
    }
    modifier typeDontExist(PokemonType Type) {
        require(Type < PokemonType.Last, "This type doesnt exist");
        _;
    }
    modifier abilityNameTooShort(string memory name) {
        require(
            bytes(name).length > 2,
            "Ability name must have at least 3 characters"
        );
        _;
    }
    modifier abilityDescriptionTooShort(string memory desc) {
        require(
            bytes(desc).length > 2,
            "Ability description must have at least 5 characters"
        );
        _;
    }

    function createPokemon(string memory name, uint8 id) public {
        require(bytes(name).length > 2, "Name must have at least 3 characters");
        require(id > 0, "Id must bre greather than 0");
        pokemons.push();
        uint idx = pokemons.length - 1;
        pokemons[idx].id = id;
        pokemons[idx].name = name;
        pokemonToOwner[id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        idToIndex[id] = idx + 1;
        emit createPokemonEvent(id, name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function addAbility(
        string memory abilityName,
        string memory abilityDesc,
        uint8 id
    )
        public
        pokemonDontExist(id)
        abilityDescriptionTooShort(abilityName)
        abilityNameTooShort(abilityName)
    {
        uint idx = idToIndex[id];
        pokemons[idx - 1].abilities.push(Ability(abilityName, abilityDesc));
    }

    function addType(PokemonType Type, uint8 id)
        public
        pokemonDontExist(id)
        typeDontExist(Type)
    {
        uint idx = idToIndex[id];
        pokemons[idx - 1].types.push(Type);
    }

    function addWeaknes(PokemonType weaknesType, uint8 id)
        public
        pokemonDontExist(id)
        typeDontExist(weaknesType)
    {
        uint idx = idToIndex[id];
        pokemons[idx - 1].weaknes.push(weaknesType);
    }

    function getResult() public pure returns (uint product, uint sum) {
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    }
}
