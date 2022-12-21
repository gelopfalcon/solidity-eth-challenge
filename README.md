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

      0 = No Weakness
      1 = Normal
      2 = Fire
      3 = Water
      4 = Grass
      5 = Electric
      6 = Ice
      7 = Fighting
      8 = Poison
      9 = Ground
     10 = Flying
     11 = Psychic
     12 = Bug
     13 = Rock
     14 = Ghost
     15 = Dark
     16 = Dragon
     17 = Steel
     18 = Fairy

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
    * <i><b>_type</i></b>: 5
    * <i><b>_weakness</i></b>: 9
    * <i><b>_image</i></b>: https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png
- Hacer clic en el botón `Transact`.
- En la franja inferior derecha de la pantalla, hacer clic en el botón `Debug`, abrirlo haciendo clic en \/ y verificar la información de la transacción.
- Enjoy!

### Deployment en una Testnet

- Seguir las instrucciones de la clase de Deploy [Cómo desplegar nuestro contrato en Ropsten](https://platzi.com/clases/2561-smart-contracts/43165-como-desplegar-nuestro-contrato-en-ropsten/) en el curso [Desarrollo de Smart Contracts](https://platzi.com/cursos/smart-contracts/) de Platzi.
- Básicamente se resume a:
    - Crear una Wallet en [Metamask](https://metamask.io/).
    - Crear una cuenta en alguna Testnet:
        - Debido a que en agosto de 2022 la Testnet [Ropsten](https://faucet.ropsten.be/) estaba ya cerrada, utilice la de [Paradigm](https://faucet.paradigm.xyz/): <https://faucet.paradigm.xyz>, que da ETH, WETH, DAI y algunos NFTs en 8 Testnets (Ropsten, Kovan, Rinkeby, Optimistic Kovan, Arbitrum Rinkeby, Avalanche Fuji, Göerli y Polygon Mumbai).
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
    - Si se desea poder ver el código fuente del contrato en [Etherscan](https://goerli.etherscan.io/address/0xb0198833fA2778800F3cC55Bf052BaB9452152C1), es necesario:
        - Anotar la versión exacta que se usó en la compilación del contrato en Remix (pestaña `SOLIDITY COMPILER`, sección `COMPILER`). En mi caso fué la `0.8.7+commit.e28d00a7`.
        - Anotar la Licencia utilizada en el contrato. En mi caso fué `GPL-3.0` porque puse la línea `// SPDX-License-Identifier: GPL-3.0` al principio del archivo [PokemonFactory.sol](https://github.com/tomkat-cr/solidity-eth-challenge/blob/main/PokemonFactory.sol).
        - Ir al registro del contrato en [Etherscan](https://goerli.etherscan.io/address/0xb0198833fA2778800F3cC55Bf052BaB9452152C1).
        - Seguir las instrucciones para confirmar el byte code.
        - Si todos los datos concuerdan (version del compilador, licencia y código fuente exacto que se usó), al cabo de un rato se podrá ver el código fuente en [Etherscan](https://goerli.etherscan.io/address/0xb0198833fA2778800F3cC55Bf052BaB9452152C1).
    - Para ejecutar las funciones públicas del contrato, hacer clic en la pestaña `Contract` y luego clic en el botón `Write Contract`.
    - Para consultar las variables de estado públicas del contrato, hacer clic en la pestaña `Contract` y luego clic en el botón `Read Contract`.

La versión post-Merge fué desplegada en en la Goerli Testnet Network. [Lo puedes ver haciendo clic aquí](https://goerli.etherscan.io/address/0xb0198833fA2778800F3cC55Bf052BaB9452152C1).

La primera versión de este contrato fué desplegada en en la Rosten Testnet Network. [Lo puedes ver haciendo clic aquí](https://ropsten.etherscan.io/address/0xe1e5a17db686a787075c39e75f4921ded5bd20a2#code).

## Actualizacion de Diciembre 2022

Luego implementé el deploy (despliegue) con [Hardhat](https://github.com/NomicFoundation/hardhat).

Algunos comandos de Hardhat:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```

## Inicializando el proyecto con Hardhat

Para agregar Hardhat a un proyecto web3 que no lo tenga:

### Instalar dependencias e inicializar el proyecto Hardhat

```shell
npm init
npm install -D hardhat dotenv
npx hardhat
```

### Crear el archivo hardhat.config.js

En el directorio raíz del proyecto, crear el archivo hardhat.config.js:

```js
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require('dotenv').config({ path: __dirname + '/.env' });

const GOERLI_RPC_URL = process.env.GOERLI_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const ETHERSCAN_KEY = process.env.ETHERSCAN_KEY;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.17",
  defaultNetwork: "hardhat",
  networks: {
      localhost: {
          chainId: 31337,
    },
    goerli: {
        url: GOERLI_RPC_URL,
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
      chainId: 5,
    },
  },
  etherscan: {
      apiKey: ETHERSCAN_KEY,
  },
};
```

### Modificar el archivo deploy.js

En el directorio `scripts`, modificar el archivo `deploy.js` con el siguiente contenido:

```js
// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const PokemonFactory = await hre.ethers.getContractFactory("PokemonFactory");
  const pokemonFactory = await PokemonFactory.deploy();

  await pokemonFactory.deployed();

  console.log(
    `PokemonFactory deployed to ${pokemonFactory.address}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
```

## ¿Cómo ejecutar este código?

1.- Clonar o descargar el repositorio:

```bash
git clone https://github.com/tomkat-cr/solidity-eth-challenge.git
```

2.- Cambiarse al directorio:

```bash
cd solidity-eth-challenge
```

3.- Ejecutar el comando:

```bash
npm install
```

## Configuración

Para configurar los parámetros:

1.- GOERLI_RPC_URL: será necesario crear una cuenta en [Infura](https://www.infura.io), [Alchemy](https://www.alchemy.com) u otro Web3 Development Platform.

2.- PRIVATE_KEY: será necesario crear una Wallet y obtener su llave privada, por ejemplo en [Metamask](https://metamask.io)

3.- ETHERSCAN_KEY: será necesario crear una cuenta en [Etherscan](https://etherscan.io) y una API Key en [My API Keys](https://etherscan.io/myapikey)

Luego:

4.- Crear el archivo .env copiando desde el modelo con el comando:

```bash
cp .env.example .env
```

5.- Asignar los valores a los parámetros en el archivo .env:

```bash
vi .env
```

## Test

Para ejecutar las pruebas:

1.- Ejecute el nodo local:

```bash
npm run node
```

o

```bash
npx hardhat node
```

2.- Ejecutar los tests:

```bash
npm run test
```

o

```bash
npx hardhat test
```

## Deploy del contrato

1.- Para hacer el deploy en la Testnet Goerli, usar el comando:

```bash
npm run deploy
```

1.- Para hacer el deploy en la Testnet Local, usar el comando:

```bash
npm run dev:deploy
```
