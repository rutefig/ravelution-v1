// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Ravelution is ERC721URIStorage {
    using Strings for uint256;
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    uint public danceTimeRequired; // in seconds

    constructor(uint _danceTimeRequired) ERC721("Ravelution", "RVLTN") {
        danceTimeRequired = _danceTimeRequired;
    }

    function generate() internal pure returns (string memory) {
        bytes memory svg = abi.encodePacked(
            '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350">',
            "<style>.base { fill: white; font-family: serif; font-size: 14px; }</style>",
            '<rect width="100%" height="100%" fill="black" />',
            '<text x="50%" y="40%" class="base" dominant-baseline="middle" text-anchor="middle">',
            "Ravelution",
            "</text>",
            "</svg>"
        );
        return
            string(
                abi.encodePacked(
                    "data:image/svg+xml;base64,",
                    Base64.encode(svg)
                )
            );
    }

    function getTokenURI(uint256 tokenId) public pure returns (string memory) {
        bytes memory dataURI = abi.encodePacked(
            "{",
            '"name": "Ravelution #',
            tokenId.toString(),
            '",',
            '"description": "This NFT is your reward for dancing like a party animal",',
            '"image": "',
            generate(),
            '"',
            "}"
        );
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(dataURI)
                )
            );
    }

    function collect(uint _danceTime) public {
        require(_danceTime >= danceTimeRequired, "Not enough dance time");
        mint(msg.sender);
    }

    function mint(address to) internal {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, getTokenURI(tokenId));
    }
}
