# solidity-eth-challenge

## Pokemon Smart Contract

Mediante el lenguaje Solidity, crear un contrato inteligente de Ethereum para generar Pokemones, con sus habilidades, tipos y debilidades.

### Recursos

- [Lista de Pokemones](https://pokemon.fandom.com/wiki/List_of_Pok%C3%A9mon)
- [Tipos de Pokemones](https://pokemon.fandom.com/wiki/Types)
- [Ejemplo de Pokemón: Pikachu](https://pokemon.fandom.com/wiki/Pikachu)
- [Habilidades de Pikachu](https://pokemon.fandom.com/wiki/Pikachu#Special_abilities)
- [Tipo y Debilidad de Pikachu](https://www.pokemon.com/us/pokedex/pikachu)
- [Imagen de ejemplo de Pokemón Pikachu](https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png)

### Retos

1. [Hacer el curso de Smart Contracts](https://platzi.com/cursos/smart-contracts/)
2. [Hacer fork del repositorio original](https://github.com/gelopfalcon/solidity-eth-challenge/tree/main)
3. [Analizar bien los requerimientos](https://github.com/gelopfalcon/solidity-eth-challenge/blob/main/Retos.md)
4. [Crear estructura de habilidades](https://docs.soliditylang.org/en/v0.8.6/structure-of-a-contract.html#struct-types)
5. [Crear tipos de pokemones con `enum`](https://docs.soliditylang.org/en/v0.8.6/structure-of-a-contract.html#enum-types)
6. [Agregar habilidades, debilidades y tipo a las variables de estado Pokemon](https://docs.soliditylang.org/en/v0.8.6/structure-of-a-contract.html#state-variables)
7. [Investigar sobre `events` y agregar el event al crear los Pokemones](https://docs.soliditylang.org/en/v0.8.6/structure-of-a-contract.html#events)
8. [Investigar sobre `require` y agregar validaciones al crear los Pokemones](https://docs.soliditylang.org/en/v0.8.6/structure-of-a-contract.html#function-modifierss)
9. [Investigar cómo eliminar elementos de arrays](https://stackoverflow.com/questions/49051856/is-there-a-pop-functionality-for-solidity-arrays)
10. [Verificar si es posible hacer return de estructuras](https://ethereum.stackexchange.com/questions/7317/how-can-i-return-struct-when-function-is-called)
11. [Si no es posible hacer return de estructuras, verificar return de multiples valores](https://docs.soliditylang.org/en/v0.5.3/control-structures.html#destructuring-assignments-and-returning-multiple-values)
12. [Traer los archivos locales a Remix con el `remixd` daemon](https://remix-ide.readthedocs.io/en/latest/remixd.html)
13. [Cargar el contrato en Remix](https://remix.ethereum.org/)
14. Cargar el primer Pokemón.

### Cargar el primer Pokemón

- Cargar el contrato en [Remix](https://remix.ethereum.org/).
- Ir a la pestaña SOLIDITY COMPILER y hacer clic en el botón `Compile PokemonFactory.sol`.
- Ir a la pestaña DEPLOY & RUN TRANSACTIONS y hacer clic en el botón `Deploy`.
- Bajar a la sección `Deployed Contracts`, abrir el elemento `POKEMONFACTORY AT ...`.
- Buscar el elemento `createPokemon` y abrirlo.
- Especficar los siguientes datos:
    - _name: Pikachu
    - _id: 1
    - _abilityName: Static
    - _abilityDescription: Can cause paralysis in battle if hit by a physical move
    - _type: 4 (Electric)
    - _weakness: 8 (Ground)
    - _image: https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png
- Hacer clic en el botón `Transact`.
- En la franja inferior derecha de la pantalla, hacer clic en el botón `Debug`, abrirlo haciendo clic en \/ y verificar la información de la transacción.
- Enjoy!


### Dedicatoria

Este reto se lo dedico a mi hermano [Luis Enrique Ramirez](http://luisraa.com/) (QEPD), quien fue alto fan de la saga, y me enseñó el término [Entrenamiento Pokemón](https://pokemon.fandom.com/es/wiki/C%C3%B3mo_entrenar_bien_a_tus_Pok%C3%A9mon).
