// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Ability {
    string name;
    string description;
  }

  struct Type {
    string name;
  }

  struct Weaknesses {
    string name;
  }

  struct Pokemon {
    uint8 id;
    string name;
    Ability[] abilities;
    Type[] types;
    Weaknesses[] weaknesses;
  }

  Pokemon[] private pokemons;

  mapping (uint8 => address) public pokemonToOwner;
  mapping (address => uint8) ownerPokemonCount;
  mapping (uint8 => string) pokemonTypes;

  constructor(string[] memory _types) public{
      pokemons.push();
      //string[] _types = ["Grass","Poison","Fire","Flying","Water","Bug","Normal","Ground","Electric","Fairy","Fighting","Rock","Steel","Ice","Ghost","Dragon","Psychic"];
      // skill ["Overgrass"]
      // weaknesses ["Fire","Psychic","Flying","Ice"]


      // available pokemon types
      /*types.push(Type({id:1,name: "Grass"}));
      types.push(Type({id:2,name: "Poison"}));
      types.push(Type({id:3,name: "Fire"}));
      types.push(Type({id:4,name: "Flying"}));
      types.push(Type({id:5,name: "Water"}));
      types.push(Type({id:6,name: "Bug"}));
      types.push(Type({id:7,name: "Normal"}));
      types.push(Type({id:8,name: "Ground"}));
      types.push(Type({id:9,name: "Electric"}));
      types.push(Type({id:10,name: "Fairy"}));
      types.push(Type({id:11,name: "Fighting"}));
      types.push(Type({id:12,name: "Rock"}));
      types.push(Type({id:13,name: "Steel"}));
      types.push(Type({id:14,name: "Ice"}));
      types.push(Type({id:15,name: "Ice"}));
      types.push(Type({id:16,name: "Dragon"}));*/

      for(uint8 i = 0; i < _types.length; i++) {
        pokemonTypes[i] = _types[i];
      }

  }

  // Event creation
  event OnCreatePokemon( address indexed _user, string _name, uint8 _id, Ability[] abilities);

  function createPokemon (
      string memory _name, 
      uint8 _id, 
      string[] memory _abilityName,
      string[] memory _abilityDescription,
      uint8[] memory _iDtypes,
      string[] memory _weaknesses
    ) public {
    require(_id > 0, "Pokemon ID must have be greater than zero value.");

    //validate if msg.sender has Pokemon ID already.
    require(pokemonToOwner[_id] == address(0), "Pokemon ID already exist");

    //validate name length must be greater than 2 characters.
    require(bytes(_name).length > 2, "Pokemon NAME must have be greater than 2 characters.");

    // validate _abilityNames and _abilityDescriptions must have the same length
    require(_abilityName.length == _abilityDescription.length, "Skill names and descriptions must have the same number of items");

    //validate _iDtypes length must be greater than zero.
    require(_iDtypes.length > 0, "Id types list must have greater than zero.");

    //validate _iDtypes length must be greater than zero.
    require(_weaknesses.length > 0, "_weaknesses list must have greater than zero.");


    /*** If _abilityNames and _abilityDescriptions have the same length, _iDtypes > 0 and _weaknesses > 0
     **  we can continue and populate the Abilities Array 
    ***/
    pokemons.push();
    uint256 index = pokemons.length - 1;
    pokemons[index].id= _id;
    pokemons[index].name=_name;
    //Adding Abilities
    for(uint i = 0; i < _abilityName.length; i++){
        pokemons[index].abilities.push(Ability({name: _abilityName[i], description: _abilityDescription[i]}));
    }
    //Adding types
    for(uint i = 0; i < _iDtypes.length; i++){
        pokemons[index].types.push(Type({/*id: _iDtypes[i],*/ name: pokemonTypes[_iDtypes[i]]}));
    }

    //Adding Weaknesses
    for(uint i = 0; i < _weaknesses.length; i++){
        pokemons[index].weaknesses.push(Weaknesses({/*id: _weaknesses[i],*/ name: _weaknesses[i]}));
    }

    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;
    // Event trigged
    emit OnCreatePokemon(msg.sender, _name, _id);
  }

  function getAllPokemons() public view returns (Pokemon[] memory) {
    return pokemons;
  }


  function getResult() public pure returns(uint product, uint sum){
    uint a = 1; 
    uint b = 2;
    product = a * b;
    sum = a + b; 
  }

}
