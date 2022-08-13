// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    struct Ability {
      string name;
      string descripcion;
    }

    struct Pokemon {
      uint id;  
      string name;
      Ability[] abilities;
      uint[] types;
      uint[] weak;
    }

    Pokemon[] private pokemons;
    string[] private types;

    event eventNewPokemon(
      Pokemon newPokemon
    );

    constructor(){
      loadTypes();
    }

    function loadTypes() private {
      types.push("Normal"); // 0
      types.push("Fire"); // 1
      types.push("Water"); // 2
      types.push("Grass"); // 3
      types.push("Flying"); // 4
      types.push("Fighting"); // 5
      types.push("Poison"); // 6
      types.push("Electric"); // 7
      types.push("Ground"); // 8
      types.push("Rock"); // 9
      types.push("Psychic"); // 10
      types.push("Ice"); // 11
      types.push("Bug"); // 12
      types.push("Ghost"); // 13
      types.push("Steel"); // 14
      types.push("Dragon"); // 15
      types.push("Dark"); // 16
      types.push("Fairy"); // 17
    }

     function createPokemon (
       string memory _name,
       uint _id,
       Ability[] memory _habilidadades,
       uint[] memory _types,
       uint[] memory _weak
      ) public {
        require(_id > 0, 'Shuold provide a correct id');
        require(bytes(_name).length > 2, 'Should provide a correct name bigger two characters');

        pokemons.push();
        uint indice = pokemons.length -1;
        pokemons[indice].id = _id;
        pokemons[indice].name = _name;

        for(uint i = 0; i < _habilidadades.length; i++){
          pokemons[indice].abilities.push(_habilidadades[i]);
        }

        for(uint i = 0; i < _types.length; i++){
          pokemons[indice].types.push(_types[i]);
        }

        for(uint i = 0; i < _weak.length; i++){
          pokemons[indice].weak.push(_weak[i]);
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemons[indice]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getAllTypes() public view returns (string[] memory) {
      return types;
    }
}
