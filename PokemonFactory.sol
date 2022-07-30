// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Habilities {
      string Name;
      string Description;
    }

    struct Pokemon {
      uint8 id;
      string name;
      Habilities[] habilities;
      string[] types;
      string[] weakness;
    }

    Pokemon[] private pokemons;
    string[6] private pokemonTypes = ["Grass", "Poison", "Fire", "Flying", "Ice", "Psychic"];

    event eventNewPokemon(address indexed _from, uint8 _id, string _name);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     function createPokemon (
          string memory _name, 
          uint8 _id, 
          string[] memory _habilitiesName, 
          string[] memory _habilitiesDescription, 
          string[] memory pokemonType, 
          string[] memory pokemonWeakness) public {

        require(_id > 0, "Insert an id greatter than 0.");
        require(bytes(_name).length > 2, "The pokemon name must be longer than two characters.");
        require(!existPokemon(_id), "This pokemon already exists.");
        require(_habilitiesName.length == _habilitiesDescription.length, "Habilities and Description must be the same size.");
        
        
        pokemons.push();
        pokemons[pokemons.length-1].id = _id;
        pokemons[pokemons.length-1].name = _name;
        for(uint8 i = 0; _habilitiesName.length > i; i++){
          pokemons[pokemons.length-1].habilities.push(Habilities(_habilitiesName[i], _habilitiesDescription[i]));          
        }

        setPokemonAttribute(pokemons[pokemons.length-1].types, pokemonType);
        setPokemonAttribute(pokemons[pokemons.length-1].weakness, pokemonWeakness);
        

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(msg.sender, _id, _name);
    }

    function setPokemonAttribute(string[] storage _pokemonRoot, string[] memory _pokemonAttrib) private {     

      if(_pokemonAttrib.length == 0)
      {
        uint randNum = uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty, msg.sender))) % pokemonTypes.length;
        _pokemonRoot.push(pokemonTypes[randNum]);
        return;
      }

      for(uint8 i = 0; i < _pokemonAttrib.length; i++)
      {
        _pokemonRoot.push(_pokemonAttrib[i]);
      }
      
    }

    function existPokemon(uint8 _id) public view returns(bool) {
      if(pokemons.length == 0) {
        return false;
      }
        

      for(uint8 i = 0; i < pokemons.length; i++)
      {
        if(pokemons[i].id == _id){
          return true;
        }          
      }

      return false;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getAllPokemonsTypes() public view returns (string[6] memory) {       
      return pokemonTypes;
    }
    


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}
