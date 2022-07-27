// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    // STRUCTS
    struct Ability {
        uint8 id;
        string name;
        string description;
    }

    //podiamos hacerlo con un enum fijo pero preferimos hacerlo dinamico para que se puedan agregar despues más tipos
    struct Type{
       uint8 id;
       string name;
    }

    struct Pokemon {
        uint8 id;
        string name; 
        string category;
        Ability[] abilities;  
        Type[] types;
        Type[] weaknesses;  
    }   
    
    // STATE VARS
    Pokemon[] private pokemons;
    mapping (uint8 => address) public pokemonToOwner;
    mapping (address => uint8) private ownerPokemonCount;

    Type[] private types;
    mapping (uint8 => Type) private idToType;

    Ability[] private abilities;
    mapping (uint8 => Ability) private idToAbility;

    address internal owner;

    // EVENTS
    event EventNewPokemon(
        uint8 id,
        string name,
        uint8[] abilities, 
        uint8[] types,
        uint8[] weaknesses
    );

    // MODIFIERS

    modifier onlyOwner(){
        require(msg.sender == owner, "Solamente disponible para los admin");
        _;
    }
    
    modifier validPokemon(uint8 _id, string memory _name, string memory _category, uint8[] memory _types){
        require(_id > 0, "El id del Pokemon debe ser mayor a 0");
        require(pokemonToOwner[_id] == address(0x0), "El id del Pokemon ya existe");
        require(bytes(_name).length > 2, "El nombre del Pokemon debe ser mayor a 2 caracteres");
        require(bytes(_category).length > 0, "El Pokemon debe tener una categoria");
        require(_types.length > 0, "El Pokemon debe ser de al menos un tipo");
        _;
    }

    modifier validType(uint8 _id, string memory _name){
        require(_id > 0, "El id del Tipo debe ser mayor a 0");
        require(bytes(_name).length > 0, "Debe especificar el nombre");
        require(idToType[_id].id == 0, "Ya existe un Tipo con ese id");
        _;
    }

    modifier validAbility(uint8 _id, string memory _name){
        require(_id > 0, "El id de la Habilidad debe ser mayor a 0");
        require(bytes(_name).length > 0, "Debe especificar el nombre");
        require(idToAbility[_id].id == 0, "Ya existe una Habilidad con ese id") ;   
        _;
    }

    
    constructor(){
        owner = msg.sender;
    }

    function createPokemon (uint8 _id, string memory _name, string memory _category, uint8[] memory _abilities, uint8[] memory _types, uint8[] memory _weaknesses) public validPokemon(_id, _name, _category, _types) {
        
        Pokemon storage newPokemon = pokemons.push();

        for (uint8 i = 0; i < _abilities.length; i++) {

            Ability memory pokemonAbility = idToAbility[_abilities[i]];

            //chequeamos que exista ese tipo
            require(pokemonAbility.id > 0, "La habilidad no esta definida");

            newPokemon.abilities.push(pokemonAbility);
        }

        for (uint8 i = 0; i < _types.length; i++) {
            Type memory pokemonType = idToType[_types[i]];

            //chequeamos que exista ese tipo
            require(pokemonType.id > 0, "El tipo de pokemon no esta definido");

            newPokemon.types.push(pokemonType);
        }

         for (uint8 i = 0; i < _weaknesses.length; i++) {
            Type memory pokemonType = idToType[_types[i]];

            //chequeamos que exista ese tipo
            require(pokemonType.id > 0, "El tipo de pokemon no esta definido");

            newPokemon.weaknesses.push(pokemonType);
        }

        newPokemon.name = _name;
        newPokemon.category = _category;

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit EventNewPokemon(_id, _name, _abilities, _types, _weaknesses);
    }

    function addType(uint8 _id, string memory _name) public onlyOwner validType(_id, _name){     

        Type memory newType = Type(_id, _name);
        types.push(newType);
        idToType[_id] = newType;
    }

    function addAbility(uint8 _id, string memory _name, string memory _description) public onlyOwner validAbility(_id, _name){   

        Ability memory newAbility =  Ability(_id, _name, _description);
        abilities.push(newAbility);
        idToAbility[_id] = newAbility;
    }

    function getTypes() public view returns(Type[] memory){
        return types;
    }

    function getAbilities() public view returns(Ability[] memory){
        return abilities;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }    

}