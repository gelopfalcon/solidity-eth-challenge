// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Pokemon {
      uint id;
      string name;
    }

    /*
     * Reto #3
     */
    struct Hability {
      string name;
      string description;
    }

    /*
     * Reto #4
     */
    struct Type {
      string name;
      string description;
    }
    struct Weakness {
      string name;
      string descripcion;
    }

    Pokemon[] private pokemons;

    /*
     * Reto #3
     */
    Hability[] private habilities;

    /*
     * Reto #4
     */
    Type[] private types;
    Weakness[] private weaknesses;


    /*
     * Reto #1
     */
    event eventNewPokemon(Pokemon pokemon);

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    /*
     * Reto #3
     */
    mapping (uint => address) public pokemonToHability;
    mapping (address => uint) pokemonHabilityCount;


    /*
     * Reto #4
     */
    mapping (uint => Type) public pokemonToType;
    mapping (address => uint) pokemonTypeCount;
    //Weakness
    mapping (uint => Weakness) public pokemonToWeakness;
    mapping (address => uint) pokemonWeaknessCount;

    function createPokemon (string memory _name, uint _id) public {
        /*
         * Reto #2
         */
        require(_id > 0, "_id must be greater than 0"); 
        _name = deleteAllSpaces(_name);
        require(keccak256(abi.encodePacked(_name)).length > 2, "_name must be different than '' and greater than 2 characters.");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(pokemons[pokemons.length - 1]);
    }

    function createHability(string memory _name, string memory _description, uint _id) public {
        /*
         * Reto #3
         */ 
        _name = deleteAllSpaces(_name);
        require(keccak256(abi.encodePacked(_name)).length > 2, "_description must be different than '' and greater than 2 characters.");
        _description = deleteAllSpaces(_description);
        require(keccak256(abi.encodePacked(_description)).length > 2, "_description must be different than '' and greater than 2 characters.");
        habilities.push(Hability(_name, _description));
        pokemonToHability[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
    }


    function createType(string memory _name, string memory _description, uint _id) public {
        /*
         * Reto #4
         */
        require(_id > 0, "_id must be greater than 0"); 
        _name = deleteAllSpaces(_name);
        require(keccak256(abi.encodePacked(_name)).length > 2, "_name must be different than '' and greater than 2 characters.");
        types.push(Type(_name, _description));
        pokemonToType[_id] = Type(_name, _description);
        pokemonTypeCount[msg.sender]++;
    }

    function createWeakness (string memory _name, string  memory _description, uint _id) public {
        /*
         * Reto #4
         */
        require(_id > 0, "_id must be greater than 0"); 
        _name = deleteAllSpaces(_name);
        require(keccak256(abi.encodePacked(_name)).length > 2, "_name must be different than '' and greater than 2 characters.");
        weaknesses.push(Weakness(_name, _description));
        pokemonToWeakness[_id] = Weakness(_name, _description);
        pokemonWeaknessCount[msg.sender]++;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getResult() public pure returns(uint product, uint sum) {
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

    function deleteAllSpaces(string memory _text) public pure returns (string memory) {
        bytes memory inputBytes = bytes(_text);
        bytes memory output = new bytes(inputBytes.length);

        /*
         * Cast space character to byte(0x20) for compare
         */
        string memory space = " ";
        bytes memory spaceByte = bytes(space);

        uint j = 0; 

        for (uint i=0; i < inputBytes.length; i++) {
            if (inputBytes[i] != spaceByte[0]) {
                output[j] = inputBytes[i];
                j += 1;
            }
            
        }

        return string(output);    
    }


}
