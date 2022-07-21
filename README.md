<h2>Reto #1</h2>
Investigar que son los Events en Solidity. Luego, debes implementar un evento que se llame eventNewPokemon, el cual se disparará cada vez que un nuevo Pokemon es creado.  Lo que emitirá el evento será el Pokemon que se creó. 

## Eventos
Permiten conectar lo que pasa dentro de la Blockchain con el exterior. A través de un protocolo otras aplicaciones se pueden subscribir y escuchar todo lo que está pasando.

### Usos
Se usan para registrar **cambios** o dar **feedback** sobre un proceso.

```ts

contract Asset {
  string public tokenName = "CryptoProject"

  event ChangeName(
    address editor,
    string newName
  )

  function changeName(string memory newName) public {
    tokenName = newName;
    emit ChangeName(msg.sender, newName)
  }

}

```

<h2>Reto #2</h2>

- Investigar sobre _require_.
- Entonces, antes de agregar un nuevo Pokemon,  se debe validar que el id sea mayor a 0. De lo contrario, se debe desplegar un mensaje que corrija al usuario.
- Entonces, antes de agregar un nuevo Pokemon,  se debe validar que el name no sea vació y mayor a 2 caracteres. De lo contrario, se debe desplegar un mensaje que corrija al usuario.

## Require
Es una función que nos permite hacer una validación, como primer parámetro recibe la condición y como segundo un mensaje al usuario sobre el error

```ts
  require(msg.sender == owner, "Only owner can change the project");
```

Podemos usar los requires con _modifiers_ para hacer validaciones

```ts
modifer onlyOwner() {
  require(msg.sender == owner, "Only owner can change the project");
};
// La función es insertada en donde aparece este símbolo de guión bajo
_;

function changeProjectName(string memory _projectName) public onlyOwner {
  projectName = _projectName;
}
```

<h2>Reto #3</h2>
Los Pokemons han evolucionado, ahora tienen una lista de habilidades (Abilities). Es decir, un Pokemon puede tener 1 ó muchas habilidades, cada habilidad tiene el siguiente formato:
- Name
- Description 

