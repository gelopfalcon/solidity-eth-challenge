// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    event eventNewPokemon(Pokemon pokemon);

    struct Pokemon {
        uint id;
        string name;
        uint[] abilityIds;
    }

    struct Ability {
        uint id;
        string name;
        string description;
    }

    Pokemon[] private pokemons;
    Ability[] private abilities;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon(
        string memory _name, 
        uint _id, 
        uint[] memory _abilityIds
    ) public {
        require(_id > 0, "id must be greater than 0.");
        require(bytes(_name).length > 2, "name must be greater than 2 characters length.");
        require(!isEmpty(_name), "name must not be empty.");
        require(_abilityIds.length >= 1, "one or more abilityIds are required.");
        require(areValidAbilityIds(_abilityIds), "one or more abilityIds doesn't exist.");

        Pokemon memory pokemon = Pokemon(_id, _name, _abilityIds);
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

    function getResult() public pure returns(uint product, uint sum){
        uint a = 1; 
        uint b = 2;
        product = a * b;
        sum = a + b; 
    }

}
