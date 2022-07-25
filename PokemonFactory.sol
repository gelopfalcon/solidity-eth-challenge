// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "./StringUtils.sol";
contract PokemonFactory {
    using StringUtils for string;
    struct Pokemon {
        uint id;
        string name;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    event eventNewPokemon (address indexed _owner, uint indexed _id, string indexed _name);

    function createPokemon (string memory _name, uint _id) public {
        require(_id > 0, "El ID debe ser mayor a 0");
        require(_name.strlen() > 2, "El nombre debe tener al menos 2 caracteres");
        pokemons.push(Pokemon(_id, _name));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(msg.sender, _id, _name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }


    function getResult() public pure returns(uint product, uint sum){
      uint a = 1;
      uint b = 2;
      product = a * b;
      sum = a + b;
   }

}
