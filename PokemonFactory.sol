// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint id;
    string name;
    uint[] habilities;
    uint[] types;
  }

  struct Hability{
    string name;
    string description;
  }

    Pokemon[] private pokemons;
    Hability[] public habilities;
    string[] public types;


    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (address => uint) public pokemonHabilitiesCounter;
    mapping (uint => Hability) pokemonHabilities;
    mapping (uint => string) pokemonTypes;
    mapping (address => uint) public pokemonTypesCounter;
    mapping (string => string[]) public pokemonWeaknesses;   

    event eventNewPokemon(address indexed _from, uint indexed _id, Pokemon _value);
    
    modifier checkIfValidPokemon(string calldata _name, uint  _id){
          require( 
            _id > 0, 
            "El ID de un Pokemon shiny debe ser mayor a 0"
          );
          uint16 nameLength = convertToUint16(bytes(_name).length);
          require( 
            nameLength > 2 &&  nameLength < 17 , 
            "El nombre de un Pokemon debe tener mas de 2 letras y menos de 17");
          _;
    }
    
    function createPokemon (string calldata _name, uint _id, uint[] memory _habilities,uint[] memory _types) public checkIfValidPokemon(_name,_id) {
        Pokemon memory newPokemon = Pokemon(_id, _name,_habilities,_types);
        pokemons.push(newPokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender,_id,newPokemon);  
    }

    function createHability (string calldata _name, string memory _description)  public{
      Hability memory newHability = Hability(_name,_description);
      habilities.push(newHability);
      pokemonHabilities[pokemonHabilitiesCounter[msg.sender]] = newHability;
      pokemonHabilitiesCounter[msg.sender]++;
      
    }
    
    function createType (string calldata _name, string[] memory _weaknesses)  public{
      types.push(_name);
      pokemonWeaknesses[_name] =_weaknesses;
      pokemonTypes[pokemonHabilitiesCounter[msg.sender]] = _name;
      pokemonTypesCounter[msg.sender]++; 
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getAllHabilities() public view returns (Hability[] memory) {
      return habilities;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

   function convertToUint16 (uint256 _a) private pure returns (uint16) 
   {
      // Las funciones pure no leen ni modifican variables de estado y
      // no usa variables de estado 
      return uint16(_a);
   }

}
