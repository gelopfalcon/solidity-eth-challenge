const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");
const { any } = require("hardhat/internal/core/params/argumentTypes");
const { ethers } = require("hardhat");

describe("PokemonFactory", function () {

  ////////////////
  // THIS PIECE OF CODE IS REPLACED BY ethers.BigNumber.from()

  // https://sabe.io/blog/javascript-hex-to-decimal
  // https://stackoverflow.com/questions/57803/how-to-convert-decimal-to-hexadecimal-in-javascript

  // const intToHex = intNumber => '0x' + (intNumber < 16  ? '0' : '') + intNumber.toString(16);
  // _id: 1,  // 0x01
  // _id: 10, // 0xa
  // _id: 11, // 0xb
  // _id: 16, // 0x10
  // _id: 17, // 0x11

  // const intToUint = intNumber => ({
  //   _hex: intToHex(intNumber),
  //   _isBigNumber: true,
  // });
  ////////////////

  const abilities = {
    Static: {
      name: "Static",
      description: "Can cause paralysis in battle if hit by a physical move",
    },
    Stall: {
      name: "Stall",
      description: "Can move after all other Pokemon do",  
    },
    BattleArmor: {
      name: "Battle Armor",
      description: "Hard armor protects the Pokémon from critical hits",
    },
  };

  const pokemonTypes = {
    NoWeakness: 0,
    Normal: 1,
    Fire: 2,
    Water: 3,
    Grass: 4,
    Electric: 5,
    Ice: 6,
    Fighting: 7,
    Poison: 8,
    Ground: 9,
    Flying: 10,
    Psychic: 11,
    Bug: 12,
    Rock: 13,
    Ghost: 14,
    Dark: 15,
    Dragon: 16,
    Steel: 17,
    Fairy: 18,
  };

  const images = {
    Pikachu: "https://static.wikia.nocookie.net/pokemon/images/0/0d/025Pikachu.png",
    Sableye: "https://static1.cbrimages.com/wordpress/wp-content/uploads/2021/03/Sableye-In-Pokemon.jpg?q=50&fit=crop&w=750&dpr=1.5",
    None: "",
  }

  const pokemonPikachu = {
    _name: "Pikachu",
    _id: 1,
    _abilityName: abilities.Static.name,
    _abilityDescription: abilities.Static.description,
    _type: pokemonTypes.Electric,
    _weakness: pokemonTypes.Ground,
    _image: images.Pikachu,
  };

  const pokemonSableye = {
    _name: "Sableye",
    _id: 17,
    _abilityName: abilities.Stall.name,
    _abilityDescription: abilities.Stall.description,
    _type: pokemonTypes.Ghost,
    _weakness: pokemonTypes.NoWeakness,
    _image: images.Sableye,
  };

  const pokemonDataNoAbilityName = {
    _name: "Wrong Pokemon",
    _id: 1,
    _abilityName: "",
    _abilityDescription: abilities.Static.description,
    _type: pokemonTypes.Electric,
    _weakness: pokemonTypes.Ground,
    _image: images.None,
  };

  const pokemonDataNoAbilityDescription = {
    _name: "Wrong Pokemon",
    _id: 1,
    _abilityName: abilities.Static.name,
    _abilityDescription: "",
    _type: pokemonTypes.Electric,
    _weakness: pokemonTypes.Ground,
    _image: images.None,
  };

  const pokemonDataBadName = {
    _name: "P",
    _id: 1,
    _abilityName: abilities.Static.name,
    _abilityDescription: abilities.Static.description,
    _type: pokemonTypes.Electric,
    _weakness: pokemonTypes.Ground,
    _image: images.None,
  };

  const pokemonDataBadId = {
    _name: "Wrong Pokemon",
    _id: 0,
    _abilityName: abilities.Static.name,
    _abilityDescription: abilities.Static.description,
    _type: 4,
    _weakness: 8,
    _image: images.None,
  };

  const createPokemons = async function () {
  
    let { pokemonFactory } = await loadFixture(deployPokemonFactoryFixture);

    // Create the 1st pokemon
    await pokemonFactory.createPokemon(
      pokemonPikachu._name,
      pokemonPikachu._id,
      pokemonPikachu._abilityName,
      pokemonPikachu._abilityDescription,
      pokemonPikachu._type,
      pokemonPikachu._weakness,
      pokemonPikachu._image
    );

    // Create the other pokemon
    await pokemonFactory.createPokemon(
      pokemonSableye._name,
      pokemonSableye._id,
      pokemonSableye._abilityName,
      pokemonSableye._abilityDescription,
      pokemonSableye._type,
      pokemonSableye._weakness,
      pokemonSableye._image
    );

    return pokemonFactory;
  };

  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  async function deployPokemonFactoryFixture() {
    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await ethers.getSigners();

    const PokemonFactory = await ethers.getContractFactory("PokemonFactory");
    const pokemonFactory = await PokemonFactory.deploy();

    return { pokemonFactory, owner, otherAccount };
  }

  const createOnePokemon = async function (pokemonData) {
    const { pokemonFactory, owner, otherAccount } = await loadFixture(deployPokemonFactoryFixture);
    const pokemonCreated = await pokemonFactory.createPokemon(
        pokemonData._name,
        pokemonData._id,
        pokemonData._abilityName,
        pokemonData._abilityDescription,
        pokemonData._type,
        pokemonData._weakness,
        pokemonData._image
      );
    return { pokemonFactory, pokemonCreated, owner, otherAccount };
  }

  describe("Deployment", function () {

    it("PokemonFactory should has balance = 0", async function () {
      const { pokemonFactory } = await loadFixture(
        deployPokemonFactoryFixture
      );

      expect(await ethers.provider.getBalance(pokemonFactory.address)).to.equal(0);
    });

  });

  describe("Create Pokemon", function () {

    describe("Events", function () {

      it("Should create the Pokemon and emit an event", async function () {
        const {pokemonFactory, pokemonCreated} = await createOnePokemon(pokemonPikachu);

        await expect(pokemonCreated)
          .to.emit(pokemonFactory, "eventNewPokemon")
          .withArgs([pokemonPikachu._id, pokemonPikachu._name], 0);
      });

    });

    describe("Value returns", function () {

      it("Should create Pokemons and get the list of them", async function () {
        pokemonFactory = await createPokemons();

        // This is the wrong way to test a returning array of structs
        
        // expect(await pokemonFactory.getAllPokemons()).to.be.equals(
        //   [
        //     [
        //       ethers.BigNumber.from(pokemonPikachu._id),
        //       // intToUint(pokemonPikachu._id),
        //       pokemonPikachu._name,
        //     ],
        //     [
        //       ethers.BigNumber.from(pokemonSableye._id),
        //       // intToUint(pokemonSableye._id),
        //       pokemonSableye._name,
        //     ],
        //   ]
        // );

        // google: chai test how to compare a returning struct from solidity
        // Solidity testing of the Struct
        // https://stackoverflow.com/questions/71614428/solidity-testing-of-the-struct

        // This is the right way to test a returning array of structs

        const [pokemon1, pokemon2] = await pokemonFactory.getAllPokemons();
        expect(pokemon1.id).to.be.equal(ethers.BigNumber.from(pokemonPikachu._id));
        expect(pokemon1.name).to.be.equal(pokemonPikachu._name);
        expect(pokemon2.id).to.be.equal(ethers.BigNumber.from(pokemonSableye._id));
        expect(pokemon2.name).to.be.equal(pokemonSableye._name);

      });

      it("get a Pokemon by a valid Id", async function () {
        pokemonFactory = await createPokemons();

        // This is the wrong way to test a returning struct

        // expect(await pokemonFactory.getPokemonById(pokemonSableye._id)).to.be.equals(
        //   [
        //     ethers.BigNumber.from(pokemonSableye._id),
        //     // intToUint(pokemonSableye._id),
        //     pokemonSableye._name,
        //   ],
        // );

        // This is the right way to test a returning struct

        const [id, name] = await pokemonFactory.getPokemonById(pokemonSableye._id);
        expect(id).to.be.equal(ethers.BigNumber.from(pokemonSableye._id));
        expect(name).to.be.equal(pokemonSableye._name);

      });

    });

    describe("Validations", function () {

      it("Should revert when Ability Name isn't provided", async function () {
        const { pokemonFactory } = await loadFixture(deployPokemonFactoryFixture);

        await expect(pokemonFactory.createPokemon(
            pokemonDataNoAbilityName._name,
            pokemonDataNoAbilityName._id,
            pokemonDataNoAbilityName._abilityName,
            pokemonDataNoAbilityName._abilityDescription,
            pokemonDataNoAbilityName._type,
            pokemonDataNoAbilityName._weakness,
            pokemonDataNoAbilityName._image
          ))
          .to.be.revertedWith(
            "Ability name must be specified"
          );
      });

      it("Should revert when Ability Description isn't provided", async function () {
        const { pokemonFactory } = await loadFixture(deployPokemonFactoryFixture);

        await expect(pokemonFactory.createPokemon(
            pokemonDataNoAbilityDescription._name,
            pokemonDataNoAbilityDescription._id,
            pokemonDataNoAbilityDescription._abilityName,
            pokemonDataNoAbilityDescription._abilityDescription,
            pokemonDataNoAbilityDescription._type,
            pokemonDataNoAbilityDescription._weakness,
            pokemonDataNoAbilityDescription._image
          ))
          .to.be.revertedWith(
            "Ability description must be specified"
          );
      });

      it("Should revert when Pokemon Name doesn't meet conditions", async function () {
        const { pokemonFactory } = await loadFixture(deployPokemonFactoryFixture);

        await expect(pokemonFactory.createPokemon(
            pokemonDataBadName._name,
            pokemonDataBadName._id,
            pokemonDataBadName._abilityName,
            pokemonDataBadName._abilityDescription,
            pokemonDataBadName._type,
            pokemonDataBadName._weakness,
            pokemonDataBadName._image
          ))
          .to.be.revertedWith(
            "Name cannot be empty and must be greater than 2 characters"
          );
      });

      it("Should revert when Pokemon id is less than 1", async function () {
        const { pokemonFactory } = await loadFixture(deployPokemonFactoryFixture);

        await expect(pokemonFactory.createPokemon(
            pokemonDataBadId._name,
            pokemonDataBadId._id,
            pokemonDataBadId._abilityName,
            pokemonDataBadId._abilityDescription,
            pokemonDataBadId._type,
            pokemonDataBadId._weakness,
            pokemonDataBadId._image
          ))
          .to.be.revertedWith(
            "Id must be greater than zero"
          );
      });

    });

  });

  describe("Abilities", function () {

    describe("Value returns", function () {

      it("Get Pokemon 3 abilities", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addAbilityToPokemon(
          pokemonPikachu._id,
          abilities.BattleArmor.name,
          abilities.BattleArmor.description,
        )

        await pokemonFactory.addAbilityToPokemon(
          pokemonPikachu._id,
          abilities.Stall.name,
          abilities.Stall.description,
        )

        const [ability1, ability2, ability3] = await pokemonFactory.getPokemonAbilities(
          pokemonPikachu._id
        );

        expect(ability1.name).to.be.equal(abilities.Static.name);
        expect(ability1.description).to.be.equal(abilities.Static.description);

        expect(ability2.name).to.be.equal(abilities.BattleArmor.name);
        expect(ability2.description).to.be.equal(abilities.BattleArmor.description);

        expect(ability3.name).to.be.equal(abilities.Stall.name);
        expect(ability3.description).to.be.equal(abilities.Stall.description);

      });

    });

    describe("Validations", function () {
    
      it("Should revert with the right error if another account than the owner tried to add an ability", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).addAbilityToPokemon(
          pokemonPikachu._id,
          anyValue,
          anyValue
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to add an ability", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await expect(pokemonFactory.addAbilityToPokemon(
          pokemonPikachu._id,
          abilities.BattleArmor.name,
          abilities.BattleArmor.description,
        )).not.to.be.reverted;
      });

      it("Should revert with the right error if another account than the owner tried to remove an ability", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addAbilityToPokemon(
          pokemonPikachu._id,
          abilities.BattleArmor.name,
          abilities.BattleArmor.description,
        )

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).removeAbilityFromPokemon(
          pokemonPikachu._id,
          0
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to remove an ability", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addAbilityToPokemon(
          pokemonPikachu._id,
          abilities.BattleArmor.name,
          abilities.BattleArmor.description,
        )

        await pokemonFactory.addAbilityToPokemon(
          pokemonPikachu._id,
          abilities.Stall.name,
          abilities.Stall.description,
        )

        await expect(pokemonFactory.removeAbilityFromPokemon(
          pokemonPikachu._id,
          0
        )).not.to.be.reverted;
      });

    });

  });

  describe("Types", function () {

    describe("Value returns", function () {

      it("Get Pokemon 3 types", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        )

        await pokemonFactory.addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Fairy
        )

        const [type1, type2, type3] = await pokemonFactory.getPokemonTypes(
          pokemonPikachu._id
        );

        expect(type1).to.be.equal(pokemonTypes.Electric);
        expect(type2).to.be.equal(pokemonTypes.Normal);
        expect(type3).to.be.equal(pokemonTypes.Fairy);

      });

    });

    describe("Validations", function () {
    
      it("Should revert with the right error if another account than the owner tried to add a type", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to add a type", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await expect(pokemonFactory.addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        )).not.to.be.reverted;
      });

      it("Should revert with the right error if another account than the owner tried to remove a type", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        );

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).removeTypeFromPokemon(
          pokemonPikachu._id,
          0
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to remove a type", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        );

        await pokemonFactory.addTypeToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Dark
        )

        await expect(pokemonFactory.removeTypeFromPokemon(
          pokemonPikachu._id,
          0
        )).not.to.be.reverted;
      });

    });

  });

  describe("Weakness", function () {

    describe("Value returns", function () {

      it("Get Pokemon 3 weakness", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        )

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Fairy
        )

        const [type1, type2, type3] = await pokemonFactory.getPokemonWeaknesses(
          pokemonPikachu._id
        );

        expect(type1).to.be.equal(pokemonTypes.Ground);
        expect(type2).to.be.equal(pokemonTypes.Normal);
        expect(type3).to.be.equal(pokemonTypes.Fairy);

      });

    });

    describe("Validations", function () {
    
      it("Should revert with the right error if another account than the owner tried to add a weakness", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to add a weakness", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await expect(pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        )).not.to.be.reverted;
      });

      it("Should revert with the right error if another account than the owner tried to remove a weakness", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        );

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).removeWeaknessFromPokemon(
          pokemonPikachu._id,
          0
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to remove a weakness", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        );

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Dark
        )

        await expect(pokemonFactory.removeWeaknessFromPokemon(
          pokemonPikachu._id,
          0
        )).not.to.be.reverted;
      });

      it("Should revert with a panic code removing a weakness with out-of-bounds index", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Normal
        );

        await pokemonFactory.addWeaknessToPokemon(
          pokemonPikachu._id,
          pokemonTypes.Dark
        )

        await expect(pokemonFactory.removeWeaknessFromPokemon(
          pokemonPikachu._id,
          5
        )).to.be.revertedWithPanic(
          // "panic code 0x32 (Array accessed at an out-of-bounds or negative index)"
          "0x32"
        );

      });

    });

  });

  describe("Images", function () {

    describe("Value returns", function () {

      it("Get Pokemon 3 images", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addImageToPokemon(
          pokemonPikachu._id,
          images.Sableye
        )

        await pokemonFactory.addImageToPokemon(
          pokemonPikachu._id,
          images.None
        )

        const [type1, type2, type3] = await pokemonFactory.getPokemonImages(
          pokemonPikachu._id
        );

        expect(type1).to.be.equal(images.Pikachu);
        expect(type2).to.be.equal(images.Sableye);
        expect(type3).to.be.equal(images.None);

      });

    });

    describe("Validations", function () {
    
      it("Should revert with the right error if another account than the owner tried to add an image", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).addImageToPokemon(
          pokemonPikachu._id,
          images.Sableye
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to add an image", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await expect(pokemonFactory.addImageToPokemon(
          pokemonPikachu._id,
          images.Sableye
        )).not.to.be.reverted;
      });

      it("Should revert with the right error if another account than the owner tried to remove an image", async function () {
        const { pokemonFactory, otherAccount } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addImageToPokemon(
          pokemonPikachu._id,
          images.Sableye
        );

        // We use pokemonFactory.connect() to send a transaction from another account
        await expect(pokemonFactory.connect(otherAccount).removeImageFromPokemon(
          pokemonPikachu._id,
          0
        )).to.be.revertedWith(
          "You cannot modify this Pokemon's data because you are not the original author"
        );
      });

      it("Shouldn't fail if the Pokemon owner tried to remove an image", async function () {
        const { pokemonFactory } = await createOnePokemon(pokemonPikachu);

        await pokemonFactory.addImageToPokemon(
          pokemonPikachu._id,
          images.Sableye
        );

        await pokemonFactory.addImageToPokemon(
          pokemonPikachu._id,
          images.None
        )

        await expect(pokemonFactory.removeImageFromPokemon(
          pokemonPikachu._id,
          0
        )).not.to.be.reverted;
      });

    });

  });

});
