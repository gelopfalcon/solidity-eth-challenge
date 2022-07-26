// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./StringUtils.sol";
contract PokemonFactory {
    using StringUtils for string;
    struct Pokemon {
        uint id;
        string name;
        Ability[] abilities;
    }

    struct Ability {
        string abilityName;
        string abilityDescription;
    }


    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Ability[]) public pokemonToAbilities;

    event eventNewPokemon (address indexed _owner, uint indexed _id, string indexed _name, Ability[] _abilities);

    function createPokemon (string memory _name, uint _id, Ability[] memory _abilities) public {
        require(_id > 0, "El ID debe ser mayor a 0");
        require(_name.strlen() > 2, "El nombre debe tener al menos 2 caracteres");
        uint i;
        Pokemon storage pokemon = pokemons.push();
        pokemon.id = _id;
        pokemon.name = _name;
        for (i = 0; i < _abilities.length; i++) {// recorrer habilidades
            pokemon.abilities.push(_abilities[i]);
        }
        pokemonToOwner[_id] = msg.sender;
        pokemonToAbilities[_id] = pokemon.abilities;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, _id, _name, _abilities);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


}
