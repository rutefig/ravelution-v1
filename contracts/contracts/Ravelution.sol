// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

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

    // function generate(string memory image) public returns(string memory) {
    //     bytes memory svg = abi.encodePacked()
    // }

    function dance(uint _danceTime) public {
        require(_danceTime >= danceTimeRequired, "Not enough dance time");
        mint(msg.sender);
    }

    function mint(address to) internal {
        _tokenIdCounter.increment();
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(to, tokenId);
    }
}
