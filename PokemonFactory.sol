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

    event eventNewPokemon(
        Pokemon pokemon
    );

    Pokemon[] private pokemons;
    Ability[] private abilites;
    address author;

    modifier idMajor1(uint _id) {
      require(_id > 0, "You cannot add negative numbers nither zero id");
      _;
    }

    modifier validName(string memory _name) {
      require(bytes(_name).length > 2, "Name must be grather than 2 characters");
      _;
    }

    modifier isAuthor() {
        require(msg.sender == author, "You cannot add abilites because you are not the author");
        _;
    }

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Pokemon) idToPokemon;
    mapping (string => Ability) nameToAbility;
    mapping (uint => Ability[]) pokemonToAbility;

    constructor() {
      author = msg.sender;
    }

    function createPokemon (string memory _name, uint _id) public idMajor1(_id) validName(_name) {
        Pokemon memory pokemon = Pokemon(_id, _name);
        pokemons.push(pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        idToPokemon[_id] = pokemon;
        emit eventNewPokemon(pokemon);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function addAbilityToPokemon(uint _pokemonId, string memory _abiliteName) public {
      Pokemon memory pokemon = idToPokemon[_pokemonId];
      pokemonToAbility[pokemon.id].push( nameToAbility[_abiliteName]);
    }


    function createAbility(string memory _name, string memory _description) public isAuthor {
      Ability memory ability = Ability(_name, _description);
      abilites.push(ability);
      nameToAbility[_name] = ability;
    }

    function getAllAbilites() public view returns (Ability[] memory) {
      return abilites;
    }

    function getPokemonAbilities(uint _id) public view returns (Ability[] memory) {
      return pokemonToAbility[_id];
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
