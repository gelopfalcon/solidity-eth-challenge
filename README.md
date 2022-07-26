# PokemonFactory

Nombre: Eimer Wilfer Castro Hincapie  
correo platzi: ewcastroh10@gmail.com  
usuario platzi: ewcastroh  

[X] Reto 1  
[X] Reto 2  
[X] Reto 3  
[X] Reto 4  

Proyecto para crear Pokemones con sus tipos y habilidades.

## Algunas definiciones:

### Reto #1
Events en Solidity
Los events (Eventos) en Solidity permiten conectar lo que pasa dentro de la Blockchain con el exterior porque a tráves de un protocolo otras aplicaciones se pueden suscribir a ellos y escuchar todo lo que está pasando en el Smart Contract.
Se usan para:
- Registrar cambios que se hicieron
- Feedback (Retroalimentación)

### Reto #2
Requires en Solidity
Los require en Solidity son modificadores de funciones.
Estos permiten hacer validaciones antes de ejecutar una función, de esta forma se puede evitar comportamientos inesperados o que la función sea ejecutada por alguien que no tiene permisos de hacerlo.

## Métodos
### createAbility
Permite crear una nueva habilidad para un Pokemon.

    struct Ability {
        uint256 id;
        string name;
        string description;
    }


### createType
Permite crear un nuevo tipo para un Pokemon.

    struct Type {
        uint256 id;
        string name;
        string description;
    }


### createPokemon
Permite crear un nuevo Pokemon.

    struct Pokemon {
        uint256 id;
        string name;
        uint256[] abilities;
        uint256[] types;
        uint256[] weaknesses;
    }


### getAbilityById
Permite recuperar una habilidad por su Id.

### getTypeById
Permite recuperar un tipo por su Id.

### getAllPokemons
Permite recuperar todos los Pokemon.

### getAllAbilities
Permite recuperar todas las habilidades de Pokemon.

### getAllTypes
Permite recuperar todos los tipos de Pokemon.

### getResult
Permite recuperar un producto y una suma dados dos enteros quemados.  
`
a = 1;
b = 2;
`