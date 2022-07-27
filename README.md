# solidity-eth-challenge

## Pokemon Factory Smart Contract

Mediante el lenguaje Solidity, crear un contrato inteligente de Ethereum para generar Pokemones, con sus habilidades, tipos y debilidades.

### Dedicatoria

Este reto se lo dedico a mi hermano [Luis Enrique Ramirez](http://luisraa.com/) (QEPD), el [niño eterno](https://www.instagram.com/luisraa_/), quien fue alto fan de la saga, y me enseñó el término [Entrenamiento Pokemón](https://pokemon.fandom.com/es/wiki/C%C3%B3mo_entrenar_bien_a_tus_Pok%C3%A9mon). Su Pokemón favorito siempre fué Pikachu.

![Pikachu](https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png)

### Recursos

Estos recursos suministran datos para crear los Pokemones en el contrato inteligente.

- [Lista de Pokemones](https://pokemon.fandom.com/wiki/List_of_Pok%C3%A9mon)
- [Tipos de Pokemones](https://pokemon.fandom.com/wiki/Types)
- [Ejemplo de Pokemón: Pikachu](https://pokemon.fandom.com/wiki/Pikachu)
- [Habilidades de Pikachu](https://pokemon.fandom.com/wiki/Pikachu#Special_abilities)
- [Tipo y Debilidad de Pikachu](https://www.pokemon.com/us/pokedex/pikachu)
- [Imagen de ejemplo de Pokemón Pikachu](https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png)

Para los datos `tipo` (<i><b>_type</i></b>) y `debilidad` (<i><b>_weakness</i></b>) en cada Pokemón, utilizar los valores numéricos de la sigiente tabla:

      0 = Normal
      1 = Fire
      2 = Water
      3 = Grass
      4 = Electric
      5 = Ice
      6 = Fighting
      7 = Poison
      8 = Ground
      9 = Flying
     10 = Psychic
     11 = Bug
     12 = Rock
     13 = Ghost
     14 = Dark
     15 = Dragon
     16 = Steel
     17 = Fairy

### Retos

1. [Hacer el curso de Desarrollo de Smart Contracts de Platzi](https://platzi.com/cursos/smart-contracts/)
2. [Hacer fork del repositorio original](https://github.com/gelopfalcon/solidity-eth-challenge/tree/main)
3. [Analizar bien los requerimientos](https://github.com/tomkat-cr/solidity-eth-challenge/blob/main/Retos.md)
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
14. [Compilar y hacer Deploy del contrato en Remix](https://remix-ide.readthedocs.io/en/latest/create_deploy.html)
15. [Cargar el primer Pokemón en el contrato](https://github.com/tomkat-cr/solidity-eth-challenge/blob/main/README.md#cargar-el-primer-pokem%C3%B3n)
15. [Deployment en una Testnet](https://github.com/tomkat-cr/solidity-eth-challenge/blob/main/README.md#deployment-en-una-testnet)

### Cargar el primer Pokemón

- Cargar el contrato en [Remix](https://remix.ethereum.org/).
- Ir a la pestaña SOLIDITY COMPILER y hacer clic en el botón `Compile PokemonFactory.sol`.
- Ir a la pestaña DEPLOY & RUN TRANSACTIONS y hacer clic en el botón `Deploy`.
- Bajar a la sección `Deployed Contracts`, abrir el elemento `POKEMONFACTORY AT ...`.
- Buscar el elemento `createPokemon` y abrirlo.
- Especificar los siguientes datos:
    * <i><b>_name</i></b>: Pikachu
    * <i><b>_id</i></b>: 1
    * <i><b>_abilityName</i></b>: Static
    * <i><b>_abilityDescription</i></b>: Can cause paralysis in battle if hit by a physical move
    * <i><b>_type</i></b>: 4
    * <i><b>_weakness</i></b>: 8
    * <i><b>_image</i></b>: https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png
- Hacer clic en el botón `Transact`.
- En la franja inferior derecha de la pantalla, hacer clic en el botón `Debug`, abrirlo haciendo clic en \/ y verificar la información de la transacción.
- Enjoy!

### Deployment en una Testnet

- Seguir las instrucciones de la clase de Deploy [Cómo desplegar nuestro contrato en Ropsten](https://platzi.com/clases/2561-smart-contracts/43165-como-desplegar-nuestro-contrato-en-ropsten/) en el curso [Desarrollo de Smart Contracts](https://platzi.com/cursos/smart-contracts/) de Platzi.
- Básicamente se resume a:
    - Crear una Wallet en [Metamask](https://metamask.io/).
    - Crear una cuenta en alguna Testnet:
        - Debido a que en 2022 la Testnet [Ropsten](https://faucet.ropsten.be/) estaba ya cerrada, utilice la de [Paradigm](https://faucet.paradigm.xyz/): <https://faucet.paradigm.xyz>, que da ETH, WETH, DAI y algunos NFTs en 8 Testnets (Ropsten, Kovan, Rinkeby, Optimistic Kovan, Arbitrum Rinkeby, Avalanche Fuji, Görli y Polygon Mumbai).
        - También su puede utilizar la [Faucet de Metamask](https://faucet.metamask.io/): <https://faucet.metamask.io>.
    - Copiar y pegar la direccion de la Wallet de Metamask en la cuenta de la Faucet.
    - Esperar los fondos.
    - Compilar el contrato en Remix (se puede hacer presionando `Ctrl-S` u `Option-S`).
    - Conectar Remix con la Wallet. [En este blog de Paul McAviney](https://blog.paulmcaviney.ca/deploy-to-ropsten-testnet) hay unas instrucciones interesantes para realizar este paso en una red Ropsten, y [en este otro enlace](https://docs.celo.org/developer-resources/deploy-remix) para hacerlo en [Celo](https://docs.celo.org/).
    - Confirmar la conexión de Remix en la Wallet Metamask.
    - Hacer clic en el botoón `Deploy`.
    - Confirmar la operación de Despliegue en la Wallet Metamask.
    - El resto del seguimiento de las transacciones se puede hacer en Metamask.
    - Alli estarán los enlaces para ver el contrato en [Etherscan](https://ropsten.etherscan.io/address/0xe1e5a17db686a787075c39e75f4921ded5bd20a2). Al entrar en el contrato se podrá ver sus datos y la [transacción que le dió origen](https://ropsten.etherscan.io/tx/0x9b33f38cf1a27d0790f813d18777db5ef81a6b39dcecd3faedaaeb4c76e77a0e).
    - Si se desea poder ver el código fuente del contrato en [Etherscan](https://ropsten.etherscan.io/address/0xe1e5a17db686a787075c39e75f4921ded5bd20a2#code), es necesario:
        - Anotar la versión exacta que se usó en la compilación del contrato en Remix (pestaña `SOLIDITY COMPILER`, sección `COMPILER`). En mi caso fué la `0.8.7+commit.e28d00a7`.
        - Anotar la Licencia utilizada en el contrato. En mi caso fué `GPL-3.0` porque puse la línea `// SPDX-License-Identifier: GPL-3.0` al principio del archivo [PokemonFactory.sol](https://github.com/tomkat-cr/solidity-eth-challenge/blob/main/PokemonFactory.sol).
        - Ir al reguistro del contrato en [Etherscan](https://ropsten.etherscan.io/address/0xe1e5a17db686a787075c39e75f4921ded5bd20a2#code).
        - Seguir las instrucciones para confirmar el byte code.
        - Si todos los datos concuerdan (version del compilador, licencia y código fuente exacto que se usó), al cabo de un rato se podrá ver el código fuente en [Etherscan](https://ropsten.etherscan.io/address/0xe1e5a17db686a787075c39e75f4921ded5bd20a2#code). 
- La primera versión de este contrato fué desplegada en en la Rosten Testnet Network. [Lo puedes ver haciendo clic aquí](https://ropsten.etherscan.io/address/0xe1e5a17db686a787075c39e75f4921ded5bd20a2#code).

