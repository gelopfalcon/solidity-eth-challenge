// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
        uint8 id;
        string name;
        Ability[] abilities;
        Type[] types;
        Type[] weaknesses; 
    }

    struct Ability {
        string name;
        string description;
    }

    enum Type {
      BUG,
      DARK,
      DRAGON,
      ELECTRIC,
      FAIRY,
      FIGHTING,
      FIRE,
      FLYING,
      GHOST,
      GRASS,
      GROUND,
      ICE,
      NORMAL,
      POISON,
      PSYCHIC,
      ROCK,
      STEEL,
      WATER
    }

    Pokemon[] private pokemons;

    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;

    event eventNewPokemon (Pokemon _pokemon);

    function createPokemon (uint8 _id, string memory _name, string[] memory _abilitiesNames, string[] memory _abilitiesDesc, Type[] memory _types, Type[] memory _weaknesses) public {
        require(_id > 0, "Pokemon id must be greater than 0");     
        require(pokemonToOwner[_id] == address(0), "Id already used");
        require(bytes(_name).length > 2, "Pokemon name must be longer than 2 characters");
        require(_abilitiesNames.length == _abilitiesDesc.length, "Abilities names and description should have the same size");

        pokemons.push();
        uint256 index = pokemons.length - 1;
        pokemons[index].id = _id;
        pokemons[index].name = _name;
        addAbilities(index, _abilitiesNames, _abilitiesDesc);
        
        for(uint8 i=0; i < _types.length; i++) {
            pokemons[index].types.push(_types[i]);
        }

        for(uint8 i=0; i < _weaknesses.length; i++) {
            pokemons[index].weaknesses.push(_weaknesses[i]);
        }
        
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemons[index]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function addAbilities(uint256 _index, string[] memory _abilitiesNames, string[] memory _abilitiesDesc) private {
         for(uint8 i=0; i < _abilitiesNames.length; i++) {
            pokemons[_index].abilities.push(
                Ability(_abilitiesNames[i], _abilitiesDesc[i])
            );
        }
    }

}
