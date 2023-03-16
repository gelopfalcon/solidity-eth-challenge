const { expect }  = require("chai");
const { ethers } = require("hardhat");


describe ("Pokemon contract", ()=> {


    it("Pokemon Factory shoulnt have 2 pokemons", async ()=>{
    
        const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
        
        const hardhatPokemon = await PokemonFactory.deploy();

        //Created
        await hardhatPokemon.createPokemon("Charmander", 1, [["Fuego","Aire color rojo que quema."], 
                                                             ["Lanzar llamas", "Aqui va la descripcion"]], [0], [1,2]);
        await hardhatPokemon.createPokemon("Bulbasaur ", 2, [["Semilla","Lanzar Semillas"]], [0], [1,2,5]);


        const pokemons = await hardhatPokemon.getAllPokemons();

       
        expect(pokemons.length).to.equal(2);
    });

});