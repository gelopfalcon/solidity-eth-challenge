// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    // Structs
    struct pokemonMovement {
        string name;
        string description;
    }

    struct Pokemon {
        uint256 id;
        string name;
        pokemonMovement[] myPokemonMovements;
        Types[] elements;
    }

    //Events
    event eventNewPokemon(
        address pokemonOwner,
        string pokemonName,
        uint256 pokemonId
    );

    //Pure Private Methods
    function nameLenght(string memory text) private pure returns (bool) {
        if (bytes(text).length <= 2) {
            return false;
        } else {
            return true;
        }
    }

    //Declarations
    Pokemon[] private pokemons;
    pokemonMovement[] public pokemonMovements;

    //Asi para crear las debilidades de los pokemones
    enum Types {
        Acero,
        Agua,
        Bicho,
        Dragon,
        Electrico,
        fantasma,
        Fuego,
        Hada,
        Hielo,
        Lucha,
        Normal,
        Planta,
        Psiquico,
        Roca,
        Sinienstro,
        Tierra,
        Veneno,
        Volador
    }
    // mapping (Types => Types[]) public Debilities;

    mapping(uint256 => address) public pokemonToOwner;
    mapping(address => uint256) ownerPokemonCount;

    //Public Methods in the contract

    function createMovements(string memory _name, string memory _description)
        public
    {
        pokemonMovements.push(pokemonMovement(_name, _description));
    }

    function createPokemon(
        string memory _name,
        uint256 _id,
        uint8[] memory _userChoosenMovements,
        Types[] memory _types
    ) public {
        require(_id > 0, "Error: Pokemon id must be greater than 0");
        require(
            nameLenght(_name) == true,
            "Error: Pokemon Name must be more that 2 words"
        );
        require(
            _userChoosenMovements.length <= 4,
            "Error, a pokemon can not have more than 4 movements"
        );

        Pokemon storage _pokemon = pokemons.push();
        _pokemon.id = _id;
        _pokemon.name = _name;
        _pokemon.elements = _types;

        for (uint8 i = 0; i < _userChoosenMovements.length; i++) {
            _pokemon.myPokemonMovements.push(
                pokemonMovements[_userChoosenMovements[i]]
            );
        }

        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;

        emit eventNewPokemon(msg.sender, _name, _id);
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return pokemons;
    }

    function getOnePokemon(uint256 _id) public view returns (Pokemon memory) {
        return pokemons[_id];
    }

    function GetOneMovement(uint256 id)
        public
        view
        returns (pokemonMovement memory)
    {
        return pokemonMovements[id];
    }

    function getAllMovements() public view returns (pokemonMovement[] memory) {
        return pokemonMovements;
    }

    function getResult() public pure returns (uint256 product, uint256 sum) {
        uint256 a = 1;
        uint256 b = 2;
        product = a * b;
        sum = a + b;
    }
}
