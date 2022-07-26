// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory
{

////////////////////////// Start structs //////////////////////////////////////////////
  struct Ability
  {
    string name;
    string description;
  }
  struct Pokemon
  {
    uint id;
    string name;
    uint32 kinds;
    uint32 weakness;
    Ability[] ability2;
  }
////////////////////////// End   structs //////////////////////////////////////////////

////////////////////////////// Start States ////////////////////////////////////////////
  Pokemon[] private pokemons;
  mapping (uint => address) private pokemonToOwner;
  mapping (address => uint) private ownerPokemonCount;
    mapping (uint32 => uint32) private weaknesses; // kind->weaknesses
  mapping(uint32 => string) private kinds;
////////////////////////////// End States ///////////////////////////////////////////




///////////////////////////// Start Functions //////////////////////////////////////////
    /**
     * @dev Constructor that doesn't receive any parameter. It only maps in order to encode the different kinds of
   * pokemons we have and also determines the weaknesess of the pokemons using the same encoded. Only 18 bits were
   * used so we were able to encoded it in a uint32.
   * The 2 tables over here were taken from: https://as.com/meristation/2020/01/03/guia_pagina/1578049079_327940.html
     */
  constructor()
  {
    // by doing a simple or we can have all the kinds possible
    kinds[0x00000] = "";
        kinds[0x00001] = "Normal";
        kinds[0x00002] = "Fire";
    kinds[0x00004] = "Water";
    kinds[0x00008] = "Grass";
    kinds[0x00010] = "Flying";
    kinds[0x00020] = "Fighting";
    kinds[0x00040] = "Poison";
    kinds[0x00080] = "Electric";
    kinds[0x00100] = "Ground";
    kinds[0x00200] = "Rock";
    kinds[0x00400] = "Psychic";
    kinds[0x00800] = "ICE";
    kinds[0x01000] = "Bug";
    kinds[0x02000] = "Ghost";
    kinds[0x04000] = "Steel";
    kinds[0x08000] = "Dragon";
    kinds[0x10000] = "Dark";
    kinds[0x20000] = "Fairy";

    // this is the table of weaknesses for a specific kind of pokemon but we can get all the pokemon weaknesess
    // when the pokemon is a mixture just by doing an or with mappings.
        weaknesses[0x00001] = 0x00020;
        weaknesses[0x00002] = 0x00004|0x00100|0x00200;
    weaknesses[0x00004] = 0x00080|0x00008;
    weaknesses[0x00008] = 0x01000|0x00010|0x00040|0x00800|0x00002;
    weaknesses[0x00080] = 0x00100;
    weaknesses[0x00800] = 0x04000|0x00200|0x00020|0x00002;
    weaknesses[0x00020] = 0x20000|0x00010|0x00400;
    weaknesses[0x00040] = 0x00400|0x00100;
    weaknesses[0x00100] = 0x00004|0x00008|0x00800;
    weaknesses[0x00010] = 0x00200|0x00080|0x00800;
    weaknesses[0x00400] = 0x01000|0x02000|0x10000;
    weaknesses[0x01000] = 0x00010|0x00200|0x00002;
    weaknesses[0x00200] = 0x04000|0x00004|0x00020|0x00008|0x00100;
    weaknesses[0x02000] = 0x10000|0x02000;
    weaknesses[0x08000] = 0x08000|0x20000|0x00800;
    weaknesses[0x10000] = 0x20000|0x00020|0x01000;
    weaknesses[0x04000] = 0x00002|0x00020|0x00100;
    weaknesses[0x20000] = 0x00040|0x04000;
  }

    /**
     * @dev Adds a new pokemon to the collection in global variable pokemons.
     *
     * @param _id uint256 Identificaction of the pokemon we want to add. We don't have a check to avoid repetitions.
     * @param _name string name of the pokemon we want to add.
     * @param _kinds uint32[] type of the pokemon we want to add. it's an array as we can have one pokemon of many kinds.
     * @param _abilityName string[] name of the ability for the pokemon we want to add. it's an array to allow many abilities.
     * @param _abilityDesc string[] description of the previous pokemon's ability. It should be in the same order as the _abilityName above.
     */
  function createPokemon (uint256 _id, string memory _name, uint32[] memory _kinds, string[] memory _abilityName, string[] memory _abilityDesc) public
  {
    require(_id>0,"Your Pokemon ID should be greater than 0");
    require(strlen(_name)>2, "Your pokemon name should be more than 2 characters");
        Pokemon storage paux = pokemons.push();
        paux.id=_id;                    // ID repetition problem
        paux.name=_name;
        uint8 i;

        for(i=0;i<_kinds.length;i++)
    {
      paux.kinds=paux.kinds|_kinds[i];
      paux.weakness=paux.weakness|weaknesses[_kinds[i]];
    }

        for(i=0;i<_abilityName.length;i++)
    {
      Ability storage abaux= paux.ability2.push();
      abaux.name=_abilityName[i];           // Not checking if an ability was already added
      abaux.description=_abilityDesc[i];
    }
            
    pokemonToOwner[_id] = msg.sender;
    ownerPokemonCount[msg.sender]++;          // Overflow problem


    emit eventNewPokemon(msg.sender,paux);
  }


    /**
     * @dev Returns all the pokemons we added
   *
     * @return _kind string[19] kind of pokemon encoded in a human readable way. it is a fix vector to avoid gas fee.
     */
  function getAllPokemons() public view returns (Pokemon[] memory)
  {
    return pokemons;
  }

    /**
     * @dev Returns in an array of strings the kind of the pokemon encoded in the program in an uint32.
     *
     * @param _code uint32 where the kind of pokemon is encoded.
     * @return _kind string[19] kind of pokemon encoded in a human readable way. it is a fix vector to avoid gas fee.
     */
  function getKindWithCode(uint32 _code) public view returns (string[19] memory _kind)
  {
    _kind[0]=kinds[uint32(_code&(1<<0))];
    _kind[1]=kinds[uint32(_code&(1<<1))];
    _kind[2]=kinds[uint32(_code&(1<<2))];
    _kind[3]=kinds[uint32(_code&(1<<3))];
    _kind[4]=kinds[uint32(_code&(1<<4))];
    _kind[5]=kinds[uint32(_code&(1<<5))];
    _kind[6]=kinds[uint32(_code&(1<<6))];
    _kind[7]=kinds[uint32(_code&(1<<7))];
    _kind[8]=kinds[uint32(_code&(1<<8))];
    _kind[9]=kinds[uint32(_code&(1<<9))];
    _kind[10]=kinds[uint32(_code&(1<<10))];
    _kind[11]=kinds[uint32(_code&(1<<11))];
    _kind[12]=kinds[uint32(_code&(1<<12))];
    _kind[13]=kinds[uint32(_code&(1<<13))];
    _kind[14]=kinds[uint32(_code&(1<<14))];
    _kind[15]=kinds[uint32(_code&(1<<15))];
    _kind[16]=kinds[uint32(_code&(1<<16))];
    _kind[17]=kinds[uint32(_code&(1<<17))];
    _kind[18]=kinds[uint32(_code&(1<<18))];
  }

///////////////////////////// End Functions //////////////////////////////////////////



///////////////////////////// Start External Methhods //////////////////////////////////////////

// Source:
// https://github.com/ensdomains/ens-contracts/blob/master/contracts/ethregistrar/StringUtils.sol
    /**
     * @dev Returns the length of a given string. (It also works for special characters)
     *
     * @param s The string to measure the length of
     * @return The length of the input string
     */
    function strlen(string memory s) internal pure returns (uint256) 
  {
        uint256 len;
        uint256 i = 0;
        uint256 bytelength = bytes(s).length;
        for (len = 0; i < bytelength; len++) {
            bytes1 b = bytes(s)[i];
            if (b < 0x80) {
                i += 1;
            } else if (b < 0xE0) {
                i += 2;
            } else if (b < 0xF0) {
                i += 3;
            } else if (b < 0xF8) {
                i += 4;
            } else if (b < 0xFC) {
                i += 5;
            } else {
                i += 6;
            }
        }
        return len;
    }

///////////////////////////// End External Methhods //////////////////////////////////////////


///////////////////////////// Start Events //////////////////////////////////////////
    /**
     * @dev Returns Log with the wallet that minted it and the pokemon
     *
     * @param _from Wallet that minted the pokemon
   * @param _pokemonCreated The pokemon that was created
     * @return The log
     */
  event eventNewPokemon(address indexed _from, Pokemon _pokemonCreated);

///////////////////////////// End Events //////////////////////////////////////////
}