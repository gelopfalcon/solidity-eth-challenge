// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    event createPokemonEvent(uint8 id, string name);

    struct Pokemon {
        uint8 id;
        string name;
        string skill;
    }

    Pokemon[] private pokemons;

    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;

     function createPokemon (string memory _name, uint8 _id, string memory _skill) public {
        require (_id > 0, "EL id no puede ser menor que 1");
        require (bytes(_name).length > 2, "el nombre no debe estar vacio");
        pokemons.push(Pokemon(_id, _name, _skill));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit createPokemonEvent(_id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

}