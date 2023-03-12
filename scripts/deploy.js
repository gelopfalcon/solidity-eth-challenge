const { ethers } = require("hardhat");

async function main() {
    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const pokemonFactory = await PokemonFactory.deploy();

    console.log("PokemonFactory deployed to:", pokemonFactory.address);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });