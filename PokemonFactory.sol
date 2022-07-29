// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint8 id;
        string name;
    }

    struct Ability {
        uint8 id;
        string name;
        string description;
    }

    struct Type {
        uint8 id;
        string name;
    }

    enum TypeFeature {
        ABILITY,
        TYPE,
        WEAKNESS
    }

    Pokemon[] private pokemons;
    Ability[] private abilities;
    Type[] private types;

    event eventNewPokemon(Pokemon pokemon);
    error FeatureNotSupportedError(TypeFeature _typeFeature);

    mapping(uint8 => address) public pokemonToOwner;
    mapping(address => uint8) ownerPokemonCount;
    mapping(uint8 => uint8[]) public pokemonAbilities;
    mapping(uint8 => uint8[]) public pokemonTypes;
    mapping(uint8 => uint8[]) public pokemonWeaknesses;

    function createPokemon(string memory _name, uint8 _id) public {
        require(_id > 0, "The id must be greater than zero");
        require(
            bytes(_name).length > 0,
            "The name cannot be empty and must have more than two characters"
        );
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemons[pokemons.length - 1]);
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

    function crateAbility(
        uint8 _id,
        string memory _name,
        string memory _description
    ) public {
        abilities.push(Ability(_id, _name, _description));
    }

    function crateType(uint8 _id, string memory _name) public {
        types.push(Type(_id, _name));
    }

    function addFeatureToPokemon(
        uint8 _idFeature,
        uint8 _idPokemon,
        TypeFeature _typeFeature
    ) public {
        if (_typeFeature == TypeFeature.ABILITY)
            pokemonAbilities[_idPokemon].push(_idFeature);
        else if (_typeFeature == TypeFeature.TYPE)
            pokemonTypes[_idPokemon].push(_idFeature);
        else if (_typeFeature == TypeFeature.WEAKNESS)
            pokemonWeaknesses[_idPokemon].push(_idFeature);
        else revert FeatureNotSupportedError(_typeFeature);
    }

    function getPokemonIdsFeature(uint8 _id, TypeFeature _typeFeature)
        public
        view
        returns (uint8[] memory)
    {
        if (_typeFeature == TypeFeature.ABILITY) return pokemonAbilities[_id];
        else if (_typeFeature == TypeFeature.TYPE) return pokemonTypes[_id];
        else if (_typeFeature == TypeFeature.WEAKNESS)
            return pokemonWeaknesses[_id];
        else revert FeatureNotSupportedError(_typeFeature);
    }

    function addAbilityToPokemon(uint8 _idAbility, uint8 _idPokemon) public {
        addFeatureToPokemon(_idAbility, _idPokemon, TypeFeature.ABILITY);
    }

    function getPokemonIdsAbilities(uint8 _id)
        public
        view
        returns (uint8[] memory)
    {
        return getPokemonIdsFeature(_id, TypeFeature.ABILITY);
    }
}
