// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {
    struct Skill {
        uint256 id;
        string name;
        string description;
    }

    struct Pokemon {
        address owner;
        string name;
        uint256 id;
        uint256[] color;
        uint256 evolution;
        string[] elements;
        string[] weaknesses;
        Skill[] skills;
    }

    event eventNewPokemon(
        address owner,
        string name,
        uint256 id,
        uint256[] color,
        string[] elements,
        string[] weaknesses
    );

    event eventPokemonTrained(
        address owner,
        string pokemonName,
        uint256 pokemonId,
        uint256 pokemonNewEvolution,
        string skillName,
        uint256 skillId
    );

    mapping(uint256 => address) private s_pokemonIdToOwner;
    mapping(address => uint256) private s_ownerPokemonCount;

    Pokemon[] private s_pokemons;
    Skill[] private i_skills;
    string[18] private i_elements = [
        "Normal",
        "Fire",
        "Water",
        "Grass",
        "Flying",
        "Fighting",
        "Poison",
        "Electric",
        "Ground",
        "Rock",
        "Psychic",
        "Ice",
        "Bug",
        "Ghost",
        "Steel",
        "Dragon",
        "Dark",
        "Fairy"
    ];

    // Build the contract with the array of possible skills.
    constructor(Skill[] memory _skills) {
        for (uint256 i = 0; i < _skills.length; i++) {
            i_skills.push(_skills[i]);
        }
    }

    // returns [_minNum, _maxNum];
    function getRandom(
        uint256 _minNum,
        uint256 _maxNum,
        string memory _name,
        uint256 _id,
        uint256 _rCounter
    ) private view returns (uint256) {
        return
            (uint256(
                keccak256(abi.encodePacked(_name, _id, msg.sender, _rCounter))
            ) % uint256(_maxNum - _minNum + 1)) + _minNum;
    }

    function createPokemon(string memory _name) public {
        // Better solution with auto-id: generate the pokemon ID based on the current amount of pokemons
        // This eliminates the id collision posibility and remove the holes/leaks in the mapping ID.
        // => this result in better indexation, less reverted minting attemps and less lines of code. (Also save gas)

        require(
            bytes(_name).length > 2,
            "The pokemon name has to be larger than two characters"
        );

        require(
            s_ownerPokemonCount[msg.sender] < 3,
            "Only three pokemons are allowed per address"
        );

        // first pokemon id will be 0
        uint256 _id = s_pokemons.length;

        // counter used to add entropy to the getRandom function
        uint256 rCounter = 0;

        // pokemon amount of elements between 1 and 2. ( % by 2 gets 0-1, then add 1 => 1-2)
        uint256 elementsAmount = getRandom(1, 2, _name, _id, rCounter);
        rCounter++;
        // pokemon amount of weakness
        uint256 weaknessAmount = getRandom(1, 2, _name, _id, rCounter);
        rCounter++;

        // Initialize the memory arrays
        string[] memory _elements = new string[](elementsAmount);
        string[] memory _weaknesses = new string[](weaknessAmount);

        // generate indexes to select random elements and weaknesses
        // This is made to avoid using the same element twice.
        uint256 _elementIndex1 = getRandom(
            0,
            i_elements.length - 1,
            _name,
            _id,
            rCounter
        );
        rCounter++;
        _elements[0] = i_elements[_elementIndex1];

        // randomlly generate the 2nd index only if it's needed.
        uint256 _elementIndex2;
        if (elementsAmount == 2) {
            _elementIndex2 = getRandom(0, 17, _name, _id, rCounter);
            rCounter++;
            while (_elementIndex1 == _elementIndex2) {
                _elementIndex2 = getRandom(0, 17, _name, _id, rCounter);
                rCounter++;
            }
            _elements[1] = i_elements[_elementIndex2];
        } else {
            _elementIndex2 = _elementIndex1;
        }

        uint256 _elementIndex3 = getRandom(0, 17, _name, _id, rCounter);
        rCounter++;
        while (
            _elementIndex3 == _elementIndex1 || _elementIndex3 == _elementIndex2
        ) {
            _elementIndex3 = getRandom(0, 17, _name, _id, rCounter);
            rCounter++;
        }
        _weaknesses[0] = i_elements[_elementIndex3];

        // randomlly generate the 4th index only if is needed.
        uint256 _elementIndex4;
        if (weaknessAmount == 2) {
            _elementIndex4 = getRandom(0, 17, _name, _id, rCounter);
            rCounter++;
            while (
                _elementIndex4 == _elementIndex1 ||
                _elementIndex4 == _elementIndex2 ||
                _elementIndex4 == _elementIndex2
            ) {
                _elementIndex3 = getRandom(0, 17, _name, _id, rCounter);
                rCounter++;
            }
            _weaknesses[1] = i_elements[_elementIndex4];
        } else {
            _elementIndex4 = _elementIndex3;
        }

        uint256[] memory _color = new uint256[](3);
        rCounter++;
        _color[0] = getRandom(0,255, _name, _id, rCounter);
        rCounter++;
        _color[1] = getRandom(0,255, _name, _id, rCounter);
        rCounter++;
        _color[2] = getRandom(0,255, _name, _id, rCounter);


        s_pokemons.push();
        Pokemon storage pokemon = s_pokemons[_id];
        pokemon.name = _name;
        pokemon.id = _id;
        pokemon.evolution = 0;
        pokemon.weaknesses = _weaknesses;
        pokemon.elements = _elements;

        s_ownerPokemonCount[msg.sender]++;
        s_pokemonIdToOwner[_id] = msg.sender;
        emit eventNewPokemon(
            msg.sender,
            _name,
            _id,
            _color,
            _elements,
            _weaknesses
        );
        // trainPokemon(_id);
    }

    function trainPokemon(uint256 _id) public {
        require(
            s_pokemonIdToOwner[_id] == msg.sender,
            "The pokemon must exist and must belong to you to be trained."
        );
        require(
            s_pokemons[_id].evolution < 3,
            "The pokemon can't evolve from evolution 3."
        );

        // array that have the pokemon skills, with the ids.
        Skill[] memory skills = s_pokemons[_id].skills;

        // get a random skill number.
        uint256 skillIndex = getRandom(
            0,
            i_skills.length - 1,
            s_pokemons[_id].name,
            _id,
            block.timestamp + skills.length
        );
        // For the training to "succeed", a new skill id different from the actual skills must be obtained.
        // This way, every time the pokemon evolve it get's harder to train succesfully.
        // The possibility is (i_skills.length - skills.length / i_skills.length)
        // evolution 0 -> 1: i_skills.length = 6, skills = 0.  => possibility: 6/6 = 100%
        // evolution 1 -> 2: i_skills.length = 6, skills = 1.  => possibility: 5/6 = 83%
        // evolution 2 -> 3: i_skills.length = 6, skills = 2.  => possibility: 4/6 = 66%

        bool alreadySkill = false;
        for (uint256 i = 0; i < skills.length; i++) {
            if (skillIndex == skills[i].id) {
                alreadySkill = true;
                break;
            }
        }
        require(
            !alreadySkill,
            "The training was good, but the pokemon didn't evolve."
        );

        s_pokemons[_id].evolution++;
        Skill memory skill = i_skills[skillIndex];
        s_pokemons[_id].skills.push(skill);
        emit eventPokemonTrained(
            msg.sender,
            s_pokemons[_id].name,
            _id,
            s_pokemons[_id].evolution,
            skill.name,
            skill.id
        );
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
        return s_pokemons;
    }

    function getPokemonById(uint256 _id) public view returns (Pokemon memory) {
        return s_pokemons[_id];
    }

    function getPokemonOwnerById(uint256 _id) public view returns (address) {
        return s_pokemonIdToOwner[_id];
    }

    function getAmountOwnedByAddress(address _address)
        public
        view
        returns (uint256)
    {
        return s_ownerPokemonCount[_address];
    }

    function getAllElements() public view returns (string[18] memory) {
        return i_elements;
    }

    function getAllSkills() public view returns (Skill[] memory) {
        return i_skills;
    }
}
