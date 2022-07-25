## [x] Reto #1
Investigar que son los Events en Solidity. Luego, debes implementar un evento que se llame eventNewPokemon, el cual se disparará cada vez que un nuevo Pokemon es creado.  Lo que emitirá el evento será el Pokemon que se creó. 

## [x] Reto #2

- Investigar sobre “”require” .
- Entonces, antes de agregar un nuevo Pokemon,  se debe validar que el id sea mayor a 0. De lo contrario, se debe desplegar un mensaje que corrija al usuario.
- Entonces, antes de agregar un nuevo Pokemon,  se debe validar que el name no sea vació y mayor a 2 caracteres. De lo contrario, se debe desplegar un mensaje que corrija al usuario.

## [x]  Reto #3
Los Pokemons han evolucionado, ahora tienen una lista de habilidades (Habilities). Es decir, un Pokemon puede tener 1 ó muchas habilidades, cada habilidad tiene el siguiente formato:
- Name
- Description 

## [x]  Reto #4 - Estudiante distinguido
Los Pokemons  pueden pertenecer a más de un tipo (Type), por ejemplo: Bulbasaur es de tipo Grass y Poison. Proponga una solución e impleméntela. 

Los Pokemons  tienen debilidades (Weaknesses) las cuales pueden ser otros tipos de pokemones. Por ejemplo,  Bulbasaur es débil contra pokemones de tipo Fire, Flying, Ice, Psychic. Proponga una solución e impleméntela.

## Explicación Solucion Propuesta

Se crea una estructura de tipos de pokemones "pokemonTypes".
En la estructura del pokemon se agregan:
* un areglo tipo "Ability" con nombre "abilities" para almacenar las habilidades del pokémon, inicialmente se debe agregar una.
* un arreglo tipo "uint" con nombre "types" para almacenar los id's del tipo de pokémon que es.
* un arreglo tipo "uint" con nombre "weaknesses" para almacenar los id's del tipo de pokémon que son su debilidad.
* con los id podemos consultar el nombre de cada tipo de pokémon llamando al método "getPokemonType".