// SPDX-License-Identifier: GPL-3.0

// _name ex: Venomoth
// _id ex: 49
// _abilities ex: [["Shield dust", "This Pokémons dust blocks the additional effects of attacks taken"], ["Tinted Lens", "The Pokémon can use not very effective moves to deal regular damage."]]
// _types ex: [12, 6]
// _weakness ex: [1, 10, 4, 9]

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  struct Ability {
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    Ability[] abilities;
    string[] types;
    string[] weak;
  }

  event eventNewPokemon(
    Pokemon pokemon
  );

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;

  function returnTypeName(uint8 id) private pure returns(string memory name){
    require(id >= 0 && id <=17, "This id for type does not exist, try again. Normal -> 0, Fire -> 1, Water -> 2, Grass -> 3, Flying -> 4, Fighting -> 5, Poison -> 6, Electric -> 7, Ground -> 8, Rock -> 9, Psychic -> 10, Ice -> 11, Bug -> 12, Ghost -> 13, Steel -> 14, Dragon -> 15, Dark -> 16, Fairy -> 17");
    if (id == 0){
      return "Normal";
    } else if (id == 1){
      return "Fire";
    } else if (id == 2){
      return "Water";
    } else if (id == 3){
      return "Grass";
    } else if (id == 4){
      return "Flying";
    } else if (id == 5){
      return "Fighting";
    } else if (id == 6){
      return "Poison";
    } else if (id == 7){
      return "Electric";
    } else if (id == 8){
      return "Ground";
    } else if (id == 9){
      return "Rock";
    } else if (id == 10){
      return "Psychic";
    } else if (id == 11){
      return "Ice";
    } else if (id == 12){
      return "Bug";
    } else if (id == 13){
      return "Ghost";
    } else if (id == 14){
      return "Steel";
    } else if (id == 15){
      return "Dragon";
    } else if (id == 16){
      return "Dark";
    } else if (id == 17){
      return "Fairy";
    }
  }

  function createPokemon (
      string memory _name, 
      uint _id, 
      Ability[] memory _abilities,
      uint8[] memory _types,
      uint8[] memory _weakness
    ) public {
    // Check if the id is greater than 0
    require(_id > 0, "The id must be greater than 0");

    // Check if the name is larger than 2 characters
    require(bytes(_name).length > 2, "The name must exist and be greater than 2 characters");

    // Creating the new pokemon
    pokemons.push();
    uint index = pokemons.length - 1;
    pokemons[index].id = _id;
    pokemons[index].name = _name;
    uint i;
    for (i = 0; i < _abilities.length; i++){
      pokemons[index].abilities.push(_abilities[i]);
    }
    for (i = 0; i < _types.length; i++){
      pokemons[index].types.push(returnTypeName(_types[i]));
    }
    for (i = 0; i < _weakness.length; i++){
      pokemons[index].weak.push(returnTypeName(_weakness[i]));
    }
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;

    // Emit the event of creating the pokemon
    emit eventNewPokemon(pokemons[index]);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }
}