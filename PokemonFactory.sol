// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

//## Reto 1 ## DONE
/*
Investigar que son los Events en Solidity. 

Luego, debes implementar un evento que se llame eventNewPokemon, 
el cual se disparará cada vez que un nuevo Pokemon es creado. 

Lo que emitirá el evento será el Pokemon que se creó. 
 */

//## Reto 2 ## DONE
/*
Investigar sobre “”require” .

Entonces, antes de agregar un nuevo Pokemon, se debe validar que el id sea mayor a 0.
De lo contrario, se debe desplegar un mensaje que corrija al usuario.

Entonces, antes de agregar un nuevo Pokemon, se debe validar que el name no sea vació y mayor a 2 caracteres.
De lo contrario, se debe desplegar un mensaje que corrija al usuario.
 */

//## Reto 3 ## DONE
/*
Los Pokemons han evolucionado, ahora tienen una lista de habilidades (Habilities).
Es decir, un Pokemon puede tener 1 ó muchas habilidades, 
cada habilidad tiene el siguiente formato: 
- Name - Description 
 */

//## Reto 4 ## TODO
/*
Los Pokemons pueden pertenecer a más de un tipo (Type), por ejemplo: 
Bulbasaur es de tipo Grass y Poison. Proponga una solución e impleméntela.

Los Pokemons tienen debilidades (Weaknesses) las cuales pueden ser otros tipos de pokemones.
Por ejemplo, Bulbasaur es débil contra pokemones de tipo Fire, Flying, Ice, Psychic.
Proponga una solución e impleméntela.
 */

contract PokemonFactory {
    struct Pokemon {
        uint id;
        string name;
        Habilities[] habilities;
    }

    //## Reto 3 ##
    struct Habilities {
        string name;
        string description;
    }

    Pokemon[] private pokemons;

    mapping(uint => address) public pokemonToOwner;
    mapping(address => uint) ownerPokemonCount;

    //## Reto 2 ##
    modifier checkData(string memory _name, uint _id) {
        require(_id > 0, "The id must be bigger than 0");
        require(
            bytes(_name).length > 2 || bytes(_name).length == 0,
            "Name need more than 2 characters"
        );
        _;
    }

    modifier checkAbility(
        string[] memory _abil_name,
        string[] memory _abil_description
    ) {
        require(_abil_name.length > 0, "The PKMN need atleast 1 ability");
        require(
            _abil_name.length == _abil_description.length,
            "Each ability need a description"
        );
        _;
    }

    event eventNewPokemon(Pokemon pkmn);

    function createPokemon(
        string memory _name,
        uint _id,
        string[] memory _abil_name,
        string[] memory _abil_description
    ) public checkData(_name, _id) checkAbility(_abil_name, _abil_description) {
        pokemons.push();
        uint i = pokemons.length - 1;
        pokemons[i].id = _id;
        pokemons[i].name = _name;
        //## Reto 3 ##
        setPkmAbility(_abil_name, _abil_description, i);
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        //## Reto 4 ##
        //TO DO

        //## Reto 1 ##
        emit eventNewPokemon(pokemons[i]);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getResult() public pure returns (uint product, uint sum) {
        uint a = 1;
        uint b = 2;
        product = a * b;
        sum = a + b;
    }

    function setPkmAbility(
        string[] memory _name,
        string[] memory _description,
        uint _pkmIndex
    ) private {
        for (uint i = 0; i < _name.length; i++)
            pokemons[_pkmIndex].habilities.push(
                Habilities(_name[i], _description[i])
            );
    }
}
