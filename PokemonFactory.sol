// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Pokemon {
    uint8 id;
    string name;
    string[] abilities;
  }

  struct Ability {
    string name;
    string description;
  }

  event eventNewPokemon(Pokemon pokemon);
  event eventprint(string print);
  event eventprintInt8(int8 print);

    Pokemon[] public pokemons;

    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) ownerPokemonCount;
    mapping (string => string) public abilities;

     function createPokemon (string memory _name, uint8 _id) public {
        require(_id>0,'_id must be greather than 0');
        require(strLen(_name)>2,'_id must be greather than 2 characters ');
        string[] memory _mem ;
        Pokemon memory _pokemon = Pokemon(_id, _name,_mem);
        pokemons.push(_pokemon);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_pokemon);
    }

    function createAbility (string memory _nameAbility, string memory _descriptionAbility) public{
      require(bytes(_nameAbility).length>2,'_id must be greather than 2 characters');
      require(bytes(_descriptionAbility).length>5,'_id must be greather than 5 characters');
      abilities[_nameAbility] = _descriptionAbility;
    }

    function getAbility (string memory _nameAbility) public view returns (string memory){
      return abilities[_nameAbility];
    }

    function pushonPok() public {
      pokemons[0].abilities.push('volartest');
    }

    function addAbility (uint8 _id,string memory _nameAbility) public{
      string memory description = abilities[_nameAbility];
      require(bytes(description).length>5,'no hay habilidad');
      int8 _pokemonId = getPokemonIndexById(_id);
      require(_pokemonId>=0,'This _id does not exist');
      pokemons[uint8(_pokemonId)].abilities.push(_nameAbility);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getOnePokemons(uint8 _ind) public view returns (Pokemon memory) {
      return pokemons[_ind];
    }

    function getPokemonIndexById(uint8 _id) internal view returns (int8) {
      int8 index=-1;
      for(uint8 i = 0; i < pokemons.length; i++){
        if(pokemons[i].id==_id){
          index=int8(i);
        }
      }
      return index;
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

    function strLen(string memory str2len) internal pure returns(uint){
      uint i;
      uint len = 0;
      uint bytelength = bytes(str2len).length;
      for(i = 0; i < bytelength; i++) {
        bytes1 b = bytes(str2len)[i];
        if (b!=0x20)len++;
      }
      return len;
   }
}
