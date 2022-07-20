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