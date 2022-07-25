# Algunos comentarios

## Type y Weakness

Se le asigno a cada pokemon un array de Types y Weaknesses, cada uno de estos es un struct diferente con nombre (podría tener id) y se crean las funciones para agregar dichas propiedades a cada pokemon por medio del indice del array pokemons en el que se encuentran.

## Events

Se crearon events para cada función y asi poder externalizar cuando haya una adición ya de datos en el storage del contrato, ya sea un pokemon, habilidades, tipos o debilidades.

## Requires

Se crearon 2 validaciones, que el id sea mayor a cero y que el nombre tenga un length mayor a 2.