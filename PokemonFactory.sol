// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
        uint pokemonId; 
        string pokemonName;
    }

    struct Ability {
        string abilityName; 
        string abilityDsc;
    }

    Pokemon[] public pokemons;
    mapping (uint => Ability []) public abilities;
    mapping (uint => string []) public types;
    mapping(uint => mapping(string => string)) public myWeakness;
    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    
    event PokemonCreated (
        uint pokemonId,
        string pokemonName
    );

    modifier validateData (uint _pokemonId, string memory _pokemonName) {
        require(_pokemonId > 0, "pokemonId must to be greather than zero");
        require(bytes(_pokemonName).length > 2, "pokemonName must to have at least three characters");
        _;
    }

    function createPokemon (string memory _pokemonName,uint _pokemonId) public validateData(_pokemonId, _pokemonName) {
        uint index = pokemons.length;
        pokemons.push();
        pokemons[index].pokemonId = _pokemonId;
        pokemons[index].pokemonName = _pokemonName;
         pokemonToOwner[_pokemonId] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit PokemonCreated (pokemons[index].pokemonId, pokemons[index].pokemonName);
    }

    function addAbility(string memory _abilityName, string memory _abilityDsc,uint _pokemonId) public {
        abilities[_pokemonId].push(Ability(_abilityName, _abilityDsc));  
    }

     function addType(string memory _type, uint _pokemonId) public {
        types[_pokemonId].push(_type);  
    }

     function addMyWeakness(uint _pokemonId, string memory _type, string memory _weakness) public {
        myWeakness[_pokemonId][_type] = _weakness;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

}