// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    event eventNewPokemon(Pokemon _pokemonCreated);

    function createPokemon(string memory _name, uint256 _id)
        public
        NameMinimunTwoCharacters(_name)
        IsGreaterThanZero(_id)
    {
        Pokemon memory pokemonCreated = Pokemon(_id, _name);
        pokemons.push(pokemonCreated);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(pokemonCreated);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getResult() public pure returns (uint256 product, uint256 sum) {
        uint256 a = 1;
        uint256 b = 2;
        product = a * b;
        sum = a + b;
    }

    modifier IsGreaterThanZero(uint256 _id) {
        require(_id > 0, "_id field should be greater than zero");
        _;
    }

    modifier NameMinimunTwoCharacters(string memory _name) {
        // this rule include bytes(_name).length > 0 that enssures "_name field should not be empty"
        require(
            bytes(_name).length >= 2,
            "_name field should be have at least 2 characteres"
        );
        _;
    }
}
