// Reto #1
// Investigar que son los Events en Solidity. Luego, debes implementar un evento que se llame eventNewPokemon, el cual se disparará cada vez que un nuevo Pokemon es creado. Lo que emitirá el evento será el Pokemon que se creó.
// Reto #2
// Investigar sobre “”require” .
// Entonces, antes de agregar un nuevo Pokemon, se debe validar que el id sea mayor a 0. De lo contrario, se debe desplegar un mensaje que corrija al usuario.
// Entonces, antes de agregar un nuevo Pokemon, se debe validar que el name no sea vació y mayor a 2 caracteres. De lo contrario, se debe desplegar un mensaje que corrija al usuario.
// Reto #3
// Los Pokemons han evolucionado, ahora tienen una lista de habilidades (Habilities). Es decir, un Pokemon puede tener 1 ó muchas habilidades, cada habilidad tiene el siguiente formato: - Name - Description
// Reto #4 - Estudiante distinguido
// Los Pokemons pueden pertenecer a más de un tipo (Type), por ejemplo: Bulbasaur es de tipo Grass y Poison. Proponga una solución e impleméntela.
// Los Pokemons tienen debilidades (Weaknesses) las cuales pueden ser otros tipos de pokemones. Por ejemplo, Bulbasaur es débil contra pokemones de tipo Fire, Flying, Ice, Psychic. Proponga una solución e impleméntela.

// SPDX-License-Identifier: GPL-3.0

// Pokemon Types Order:
// 0 - Normal
// 1 - Fire
// 2 - Water
// 3 - Electric
// 4 - Grass
// 5 - Ice
// 6 - Fighting
// 7 - Poison
// 8 - Ground
// 9 - Flying
// 10 - Psychic
// 11 - Bug
// 12 - Rock
// 13 - Ghost
// 14 - Dragon
// 15 - Dark
// 16 - Steel
// 17 - Fairy



pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  string[19] pokemonTypes;
  uint8[][] pokemonTypesMatrix;
  struct Ability {
        string name;
        uint attackType;
        string description;
  }

  struct Pokemon {
    uint id;
    string name;
    uint[2] types;
    Ability[] attacks;
  }

  constructor() {
      pokemonTypes = ["null", "normal", "fire", "water", "electric", "grass", "ice", "fighting", "poison", "ground", "flying", "psychic", "bug", "rock", "ghost", "dragon", "dark", "steel", "fairy"];
      pokemonTypesMatrix = [
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 5, 0, 10, 10, 5, 10],
        [10, 5, 5, 10, 20, 20, 10, 10, 10, 10, 10, 20, 5, 10, 5, 10, 20, 10],
        [10, 20, 5, 10, 5, 10, 10, 10, 20, 10, 10, 10, 20, 10, 5, 10, 10, 10],
        [10, 10, 20, 5, 5, 10, 10, 10, 0, 20, 10, 10, 10, 10, 5, 10, 10, 10],
        [10, 5, 20, 10, 5, 10, 10, 5, 20, 5, 10, 5, 20, 10, 5, 10, 5, 10],
        [10, 5, 5, 10, 20, 5, 10, 10, 20, 20, 10, 10, 10, 10, 20, 10, 5, 10],
        [20, 10, 10, 10, 10, 20, 10, 5, 10, 5, 5, 5, 20, 0, 10, 20, 20, 5],
        [10, 10, 10, 10, 20, 10, 10, 5, 5, 10, 10, 10, 5, 5, 10, 10, 0, 20],
        [10, 20, 10, 20, 5, 10, 10, 20, 10, 0, 10, 5, 20, 10, 10, 10, 20, 10],
        [10, 10, 10, 5, 20, 10, 20, 10, 10, 10, 10, 20, 5, 10, 10, 10, 5, 10],
        [10, 10, 10, 10, 10, 10, 20, 20, 10, 10, 5, 10, 10, 10, 10, 0, 5, 10],
        [10, 5, 10, 10, 20, 10, 5, 5, 10, 5, 20, 10, 10, 5, 20, 5, 5, 10],
        [10, 20, 10, 10, 10, 20, 5, 10, 5, 20, 10, 20, 10, 10, 10, 10, 5, 10],
        [0, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20, 10, 10, 20, 10, 5, 10, 10],
        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 20, 10, 5, 0],
        [10, 10, 10, 10, 10, 10, 5, 10, 10, 10, 20, 10, 10, 20, 10, 5, 10, 5],
        [10, 5, 5, 5, 10, 20, 10, 10, 10, 10, 10, 10, 20, 10, 10, 10, 5, 20],
        [10, 5, 10, 10, 10, 10, 20, 5, 10, 10, 10, 10, 10, 10, 20, 20, 5, 10]
    ];
  }

    Pokemon[] private pokemons;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;

     event CreatedPokemon (uint id);
     function createPokemon (string memory _name, uint _id, uint _type1, uint _type2, string memory _basicAttackName, string memory _basicAttackDesc, uint _basicAttackType) public {
        require(_id > 0, "El id no puede ser 0 o menor a cero");
        require(_type1 >= 1 && _type1 < 19, "Necesitas ingresar un tipo de pokemon valido");
        require(_type2 >= 0 && _type2 < 19, "Necesitas ingresar un tipo de pokemon valido");
        require(_basicAttackType >= 0 && _basicAttackType < 18, "El ataque debe ser de un tipo valido");
        require(bytes(_name).length > 2, "El nombre debe tener mas de dos caracteres");
        require(bytes(_basicAttackName).length > 2, "El pokemon debe tener un ataque inicial");
        require(bytes(_basicAttackDesc).length > 2, "El pokemon debe tener un ataque inicial");

        pokemons.push();
        pokemons[pokemons.length-1].id = _id;
        pokemons[pokemons.length-1].name = _name;
        pokemons[pokemons.length-1].types = [_type1, _type2];

        pokemons[pokemons.length-1].attacks.push(
          Ability(
              _basicAttackName,
              _basicAttackType,
              _basicAttackDesc
          )
        );

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit CreatedPokemon(_id);
    }

    function getPokemon(uint index) public view returns (Pokemon memory) {
      return pokemons[index];
    }

    function addAttack (uint index, string memory _basicAttackName, string memory _basicAttackDesc, uint _basicAttackType) public {
      require(_basicAttackType >= 0 && _basicAttackType < 18, "El ataque debe ser de un tipo valido");
      require(bytes(_basicAttackName).length > 2, "El pokemon debe tener un ataque inicial");
      require(bytes(_basicAttackDesc).length > 2, "El pokemon debe tener un ataque inicial");
      require(index <= pokemons.length, "El pokemons solicitado no existe");

      pokemons[index].attacks.push(
        Ability(
          _basicAttackName,
          _basicAttackType,
          _basicAttackDesc
        )
      );
    }

    function checkWeakness(uint _attackType, uint index) public view returns (string memory) {
        require(_attackType >= 0 && _attackType < 18, "El ataque debe ser de un tipo valido");
        require(index <= pokemons.length, "El pokemons solicitado no existe");

        uint[2] memory currentTypes = pokemons[index].types;
        uint firstTypeEffect = pokemonTypesMatrix[_attackType][currentTypes[0] - 1];
        uint secondTypeEffect;
        if (currentTypes[1] != 0) {
          secondTypeEffect = pokemonTypesMatrix[_attackType][currentTypes[1] - 1];
        } else {
          secondTypeEffect = 10;
        }

        uint finalEffect = (firstTypeEffect / 2) + (secondTypeEffect / 2);
        string memory effect;

        if (firstTypeEffect != 0 && secondTypeEffect != 0 && finalEffect < 10) {
          effect = "this attack is not very effective";
        } else if (firstTypeEffect != 0 && secondTypeEffect != 0 && finalEffect > 10) {
          effect = "this attack is very effective";
        } else if (firstTypeEffect != 0 && secondTypeEffect != 0 && finalEffect == 10) {
          effect = "this attack has a normal effect to this pokemon";
        } else {
          effect = "this attack doesn't affect this pokemon";
        }

        return effect;
    }
}