// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
        Habilities[] habilities;
        string[] types;
        string[] weakness;
    }

    struct Habilities {
      string name;
      string description;
    }

    event eventNewPokemon(string _name, uint _id);

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    function createPokemon(string memory _name, uint256 _id, string[] memory _habilitiesName, string[] memory _habilitiesDescription, string[] memory _types, string[] memory _weakness) public {
        require(_id > 0, "Pokemon's id must be greater than zero '0' ");
        require(bytes(_name).length != 0 && bytes(_name).length > 2, "Pokemon's name cannot be null or must be greater than two(2) characters");
        require(_types.length > 0,"Pokemons must have at least 1 type");
        require(_weakness.length > 0,"Pokemons must have at least 1 weakness");        
        pokemons.push();
        uint _index = pokemons.length-1;
        pokemons[_index].id = _id;
        pokemons[_index].name = _name;
        for (uint256 index = 0; index < _habilitiesName.length; index++) {
          pokemons[_index].habilities.push(Habilities(_habilitiesName[index], _habilitiesDescription[index]));
        }

        for (uint256 index = 0; index < _types.length; index++) {
          pokemons[_index].types.push(_types[index]);
        }

        for (uint256 index = 0; index < _weakness.length; index++) {
          pokemons[_index].weakness.push(_weakness[index]);
        }
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name, _id);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

}
