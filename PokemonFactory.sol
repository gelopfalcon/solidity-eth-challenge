// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

    struct Skills {
        string name;
        string description;
    }

    struct Pokemon {
        string name;
        uint id;
        string[] element;
        string[] weakness;
        Skills[] skills;
    }

    //Array of all the pokemons.
    Pokemon[] private pokemons;

    //Array of all posible elements.
    string[17] private elements = ["Fire", "Water", "Grass", "Electric", "Ice", "Fighting", "Poison", "Ground", "Flying", "Psychic", "Bug", "Rock", "Ghost", "Dark", "Dragon", "Steel", "Fairy"];
    
    //Giving an id of pokemon, returns the owner address.
    mapping(uint => address) public pokemonToOwner;

    //Giving an owner address, returns the count of pokemons.
    mapping(address => uint) public ownerPokemons;

    modifier isOwner(uint _id) {
        bool ownerPokemon = pokemonToOwner[_id] == msg.sender;
        require(ownerPokemon, "You can't train others pokemon.");
	    _;
    }

    //Event to communicate to the frontend that a new pokemon has been created.
    event NewPokemon (
        uint id,
        address owner,
        string name
    );

    function createPokemon(string memory _name) public {
        require(bytes(_name).length > 2, "The name must be longer than two characters."); 
        
        uint id = pokemons.length;

        pokemonToOwner[id] = msg.sender;
        ownerPokemons[msg.sender]++;

        //Inicialization of the struct with empty values.
        pokemons.push();

        pokemons[id].name = _name;
        pokemons[id].id = id;

        setPokemonAttributes(id, _name);

        emit NewPokemon(id, msg.sender, _name);
    }

    function setPokemonAttributes(uint _id, string memory _name) private {
        uint firstRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, _name, tx.gasprice))) % 17;
        uint secondRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, _id, block.gaslimit))) % 17;

        string memory firstElement = elements[firstRandomNumber];

        //Logic to ensure that the random numbers dont be the same and the modification dont overflow.
        uint counter = 0;

        while(firstRandomNumber == secondRandomNumber){
            secondRandomNumber = secondRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, _id, counter, block.gaslimit))) % 17;
            counter++;
        }

        string memory secondElement = elements[secondRandomNumber];
        
        pokemons[_id].element.push(firstElement);
        pokemons[_id].element.push(secondElement);

        setWeakness(firstRandomNumber, secondRandomNumber, _id);
    }

    function setWeakness(uint _firstRandomNumber, uint _secondRandomNumber, uint _id) private {
        uint thirdRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, _firstRandomNumber, tx.gasprice))) % 17;
        uint fourthRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, _secondRandomNumber, block.gaslimit))) % 17;

        uint counter = 0;

        while(thirdRandomNumber == _firstRandomNumber || thirdRandomNumber == _secondRandomNumber || thirdRandomNumber == fourthRandomNumber){
            thirdRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, counter, _firstRandomNumber)));
            counter++;
        }

        string memory firstWeakness = elements[thirdRandomNumber];

        while(fourthRandomNumber == _firstRandomNumber || fourthRandomNumber == _secondRandomNumber || fourthRandomNumber == thirdRandomNumber){
            fourthRandomNumber = uint(keccak256(abi.encodePacked(msg.sender, counter, _secondRandomNumber)));
            counter++;
        }

        string memory secondWeakness = elements[fourthRandomNumber];
        
        pokemons[_id].weakness.push(firstWeakness);
        pokemons[_id].weakness.push(secondWeakness);
    }

    function trainPokemon(uint _id,  string memory _skill, string memory _description) public isOwner(_id) {
        pokemons[_id].skills.push(Skills(_skill, _description));
    }

    function returnPokemons() public view returns(Pokemon[] memory){
        return pokemons;
    }
}
