// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    
    struct Ability {
        string name;
        string description;
    }

    struct Type {
        uint256 id;
        string name;
    }

    struct Pokemon {
        uint256 id;
        string name;
        string imageUri;
        Ability[] abilities;
        Type[] types;
        Type[] weaknesses;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    mapping(uint256 => string) public pokemonTypes;
    uint256 public amountOfTypes;

    event NewPokemon(Pokemon pokemon);

    constructor(string[] memory _types) {
        pokemons.push();
        amountOfTypes = _types.length;

        for (uint256 i = 0; i < _types.length; i++) {
            pokemonTypes[i] = _types[i];
        }
    }

    function createPokemon(
        uint256 _id,
        string memory _name,
        string memory _imageUri,
        string[] memory _skillNames,
        string[] memory _skillDescriptions,
        uint256[] memory _types,
        uint256[] memory _weaknesses
    ) public {
        require(_id > 0, "El id debe ser mayor a 0!");
        require(pokemonToOwner[_id] == address(0), "Ese id ya esta utilizado");
        require(bytes(_name).length >= 2, "El nombre debe ser mayor a 2 caracteres!");
        require(_skillNames.length == _skillDescriptions.length, "Se deben tener la misma cantidad de nombres y descripciones de habilidades");
        require(_types.length > 0, "Debes tener al menos un tipo");
        require(_weaknesses.length > 0, "Debes tener al menos una debilidad");

        pokemons.push();
        uint256 _newIndex = pokemons.length - 1;
        pokemons[_newIndex].id = _id;
        pokemons[_newIndex].name = _name;
        pokemons[_newIndex].imageUri = _imageUri;

        addPokemonAbilities(_newIndex, _skillNames, _skillDescriptions);
        addPokemonTypes(_newIndex, _types);
        addPokemonWeaknesses(_newIndex, _weaknesses);

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit NewPokemon(pokemons[_newIndex]);
    }

    function addPokemonAbilities(
        uint256 _newIndex,
        string[] memory _skillNames,
        string[] memory _skillDescriptions
    ) private {
        for (uint256 i = 0; i < _skillNames.length; i++) {
            pokemons[_newIndex].abilities.push(
                Ability({
                    name: _skillNames[i],
                    description: _skillDescriptions[i]
                })
            );
        }
    }

    function addPokemonTypes(uint256 _newIndex, uint256[] memory _types) private {
        for (uint256 i = 0; i < _types.length; i++) {
            require(
                _types[i] <= amountOfTypes,
                "Debes mandar un id de tipo valido"
            );
            pokemons[_newIndex].types.push(
                Type({id: i, name: pokemonTypes[_types[i]]})
            );
        }
    }

    function addPokemonWeaknesses(
        uint256 _newIndex,
        uint256[] memory _weaknesses
    ) private {
        for (uint256 i = 0; i < _weaknesses.length; i++) {
            require(
                _weaknesses[i] <= amountOfTypes,
                "Debes mandar un id de tipo valido"
            );
            pokemons[_newIndex].weaknesses.push(
                Type({id: i, name: pokemonTypes[_weaknesses[i]]})
            );
        }
    }

    function getType(uint256 _id) public view returns (string memory) {
        require(_id <= amountOfTypes, "Debes mandar un id valido");
        return pokemonTypes[_id];
    }

    function getPokemonById(uint256 _id) public view returns (Pokemon memory) {
        return pokemons[_id];
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }
}
