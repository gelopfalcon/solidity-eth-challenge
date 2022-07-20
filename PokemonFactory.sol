// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    

    struct Pokemon {
        uint id;
        string name;
        string[] abilities;
        string[] types;
    }

    Pokemon[] private pokemons;    

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (string => string[]) TypesWeaknesses; // type -> weaknes
    mapping (string => string) PokemonToAbilities; // Name -> description

    event eventNewPokemon(string _name);

    string[] types;
    string[] abilities;

    constructor() {
        TypesWeaknesses['Normal'] = ['Lucha'];
        TypesWeaknesses['Fuego'] = ['Agua', 'Tierra', 'Roca'];
        TypesWeaknesses['Agua'] = ['Planta', 'Electrico'];
        TypesWeaknesses['Planta'] = ['Fuego', 'Hielo', 'Veneno', 'Volador', 'Bicho'];
        TypesWeaknesses['Electrico'] = ['Tierra'];
        TypesWeaknesses['Hielo'] = ['Fuego', 'Lucha', 'Roca', 'Acero'];
        TypesWeaknesses['Lucha'] = ['Volador', 'Psiquico', 'Hada'];
        TypesWeaknesses['Veneno'] = ['Tierra', 'Psiquico'];
        TypesWeaknesses['Tierra'] = ['Agua', 'Planta', 'Hielo'];
        TypesWeaknesses['Volador'] = ['Electrico', 'Hielo', 'Roca'];
        TypesWeaknesses['Psiquico'] = ['Bicho', 'Fantasma', 'Siniestro'];
        TypesWeaknesses['Bicho'] = ['Volador', 'Roca', 'Fuego'];
        TypesWeaknesses['Roca'] = ['Agua', 'Planta', 'Lucha', 'Tierra', 'Acero'];
        TypesWeaknesses['Fantasma'] = ['Fantasma', 'Siniestro'];
        TypesWeaknesses['Dragon'] = ['Hielo', 'Dragon', 'Hada'];
        TypesWeaknesses['Siniestro'] = ['Lucha', 'Bicho', 'Hada'];
        TypesWeaknesses['Acero'] = ['Fuego', 'Lucha', 'Tierra'];
        TypesWeaknesses['Hada'] = ['Veneno', 'Acero'];
    }

    function createPokemon (uint _id, string memory _name, string[] memory _abilities, string[] memory _descriptions, string[] memory _types) public {
        bytes memory b = bytes(_name);
        require(_id > 0, "El ID debe de ser mayor que 0");
        require(b.length > 2, "El nombre debe tener al menos dos caracteres");                        
        require(_abilities.length != _descriptions.length, "El numero de habilidades y descripciones no es correct");
        
        for (uint8 c = 0; c < _types.length; c++) {
            require(TypesWeaknesses[_types[c]].length == 0, "Uno de los tipos de pokemon que ingresaste, no existe");
            types.push(_types[c]);
        }        
        
        for (uint8 c = 0; c <_abilities.length; c++) {
            PokemonToAbilities[_abilities[c]] = _descriptions[c];
            abilities.push(_abilities[c]);
        }
            
        pokemons.push(Pokemon(_id, _name, abilities, types));

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_name);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

    function getResult() public pure returns(uint product, uint sum){
      uint a = 1; 
      uint b = 2;
      product = a * b;
      sum = a + b; 
   }

}