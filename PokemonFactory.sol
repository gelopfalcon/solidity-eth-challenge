// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  string[] availableTypes = [
    "0:Bug",
    "1:Dark",
    "2:Dragon",
    "3:Electric",
    "4:Fairy",
    "5:Fighting",
    "6:Fire",
    "7:Flying",
    "8:Ghost",
    "9:Grass",
    "10:Ground",
    "11:Ice",
    "12:Normal",
    "13:Poison",
    "14:Psychic",
    "15:Rock",
    "16:Steel",
    "17:Water"
  ];

  struct Ability {
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    string[] types;
    string[] weaknesses;
  }

  Pokemon[] private pokemons;

  mapping (uint => address) public pokemonToOwner;
  mapping (address => uint) ownerPokemonCount;
  mapping (uint => uint) idToIndex;
  mapping (uint => Ability[]) idToAbilities; // id -> abilities

  event eventNewPokemon(
    Pokemon pokemon
  );

  event eventNewAbility(
    uint id,
    Ability ability
  );

  function createPokemon (
    string memory _name,
    uint _id,
    uint[] memory _typesIds,
    uint[] memory _weaknessIds
  ) public {
    require(_id > 0, "Pokemon id must be greater tahn 0");
    bytes memory byteName = bytes(_name);
    require(byteName.length > 2, "Name must have more than 2 characters");
    string[] memory _types = new string[](_typesIds.length);
    for (uint256 index = 0; index < _typesIds.length; index++) {
      require(
        _typesIds[index] >= 0 && 
        _typesIds[index] < availableTypes.length,
        "Not valid type, see seeAvaliableTypes function");
      _types[index] = availableTypes[_typesIds[index]];
    }
    string[] memory _weaknesses = new string[](_weaknessIds.length);
    for (uint256 index = 0; index < _weaknessIds.length; index++) {
      require(
        _weaknessIds[index] >= 0 && 
        _weaknessIds[index] < availableTypes.length,
        "Not valid Weakness, see seeAvaliableTypes function");
      _weaknesses[index] = availableTypes[_weaknessIds[index]];
    }
    Pokemon memory pokemon = Pokemon(_id, _name, _types, _weaknesses);
    pokemons.push(pokemon);
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    idToIndex[_id] = pokemons.length - 1;
    emit eventNewPokemon(pokemon);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }

  function getPokemon(uint _idPokemon) public view returns (
    Pokemon memory,
    Ability[] memory
  ) {
    Pokemon memory _pokemon = pokemons[idToIndex[_idPokemon]];
    Ability[] memory _abilities = idToAbilities[_idPokemon];
    return(_pokemon, _abilities);
  }

  function addPokemonAbility(uint _idPokemon, string memory _name, string memory _description) public {
    require(pokemonToOwner[_idPokemon] != 0x0000000000000000000000000000000000000000, "Pokemon doesn't exists yet");
    Ability memory _ability = Ability(_name, _description);
    idToAbilities[_idPokemon].push(_ability);
    emit eventNewAbility(_idPokemon, _ability);
  }

  function getPokemonAbilities(uint _idPokemon) public view returns (Ability[] memory) {
    return idToAbilities[_idPokemon];
  }

  function seeAvailableTypes() public view returns (string[] memory, string memory) {
    return (availableTypes, "Valid id's between 0 and 17");
  }

}
