// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0 <0.9.0;

contract PokemonFactory{
    struct Pokemon {
        uint id;
        string name;
        uint[] habilities;
        string[] types;
        string[] weaknesses;
    }

    struct Hability {
        string name;
        string description;
    }

    event eventNewPokemon(string _n);     

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemontCount;
    mapping (uint => Hability[]) public pokemonHabilities;
    
    function createPokemon(
        string memory _name, 
        uint _id, 
        uint[] memory _habilities,
        string[] memory _types,
        string[] memory _weaknesses
        ) public {
            
        require(_id > 0, "El ID debe ser mayor a 0.");
        require(bytes(_name).length > 2, "El nombre debe tener al menos 3 caracteres.");

        pokemons.push(Pokemon(_id, _name, _habilities, _types, _weaknesses));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemontCount[msg.sender]++;

        emit eventNewPokemon(_name);

        for (uint i = 0; i < _habilities.length; i++) {
            pokemonHabilities[_id].push(Hability("",""));
        }
    }

    function addHabilityToPokemon(uint _pokemonId, uint _habilityIndex, string memory _name, string memory _description) public {
      require(pokemonToOwner[_pokemonId] == msg.sender, "Solo el dueno del Pokemon puede agregar habilidades.");
      require(_habilityIndex < pokemonHabilities[_pokemonId].length, "El indice de habilidad es invalido.");
      
      pokemonHabilities[_pokemonId][_habilityIndex] = Hability(_name, _description);
    }

    function getPokemonTypes(uint _pokemonId) public view returns (string[] memory) {
        require(_pokemonId > 0, "El ID debe ser mayor a 0.");
        require(_pokemonId <= pokemons.length, "El Pokemon no existe.");

        return pokemons[_pokemonId - 1].types;
    }

    function getPokemonWeaknesses(uint _pokemonId) public view returns (string[] memory) {
        require(_pokemonId > 0, "El ID debe ser mayor a 0.");
        require(_pokemonId <= pokemons.length, "El Pokemon no existe.");

        return pokemons[_pokemonId - 1].weaknesses;
    }

    function getAllPokemons() public view returns (Pokemon[] memory){
        return pokemons;
    }

    function getResult() public pure returns(uint product, uint sum){
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    }
}