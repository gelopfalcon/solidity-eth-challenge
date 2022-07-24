// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Ability {
      string name;
      string description;
  }
  struct Pokemon {
    uint id;
    string name;
  }

  struct PokemonType {
      uint8 id;
      string name;
  }

    Pokemon[] private pokemons;
    Ability[] private abilities;
    PokemonType[] private pokemonTypes;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    mapping (uint => Pokemon) idToPokemon;

    mapping (string => Ability) nameToAbility;
    mapping (uint => Ability[]) pokemonIdToAbility;

    mapping (uint8 => PokemonType) idToPokemonTypes;

    mapping (uint => PokemonType[]) pokemonToTypes;

    event eventNewPokemon(Pokemon);

     function createPokemon (uint _id, string memory _name) public {
        require(_id > 0, "El id tiene que ser mayor a zero.");
        require(bytes(_name).length > 2, "El nombre  debe tener mas de 2 carateres.");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        idToPokemon[_id] = Pokemon(_id, _name);
        emit eventNewPokemon(Pokemon(_id, _name));
    }
    function createAbility (string memory _name, string memory _description) public {
        require(bytes(_name).length > 1, "El nombre de la habilidad con al menos doscarateres.");
        require(bytes(_description).length > 1, "Esfuerzo con la descripcion.");
        abilities.push(Ability(_name,_description));
        nameToAbility[_name] = Ability(_name,_description);

    }

    function createPokemonType (uint8 _id, string memory _name) public {
        require(_id > 0, "El id tiene que ser mayor a zero.");
        require(bytes(_name).length > 2, "El nombre  debe tener mas de 2 carateres.");
        pokemonTypes.push(PokemonType(_id, _name));
        idToPokemonTypes[_id] = PokemonType(_id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getAllAbilities() public view returns (Ability[] memory) {
      return abilities;
    }

    function getAbilitiesFromPokemon(uint pokemonid) public view returns (Ability[] memory) {
      return pokemonIdToAbility[pokemonid];
    }

    function getAllPokemonTypes() public view returns (PokemonType[] memory) {
      return pokemonTypes;
    }




    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

   function addAbilityToPokemon(uint _pokemonId, string memory _abiliteName) public {
      pokemonIdToAbility[idToPokemon[_pokemonId].id].push( nameToAbility[_abiliteName]);
   }

   function addTypeToPokemon(uint _pokemonId, uint8 _pokemonTypeId) public {
      pokemonToTypes[idToPokemon[_pokemonId].id].push( idToPokemonTypes[_pokemonTypeId]);
   }

   function showTypeFromPokemon(uint _pokemonId) public view returns(PokemonType[] memory) {
      return pokemonToTypes[idToPokemon[_pokemonId].id];
   }

}
