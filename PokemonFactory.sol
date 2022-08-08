// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Pokemon {
        uint256 id;
        string name;
    }

    struct Ability {
        string name;
        string description;
    }

    Pokemon[] private pokemons;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;
    mapping(uint256 => Ability) public pokemonAbility;

    event EventNewPokemon(string _name);

    modifier onlyOwner(uint256 _id) {
        address owner = pokemonToOwner[_id];
        require(msg.sender == owner, "You're not the owner of this pokemon.");
        _;
    }

    function createPokemon(string memory _name, uint256 _id) public {
        require(_id > 0, "Id must be greater than 0");
        require(
            bytes(_name).length > 2,
            "Name must have three characters as minimum"
        );
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit EventNewPokemon(_name);
    }

    function createAbility(
        uint256 _id,
        string memory _ability,
        string memory _description
    ) public onlyOwner(_id) {
        Ability memory ability = Ability(_ability, _description);
        pokemonAbility[_id] = ability;
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
}
