// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    event eventNewPokemon(Pokemon pokemon);

    struct Type {
        uint id;
        string name;
    }

    struct Pokemon {
        uint id;
        string name;
        uint[] abilityIds;
        uint[] typeIds;
        uint[] weaknessTypeIds;
    }

    struct Ability {
        uint id;
        string name;
        string description;
    }

    Pokemon[] private pokemons;
    Ability[] private abilities;
    Type[] private types;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon(
        string memory _name, 
        uint _id, 
        uint[] memory _abilityIds,
        uint[] memory _typeIds,
        uint[] memory _weaknessTypeIds
    ) public {
        require(_id > 0, "id must be greater than 0.");

        require(bytes(_name).length > 2, "name must be greater than 2 characters length.");
        require(!isEmpty(_name), "name must not be empty.");

        require(_abilityIds.length >= 1, "one or more abilityIds are required.");
        require(areValidAbilityIds(_abilityIds), "one or more abilityIds doesn't exist.");

        require(_typeIds.length >= 1, "one or more typeIds are required.");
        require(areValidTypeIds(_typeIds), "one or more typeIds doesn't exist.");

        require(_weaknessTypeIds.length >= 1, "one or more weaknessTypeIds are required.");
        require(areValidTypeIds(_weaknessTypeIds), "one or more weaknessTypeIds doesn't exist.");

        Pokemon memory pokemon = Pokemon(_id, _name, _abilityIds, _typeIds, _weaknessTypeIds);
        pokemons.push(pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemon);
    }

    function areValidAbilityIds(uint[] memory _abilityIds) private view returns (bool) {
        for (uint i = 0; i < _abilityIds.length; i++) {
            if (!isValidAbilityId(_abilityIds[i])) {
                return false;
            }
        }
        return true;
    }

    function isValidAbilityId(uint _abilityId) private view returns (bool) {
        for (uint i = 0; i < abilities.length; i++) {
            if (abilities[i].id == _abilityId) {
                return true;
            }
        }
        return false;
    }

    function areValidTypeIds(uint[] memory _typeIds) private view returns (bool) {
        for (uint i = 0; i < _typeIds.length; i++) {
            if (!isValidTypeId(_typeIds[i])) {
                return false;
            }
        }
        return true;
    }

    function isValidTypeId(uint _typeId) private view returns (bool) {
        for (uint i = 0; i < types.length; i++) {
            if (types[i].id == _typeId) {
                return true;
            }
        }
        return false;
    }

    function isEmpty(string memory _str) private pure returns (bool) {
        bytes memory b = bytes(_str);
        for (uint i = 0; i < b.length; i++) {
            if (b[i] != 0x20) {
                return false;
            }
        }
        return true;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function createAbility(
        string memory _name, 
        string memory _description, 
        uint _id
    ) public {
        require(_id > 0, "id must be greater than 0.");
        
        require(bytes(_name).length > 2, "name must be greater than 2 characters length.");
        require(!isEmpty(_name), "name must not be empty.");
        
        require(bytes(_description).length > 2, "description must be greater than 2 characters length.");
        require(!isEmpty(_description), "description must not be empty.");
        
        Ability memory ability = Ability(_id, _name, _description);
        abilities.push(ability);
    }

    function getAllAbilities() public view returns (Ability[] memory) {
        return abilities;
    }

    function createType(
        string memory _name,
        uint _id
    ) public {
        require(_id > 0, "id must be greater than 0.");
        
        require(bytes(_name).length > 2, "name must be greater than 2 characters length.");
        require(!isEmpty(_name), "name must not be empty.");
        
        Type memory t = Type(_id, _name);
        types.push(t);
    }

    function getAllTypes() public view returns (Type[] memory) {
        return types;
    }

    function isWeaker(uint _pokemonId1, uint _pokemonId2) public view returns (bool) {
        require(_pokemonId1 != _pokemonId2, "ids must be different.");

        Pokemon memory pokemon1;
        Pokemon memory pokemon2;
        for (uint i = 0; i < pokemons.length; i++) {
            if (pokemons[i].id == _pokemonId1) {
                pokemon1 = pokemons[i];
            } else if (pokemons[i].id == _pokemonId2) {
                pokemon2 = pokemons[i];
            }
            if (pokemon1.id != 0 && pokemon2.id != 0) {
                break;
            }
        }
        if (pokemon1.id == 0 || pokemon2.id == 0) {
            return false;
        }
        
        for (uint i = 0; i < pokemon1.weaknessTypeIds.length; i++) {
            for (uint j = 0; j < pokemon2.typeIds.length; j++) {
                if (pokemon1.weaknessTypeIds[i] == pokemon2.typeIds[j]) {
                    return true;
                }
            }
        }
        return false;
    }

    function getResult() public pure returns(uint product, uint sum){
        uint a = 1; 
        uint b = 2;
        product = a * b;
        sum = a + b; 
    }

}
