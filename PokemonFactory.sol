// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/**
  * @title PokemonFactory
  * @dev Reto Solidity Smart Contract del Platzi Ethereum Developer Program, by Carlos J. Ramirez 
  * @custom:dev-run-script file_path
  */

contract PokemonFactory {

    // Enum and Structures definition

    enum PokemonTypes {
      Normal,
      Fire,
      Water,
      Grass,
      Electric,
      Ice,
      Fighting,
      Poison,
      Ground,
      Flying,
      Psychic,
      Bug,
      Rock,
      Ghost,
      Dark,
      Dragon,
      Steel,
      Fairy
    }

    struct Ability {
      string name;
      string description;
    }

    struct Pokemon {
      uint id;
      string name;
      address author;
      Ability[] abilities;
      PokemonTypes[] types;
      PokemonTypes[] weaknesses;
    }

    // Events definition
    
    event eventNewPokemon(
        Pokemon pokemon
    );

    // Status variables definition
  
    // Los datos globales se almacenan en la blockchain,
    // los datos 'privados' solo quedan en memoria mientras se ejecuta el programa.

    // Este dato es privado.
    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    // Validations definition

    modifier abilityGreaterThanZero(Ability[] _abilities) {
      require(_abilities.length > 0, "Abilities must have at least one element");
      _;
    }

    modifier idGreaterThanZero(uint _id) {
      require(_id > 0, "Id must be greater than zero");
      _;
    }

    modifier validName(string memory _name) {
      require(bytes(_name).length > 2, "Name cannot be empty and must be greater than 2 characters");
      _;
    }

    modifier isAuthor(address memory _author) {
      require(msg.sender == _author, "You cannot modify this Pokemon's data because you are not the original author");
      _;
    }

    // Functions

    // Variables globales: sin "_", las locales llevan "_" como prefijo
    function createPokemon (
        string memory _name,
        uint _id,
        Ability[] memory _abilities,
        PokemonTypes[] memory _types,
        PokemonTypes[] memory _weaknesses
      ) public
        idGreaterThanZero(_id)
        validName(_name)
        abilityGreaterThanZero(_abilities)
      {
        Pokemon memory pokemon = Pokemon(_id, _name, msg.sender, _abilities, _types, _weaknesses);
        pokemons.push(pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemon);
    }

    // La opcion 'view' es por seguridad, ya que la funcion es solo lectura,
    // solo retorna un valor, no modifica el state global de la app.
    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function createAbility(string memory _name, string memory _description) public isAuthor {
      Ability memory ability = Ability(_name, _description);
      abilites.push(ability);
      nameToAbility[_name] = ability;
    }

    function addAbilityToPokemon(uint _pokemonId, string memory _abiliteName) public {
      Pokemon memory pokemon = idToPokemon[_pokemonId];
      pokemonToAbility[pokemon.id].push(nameToAbility[_abiliteName]);
    }

    function getPokemonAbilities(uint _id) public view returns (Ability[] memory) {
      return pokemonToAbility[_id];
    }

    function getAllAbilites() public view returns (Ability[] memory) {
      return abilites;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
