// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Skill {
        string name;
        string description;
    }
    

    struct Pokemon {
        uint id;
        string name;
        Skill[] skills;
    }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

    //Reto 1 evento que se dispara cada vez que se crea un pokemon
    event eventNewPokemon(address owner, uint id, string name);

    //Reto 2 la validación de id se omitio debido a que se modifico la función para que el id se maneje de manera interna
    function createPokemon (string memory _name, string memory _nameSkill, string memory _descriptionSkill) public {
        require(bytes(_name).length > 2, "Pokemon name must be greater than 2 characters");
        pokemons.push();
        uint index = pokemons.length -1;
        pokemons[index].id = index;
        pokemons[index].name = _name;

        addSkills(index, _nameSkill, _descriptionSkill);
        pokemonToOwner[index] = msg.sender;
        ownerPokemonCount[msg.sender]++; //msg.sender es la dirección de quien llama la función
        emit eventNewPokemon(msg.sender, index, _name);
    }

    //Reto 3 por defecto cada vez que se crea un Pokemon se agrega una habilidad pero si se necesita se pueden agregar más
    function addSkills(uint _index, string memory _nameSkill, string memory _descriptionSkill) public {
        require(_index >= 0, "Pokemon id must be greater than 0");
        require(bytes(_nameSkill).length > 2, "Pokemon skill name must be greater than 2 characters");
        require(bytes(_descriptionSkill).length > 5, "Pokemon skill description must be greater than 5 characters");
        pokemons[_index].skills.push(Skill(_nameSkill, _descriptionSkill));
    }

    function getAllPokemons() public view returns(Pokemon[] memory){
        return pokemons;
    }
}