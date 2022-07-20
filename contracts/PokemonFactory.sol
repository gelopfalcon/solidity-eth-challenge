// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
  uint _id;
  
  event eventNewPokemon(Pokemon pokemon);

  struct Pokemon {
    uint256 id;
    string name;
    Ability[] abilities;
    string[] pokemonType;
    string[] weaknesses;
  }

  struct Ability {
    string name;
    string description;
  }

  Pokemon[] public pokemons;

  mapping(uint => address) public pokemonToOwner;
  mapping(address => uint256) public ownerPokemonCount;
  mapping(address => mapping(uint => Pokemon)) ownedPokemons;

  modifier checkData
    (uint _id, string memory _name, string[] memory _abilityName, string[] memory _abilityDescription, string[] memory _type, string[] memory _weaknesses) {
      require(bytes(_name).length > 2, "The name must have at least 2 characters.");
      require((_abilityName).length == (_abilityDescription).length, "You must provide the name of each ability for each ability description.");

      for(uint i=0; i<_weaknesses.length; i++) {
        require(bytes((_weaknesses)[i]).length > 3, "The weakness name must have at least 3 characters.");
      }

      for(uint i=0; i<_type.length; i++) {
        require(bytes((_type)[i]).length > 3, "The type must have at least 3 characters.");
      }

      for(uint i=0; i<_abilityName.length; i++) {
        require(bytes((_abilityName)[_id]).length > 3, "The ability name must have at least 3 characters.");
        require(bytes((_abilityDescription)[_id]).length > 5, "The ability description must have at least 5 characters.");
      }

      _;
  }

  function createPokemon
    (string memory _name, string[] memory _abilityName, string[] memory _abilityDescription, string[] memory _type, string[] memory _weaknesses) 
    public 
    checkData(_id, _name, _abilityName, _abilityDescription, _type, _weaknesses) {
      _id = pokemons.length;

      pokemons.push();
      pokemons[_id].id = _id;
      pokemons[_id].name = _name;
      pokemons[_id].pokemonType = _type;
      pokemons[_id].weaknesses = _weaknesses;

      for(uint i=0; i<_abilityName.length; i++) {
        pokemons[_id].abilities.push(
          Ability(_abilityName[i], _abilityDescription[i])
        );
      }

      pokemonToOwner[_id] = msg.sender;
      ownerPokemonCount[msg.sender]++;
      emit eventNewPokemon(pokemons[_id]);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getOwnedPokemons() public view returns (Pokemon[] memory) {
    uint256 counter = ownerPokemonCount[msg.sender];

    Pokemon[] memory ownedPokemonsArr = new Pokemon[](counter);
    for (uint8 i = 0; i < counter; i++) {
        ownedPokemonsArr[i] = ownedPokemons[msg.sender][i + 1];
    }
    return ownedPokemonsArr;
  }
}