// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PokemonFactory {

  struct Ability{
    string name;
    string description;
  }

  struct Pokemon {
    uint id;
    string name;
    string[] abilities;
    string[] types;
    string[] weaknesses;
   }

  

  event eventNewPokemon(uint _id);

    Pokemon[] private pokemons;
    Ability[] private abilities;

    mapping (uint => address) public pokemonToOwner;
    mapping (address => uint) ownerPokemonCount;
    mapping (string => Ability) public Allabilities;
     
     function createPokemon (uint _id, string memory _name, string[] memory _abilities, string[] memory _types, string[] memory _weaknesses) public {
        require(_id > 0, "El ID debe de ser mayor a 0");
        require(_abilities.length != 0, "Requieres asignar al menos una abilidad.");
        pokemons.push(Pokemon(_id, _name, _abilities, _types, _weaknesses));
        pokemonToOwner[_id] = msg.sender;
        ownerPokemonCount[msg.sender]++;
        emit eventNewPokemon(_id);
    }

    function createAbility(string memory _name, string memory  _description) public{
      require(bytes(_name).length != 0, "Olvidas el nombre de la habilidad");
      require(bytes(_description).length != 0, "Olvidas la descripcion de la habilidad");
      Allabilities[_name] = Ability(_name, _description);
      abilities.push(Allabilities[_name]);
    }

    function getAbilities() public view returns (Ability[] memory) {
      return abilities;
    }

    function getAllPokemons() public view returns (Pokemon[] memory) {
      return pokemons;
    }

}
