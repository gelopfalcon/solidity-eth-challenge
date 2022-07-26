// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
        uint256[] abilities;
        uint256[] types;
        uint256[] weaknesses;
    }

    struct Ability {
        uint256 id;
        string name;
        string description;
    }

    struct Type {
        uint256 id;
        string name;
        string description;
    }

    event eventNewPokemon(
        address author,
        uint256 id,
        string nameNewPokemon,
        uint256[] _abilities,
        uint256[] _types,
        uint256[] _weaknesses
    );

    Pokemon[] private pokemons;
    Ability[] private abilities;
    Type[] private types;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    mapping(uint256 => address) public abilityToOwner;
    mapping(address => uint256) ownerAbilityCount;

    mapping(uint256 => address) public typeToOwner;
    mapping(address => uint256) ownerTypeCount;

    function createAbility(
        uint256 _id,
        string memory _name,
        string memory _description
    ) public {
        require(_id > 0, "Pokemon ability id shoulbe greater than zero (0).");
        require(
            bytes(_name).length > 2,
            "Pokemon ability name must be more than 2 characters."
        );
        abilities.push(Ability(_id, _name, _description));
        abilityToOwner[_id] = msg.sender;
        ownerAbilityCount[msg.sender]++;
    }

    function createType(
        uint256 _id,
        string memory _name,
        string memory _description
    ) public {
        require(_id > 0, "Pokemon type id shoulbe greater than zero (0).");
        require(
            bytes(_name).length > 2,
            "Pokemon type name must be more than 2 characters."
        );
        types.push(Type(_id, _name, _description));
        typeToOwner[_id] = msg.sender;
        ownerTypeCount[msg.sender]++;
    }

    function createPokemon(
        uint256 _id,
        string memory _name,
        uint256[] memory _abilities,
        uint256[] memory _types,
        uint256[] memory _weaknesses
    ) public {
        require(_id > 0, "Pokemon id shoulbe greater than zero (0).");
        require(
            bytes(_name).length > 2,
            "Pokemon name must be more than 2 characters."
        );
        require(
            _abilities.length > 0,
            "Pokemon must have 1 or more Abilities."
        );
        require(_types.length > 0, "Pokemon must have 1 or more Types.");
        require(
            _weaknesses.length > 0,
            "Pokemon must have 1 or more Weaknesses."
        );

        Pokemon storage newPokemon = pokemons.push();
        newPokemon.id = _id;
        newPokemon.name = _name;

        newPokemon.abilities = _abilities;
        newPokemon.types = _types;
        newPokemon.weaknesses = _weaknesses;

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(
            msg.sender,
            _id,
            _name,
            _abilities,
            _types,
            _weaknesses
        );
    }

    function getAbilityById(uint256 _id) public view returns (Ability memory) {
        Ability memory returnedAbility;
        for (uint256 i = 0; i < abilities.length; i++) {
            if (abilities[i].id == _id) {
                returnedAbility = abilities[i];
            }
        }
        return returnedAbility;
    }

    function getTypeById(uint256 _id) public view returns (Type memory) {
        Type memory returnedType;
        for (uint256 i = 0; i < types.length; i++) {
            if (types[i].id == _id) {
                returnedType = types[i];
            }
        }
        return returnedType;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getAllAbilities() public view returns (Ability[] memory) {
        return abilities;
    }

    function getAllTypes() public view returns (Type[] memory) {
        return types;
    }

    function getResult() public pure returns (uint256 product, uint256 sum) {
        uint256 a = 1;
        uint256 b = 2;
        product = a * b;
        sum = a + b;
    }
}
