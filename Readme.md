# Contract PokemonFactory

Contract developed as part of the ethereum developer program from **Platzi**

# Functions

## **createPokemon**
It should be your entry point, this function allows you to create a new Pokemon

* **Input**:

    **name**: Name of the pokemon. ie: *Bulbasaur*  
    **id**: Int identifier. ie: *1*  
    **typesIds***: Array of the Id's representing the type of Pokemon. ie: *[9,13]*  
    **weaknessIds***: Array of the Id's representing the weaknesses the Pokemon has. ie: *[6,14,7,11]*  

    \* *To know the id's of the specific type or wekness you should execute the **seeAvailableTypes** function i.e: [9,13] represents: [Grass, Poison]*  

* **Output**:

    It emits and **eventNewPokemon** event that show the Pokemon just created

<br>

## **addPokemonAbility**
It allows you add abilities to a Pokemon that already exists

* **Input**:
 
    **idPokemon**: Int identifier for pokemon (the same id when created). ie: *1*  
    **name**: The name of the ability. i.e: *Overgrow*  
    **description**: Description of ability. ie: *Powers up Grass-type moves when the Pokémon's HP is low.*    

* **Output**:

    It emits and **eventNewAbility** event that show the Ability just added

<br>

## **getAllPokemons**
It allows you to list all pokemons created  

* **Output**:

    It returns an array of all the Pokemons that have been created

<br>

## **getPokemon**
It allows you to get all the information about a specific pokemon

* **Input**:
 
    **idPokemon**: Int identifier for pokemon (the same id when created). ie: *1*   

* **Output**:

    **pokemon**: Pokemon struct that contains: id, name, types and weaknesses  
    **abilities**: An array of names and descriptions of all the abilities for the specific pokemon.

<br>

## **getPokemonAbilities**
It allows you to list all the abilities of a specific pokemon

* **Input**:
 
    **idPokemon**: Int identifier for pokemon (the same id when created). ie: *1*     

* **Output**:

    It returns an array of names and descriptions of all the abilities for the specific pokemon.

<br>

## **seeAvailableTypes**
It allows you to list all the types (or weaknesses) of a pokemons available

* **Output**:

    It returns an array of id:type  for the available types and weaknesses of pokemons, at the creation of the contract it is the same as the following:

    | id | Type or Weakness |
    |----|------------------|
    | 0  | Bug              |
    | 1  | Dark             |
    | 2  | Dragon           |
    | 3  | Electric         |
    | 4  | Fairy            |
    | 5  | Fighting         |
    | 6  | Fire             |
    | 7  | Flying           |
    | 8  | Ghost            |
    | 9  | Grass            |
    | 10 | Ground           |
    | 11 | Ice              |
    | 12 | Normal           |
    | 13 | Poison           |
    | 14 | Psychic          |
    | 15 | Rock             |
    | 16 | Steel            |
    | 17 | Water            |

<br>

# Public Vars

## pokemonToOwner
Mapping that allows you to know the owner of a specific pokemon, by its id