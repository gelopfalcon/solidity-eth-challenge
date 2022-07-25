// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  
  struct Ability {
    string name;
    string description;
  }

  struct Weakness {
      Type tipo;
  }

  struct Type {
      string name;
  }
  
  struct Pokemon {
    uint256 id;
    string name;

    Ability[] abilities;
    Type[] types;
    Weakness[] weaknesses;
  }

  Pokemon[] private pokemons;

  event eventNewPokemon(uint256 id, string name);
  event abilityAdded(uint256 pokemonId, string abilityName, string abilityDescription);
  event typeAdded(uint256 pokemonId, string pokemonType);
  event weaknessAdded(uint256 pokemonId, string pokemonType);

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) public ownerPokemonCount;

  function createPokemon (string memory _name, uint256 _id) public {
      require (_id > 0, "id must be greater than 0");
      require (bytes(_name).length > 0 || bytes(_name).length > 2, "A Pokemon name must be at least 3 characters long, try again please");
      Pokemon storage pokemon = pokemons.push();
      pokemon.id= _id;
      pokemon.name = _name;  
      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(_id, _name);
  }

  function addType (uint256 index, string memory _type) public {
      pokemons[index].types.push(Type(_type));
      emit typeAdded(pokemons[index].id, _type);
  }

  function addWeakness (uint256 index, string memory _weaknessName) public {
      Type memory t = Type(_weaknessName);
    //   Weakness w = Weakness(t);
      pokemons[index].weaknesses.push(Weakness(t));
      emit weaknessAdded(pokemons[index].id, _weaknessName);
  } 

  function addAbillity (uint256 index, string memory _name, string memory _description) public {
    //   Pokemon pokemon = pokemons[index];
      pokemons[index].abilities.push(Ability(_name, _description));
      emit abilityAdded(index, _name, _description);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
  }

  function viewPokemon(uint256 index) public view returns (string memory) {
      // Solo se usara una habilidad para el ejemplo
      return string(abi.encodePacked(pokemons[index].name, " and has the following Abilities: ",  pokemons[index].abilities[0].name));
  }
}