// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    function createPokemon(string memory _name, uint256 _id) public {
        require(_id > 0,'El id del pokemon debe ser mayor un numero valido mayor que 0');
        require( bytes(_name).length > 2,'El nombre del pokemon debe contener al menos 3 letras');

        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    event eventNewPokemon(address indexed _from, string _name);
}
