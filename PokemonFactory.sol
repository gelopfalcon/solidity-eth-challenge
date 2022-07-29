// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    event eventNewPokemon(Pokemon pokemon);

    struct Pokemon {
        uint id;
        string name;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    function createPokemon (string memory _name, uint _id) public {
        require(_id > 0, "id must be greater than 0.");
        require(bytes(_name).length > 2, "name must be greater than 2 characters length.");
        require(!isEmpty(_name), "name must not be empty.");
        Pokemon memory pokemon = Pokemon(_id, _name);
        pokemons.push(pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemon);
    }

    function isEmpty(string memory str) private pure returns (bool) {
        bytes memory b = bytes(str);
        for (uint i; i < b.length; i++) {
            if (b[i] != 0x20) {
                return false;
            }
        }
        return true;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }


    function getResult() public pure returns(uint product, uint sum){
        uint a = 1; 
        uint b = 2;
        product = a * b;
        sum = a + b; 
    }

}
