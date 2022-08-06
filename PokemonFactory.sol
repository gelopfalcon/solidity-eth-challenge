// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
    uint id;
    string name;
    
 }
    event eventNewPokemon (
        string createPokemon
    );

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     function createPokemon (string memory _name, uint _id ) public {
        pokemons.push(Pokemon(_id, _name ));
        emit eventNewPokemon ("pokemon creado");
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        require (_id > 0, "El id del pokemon debe ser mayor a 0");
        require(bytes(_name).length > 2, "el nombre necesita mas de dos caracteres");
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function habilities (string memory _name1,string memory _description1, string memory _name2, string memory _description2,   string memory _name3, string memory _description3) public pure returns (string memory){
      return string(abi.encode(_name1,' ',_description1,' ',_name2,' ',_description2,' ',_name3,' ',_description3));
    } 

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}


