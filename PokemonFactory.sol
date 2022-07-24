// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint id;
        string name;
        string[] habilitiesName;
        string[] pokemonTypes;
        string[] weakness;
    }

    Pokemon[] private pokemons;

    //Events:

    event eventNewPokemon(
        uint id,
        string name,
        string[] habilitiesName,
        string[] pokemonTypes,
        string[] weakness
    );

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;
    mapping(string => string) habilitiesDescription;

    //INSERT Functions:

    function createPokemon(string memory _name, uint _id) public {
        require(_id > 0, "The id should be greater than 0");
        require(
            keccak256(abi.encodePacked(_name)) !=
                keccak256(abi.encodePacked("   ")),
            "The name can not be a blank space"
        );
        require(
            bytes(_name).length > 2,
            "The name length should be greater than 2"
        );

        pokemons.push(Pokemon(_id, _name, _habilitiesName, _pokemonTypes, _weakness));

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(_id, _name, _habilitiesName, _pokemonTypes, _weakness);
    }

    function insertDescription (string memory _name, string memory _habilityDescription) public {
      habilitiesDescription[_name] = _habilityDescription;
    }

    //GET Functions:

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getHabilities(string memory _name) public view returns(string memory, string memory) {
      return(_name, habilitiesDescription[_name]);
    }

    /* function getResult() public pure returns (uint product, uint sum) {
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    } */
}
