// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event eventNewPokemon(uint256 _id, string _name);
    event eventNewType(uint256 _id, string _name);
    event eventNewAbility(uint256 _id, string _name);

    struct Type {
        uint256 id;
        string name;
        string description;
    }

    struct Ability {
        uint256 id;
        string name;
        string description;
    }

    struct Pokemon {
        uint256 id;
        string name;
        Ability[] abilities;
        Type[] types;
        Type[] weaknesses;
    }

    Pokemon[] private pokemons;
    Ability[] private abilities;
    Type[] private types;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;
    mapping(uint256 => Ability) public idToAbility;
    mapping(uint256 => Type) public idToTypes;

    modifier checkData(uint256 _id, string memory _name) {
        require(_id > 0, "El id debe ser mayor a cero");
        require(
            bytes(_name).length > 2,
            "El nombre debe tener longitud mayor a 2"
        );
        _;
    }

    function createPokemon(
        uint256 _id,
        string memory _name,
        uint256[] calldata _abilities,
        uint256[] calldata _types,
        uint256[] calldata _weaknesses
    ) public checkData(_id, _name) {
        pokemons.push();
        uint256 idx = pokemons.length - 1;
        pokemons[idx].id = _id;
        pokemons[idx].name = _name;
        uint256 i;
        for (i = 0; i < _abilities.length; i++) {
            pokemons[idx].abilities.push(idToAbility[_abilities[i]]);
        }
        for (i = 0; i < _types.length; i++) {
            pokemons[idx].types.push(idToTypes[_types[i]]);
        }
        for (i = 0; i < _weaknesses.length; i++) {
            pokemons[idx].weaknesses.push(idToTypes[_weaknesses[i]]);
        }
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id, _name);
    }

    function createAbility(
        uint256 _id,
        string memory _name,
        string memory _description
    ) public checkData(_id, _name) {
        abilities.push(Ability(_id, _name, _description));
        uint256 idx = abilities.length - 1;
        idToAbility[_id] = abilities[idx];
        emit eventNewAbility(_id, _name);
    }

    function createType(
        uint256 _id,
        string memory _name,
        string memory _description
    ) public checkData(_id, _name) {
        types.push(Type(_id, _name, _description));
        uint256 idx = types.length - 1;
        idToTypes[_id] = types[idx];
        emit eventNewType(_id, _name);
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
}
