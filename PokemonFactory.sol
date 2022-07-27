// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
        Skill[] skills;
        Aweakness[] aweakness;
    }

    struct Skill {
        string name;
        string description;
    }

    struct Aweakness {
        WeaknessStatus weaknesName;
    }

    enum WeaknessStatus {
        Fire,
        Psychic,
        Flying,
        Ice
    }

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    // logic for pokemons
    mapping(uint256 => uint256) public pokemonIndexed;

    event eventNewPokemon(Pokemon _pokemonCreated);

    // event eventAllPokemons(Pokemon[] _pokemonCreated);

    function createPokemon(
        string memory _name,
        uint256 _id,
        string memory _skillName,
        string memory _skillDescription,
        WeaknessStatus _weaknessStatus
    ) public NameMinimunTwoCharacters(_name) IsGreaterThanZero(_id) {
        pokemons.push();
        uint256 lastIndex = pokemons.length - 1;
        pokemons[lastIndex].id = _id;
        pokemons[lastIndex].name = _name;
        addSkill(_id, _skillName, _skillDescription);
        // pokemons[lastIndex].skills.push(Skill(_skillName, _skillDescription));
        addAweakness(_id, _weaknessStatus);
        // pokemons[lastIndex].aweakness.push(Aweakness(_weaknessStatus));
        pokemonIndexed[_id] = lastIndex;

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(pokemons[lastIndex]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    modifier IsGreaterThanZero(uint256 _id) {
        require(_id > 0, "_id field should be greater than zero");
        _;
    }

    modifier NameMinimunTwoCharacters(string memory _name) {
        // this rule include bytes(_name).length > 0 that enssures "_name field should not be empty"
        require(
            bytes(_name).length >= 2,
            "_name field should be have at least 2 characteres"
        );
        _;
    }

    function addSkill(
        uint256 _pokemonId,
        string memory _skillName,
        string memory _skillDescription
    ) public IsGreaterThanZero(_pokemonId) {
        // Solución al buscar directamente en un mapping
        pokemons[pokemonIndexed[_pokemonId]].skills.push(
            Skill(_skillName, _skillDescription)
        );

        // emit eventAllPokemons(pokemons);
        // Solución al recorrer un for
        // for (uint256 counter = 0; counter < pokemons.length; counter++) {
        //     if (pokemons[counter].id == _pokemonId) {
        //         pokemons[pokemonIndexed[_pokemonId]].skills.push(
        //             Skill(_skillName, _skillDescription)
        //         );

        //         emit eventAllPokemons(pokemons);
        //     }
        // }
    }

    function addAweakness(uint256 _pokemonId, WeaknessStatus _weaknessStatus)
        public
        IsGreaterThanZero(_pokemonId)
    {
        // Solución al buscar directamente en un mapping
        pokemons[pokemonIndexed[_pokemonId]].aweakness.push(
            Aweakness(_weaknessStatus)
        );
    }
}
