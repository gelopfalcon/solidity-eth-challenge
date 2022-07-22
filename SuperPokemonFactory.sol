// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol";

contract PokemonFactory is ERC721, VRFConsumerBase {
    event NewPokemon(bytes32 indexed requestId,address owner);

    enum Pokemon {
        BULBASAUR,
        CHARMANDER,
        SQUIRTLE,
        CATERPIE,
        WEEDLE,
        PIDGEY,
        RATTATA,
        SPEAROW,
        EKANS,
        PIKACHU,
        SANDSHREW
    }
   
    uint256 public tokenCounter;
    bytes32 public keyhash;
    uint256 public fee;

    mapping(uint => address) public pokemonToOwner;
    mapping(uint256 => Pokemon) public tokenIdToPokemon;
    mapping(bytes32 => address)public requestIdToSender;


    constructor (
        address _vrfCoordinator,
        address _linkToken,
        bytes32 _keyhash,
        uint256 _fee
    ) public VRFConsumerBase(_vrfCoordinator, _linkToken)
        ERC721("Pokemon", "POK") 
        {
            tokenCounter = 0;
            keyhash = _keyhash;
            fee = _fee;
        }


    function createPokemon() public returns(bytes32) {
        bytes32 requestId = requestRandomness(keyhash, fee);
        requestIdToSender[requestId] = msg.sender;
        emit NewPokemon(requestId, msg.sender);
    }

    function fulfillRandomness(bytes32 requestId, uint256 randomNumber)
        internal
        override
    {
        Pokemon pokemon = Pokemon(randomNumber % 10);
        uint256 id = tokenCounter;
        tokenIdToPokemon[id] = pokemon;
        address owner = requestIdToSender[requestId];
        _safeMint(owner, id);
        tokenCounter += 1;
    }

    function setTokenURI(uint256 tokenId) public {
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "Pokemon caller is not owner or not approved!"
        );
        tokenURI(tokenId);
    }
}
