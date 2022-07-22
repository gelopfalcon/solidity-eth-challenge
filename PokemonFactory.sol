// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Habilities {
        string name;
        string description;
    }

    struct Pokemon {
        uint id;
        string name;
        Habilities[] habilities;
        string[] types;
        string[] weakness;
    }

    event eventNewPokemon(string _name, uint _id);

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    
    function createPokemon (string memory _name, uint _id, string[] memory _nameHabilities, string[]  memory  _descriptionHabilities,
                            string[] memory _weakness, string[]  memory  _types) public {
        require(_id > 0,"Pokemon's id must be greater than 0");
        require(bytes(_name).length >= 1 ,"Pokemon's name can't be null");
        require(bytes(_name).length > 2,"Pokemon's name must be greater than 2 characters");
        require(_nameHabilities.length == _descriptionHabilities.length,"Descrriptions and names of habilities must be equal length");
        require(_weakness.length > 0,"Pokemons must have at least 1 weakness");
        require(_types.length > 0,"Pokemons must be at least 1 type");
        pokemons.push();
        uint _index = pokemons.length-1;
        pokemons[_index].id = _id;
        pokemons[_index].name = _name;
        fillHabilities(_index,_nameHabilities, _descriptionHabilities);
        fillWeakness(_index,_weakness);
        fillTypes(_index,_types);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name,_id);
    }

    function fillHabilities(uint _index, string[] memory _nameHabilities, string[]  memory  _descriptionHabilities) private {
            for (uint i; i < _nameHabilities.length; i++){
                pokemons[_index].habilities.push(Habilities(_nameHabilities[i],_descriptionHabilities[i]));
            }
    }

    function fillWeakness(uint _index, string[] memory _weakness) private {
            for (uint i; i < _weakness.length; i++){
                pokemons[_index].weakness.push(_weakness[i]);
            }
    }

    function fillTypes(uint _index, string[] memory _types) private {
            for (uint i; i < _types.length; i++){
                pokemons[_index].types.push(_types[i]);
            }
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

}
