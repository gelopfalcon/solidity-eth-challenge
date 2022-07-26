// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }

  struct Ability {
    string name;
    string description;
  }

  struct Type {
    uint id;
    string name;
  }

    Pokemon[] private pokemons;
    Ability[] private abilities;
    Type[] private types;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    
    mapping (uint => Pokemon) idToPokemon;
    mapping (string => Ability) nameToAbility;
    mapping (uint => Type) idToType;
    
    event eventNewPokemon(Pokemon);


     function createPokemon (uint _id, string memory _name) public {
        require(_id > 0, "Pokemon id must be bigger than cero");
        require(bytes(_name).length >= 2, "Pokemon name must have at least 2 characters");
        
        pokemons.push(Pokemon(_id, _name));
        idToPokemon[_id] = Pokemon(_id, _name);

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(Pokemon(_id, _name));
    }


    function newAbility(string memory _abilityName, string memory _abilityDescription) public {
        require(bytes(_abilityName).length >= 2, "Pokemon abilityName must have at least 2 characters");
        require(bytes(_abilityDescription).length > 5, "Pokemon abilityDescription must have at least 5 characters");
        abilities.push(Ability(_abilityName, _abilityDescription));
        nameToAbility[_abilityName] = Ability(_abilityName, _abilityDescription);
    }

    function newType(uint _typeId, string memory _typeName) public {
        require(bytes(_typeName).length >= 2, "Pokemon typeName must have at least 2 characters");
        require(_typeId > 0, "Pokemon idType must be bigger than cero");
        types.push(Type(_typeId, _typeName));
        idToType[_typeId] = Type(_typeId, _typeName);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }    
    
    function getAllAbilities() public view returns (Ability[] memory) {
      return abilities;
    }

    
    function getAllPokemonTypes() public view returns (Type[] memory) {
      return types;
    }

    
    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }
}

