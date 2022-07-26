# Solución al reto

## Autora

-   Candela Bramucci [@bramuccci]

## Reto #1

    event eventNewPokemon(string pokemonName, uint256 pokemonId);

## Reto #2

```
require(_id > 0, "The pokemon id should be greater than 0");

require(bytes(_name).length > 2, "The pokemon name should have more that two characters.");
```

## Reto #3

    struct Ability {
        string name;
        string description;
    }

    mapping(uint256 => Ability[]) abilities;

    event eventNewAbility(string name, string description, uint256 pokemonId);

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

## Reto #4

    struct Type {
        string name;
        mapping(string => bool) weaknesses;
    }

    mapping(uint256 => string[]) pokemonTypes;
    mapping(string => Type) Types;

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
