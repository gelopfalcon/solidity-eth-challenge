// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
  }
  struct Hability {
    string name;
    string description;
  }
    Pokemon[] private pokemons;
    Hability[] private habilities;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (uint => Hability[]) pokemonToHabilty;
    mapping (uint => uint) pokemonHabilityCount;

    event eventNewPokemon(Pokemon _pokemon);


     function createPokemon (string memory _name, uint _id) public {
        require(_id > 0, "El id debe ser mayor a cero");
        require(bytes(_name).length > 2 , "Corregir nombre de pokemon");


        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;

        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(Pokemon(_id, _name));
    }
    function evolvePokemon(uint256 _pokemonId, string memory _name,string memory _description) public {
      require(_pokemonId > 0, "El id debe ser mayor a cero");
      require(pokemonToOwner[_pokemonId] == msg.sender,"No tienes este pokemon");
  

      habilities.push(Hability(_name, _description));
      
      pokemonToHabilty[_pokemonId].push(Hability(_name, _description));
      // pokemonToHabilty[_pokemonId]=Hability(_name, _description,_pokemonId);

      pokemonHabilityCount[_pokemonId]++;

    }
    function getHabilityById(uint256 _pokemonId) public view returns (Hability[] memory) {
      return pokemonToHabilty[_pokemonId];
    }
    
    function getAllHabilities() public view returns (Hability[] memory) {
      return habilities;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }
    function getPokemonsCount() public view returns (uint) {
      return ownerPokemonCount[msg.sender];
    }
    function getHabilitiesCount(uint256 _pokemonId) public view returns (uint) {
      return pokemonHabilityCount[_pokemonId];
    }
  //   function getResult() public pure returns(uint product, uint sum){
  //     uint a = 1; 
  //     uint b = 2;
  //     product = a * b;
  //     sum = a + b; 
  //  }

}
