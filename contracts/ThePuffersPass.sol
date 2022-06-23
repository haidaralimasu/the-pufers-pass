// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/extensions/ERC721AQueryable.sol";

contract ThePuffersPass is ERC721AQueryable, Ownable {
    using Strings for uint256;

    string private baseTokenURI;
    uint256 maxNfts = 999;
    bool public paused = false;

    constructor(string memory _baseTokenUri) ERC721A("ThePuffersPass", "TPP") {
        setBaseTokenURI(_baseTokenUri);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function _mintNfts(address _receiver, uint256 _mintAmount)
        internal
        mintCompliance(_mintAmount)
    {
        _safeMint(_receiver, _mintAmount);
    }

    function mint(address _reciever, uint256 _mintAmount)
        public
        isPaused
        onlyOwner
    {
        _mintNfts(_reciever, _mintAmount);
    }

    function mintBatch(
        address[] calldata _recievers,
        uint256[] calldata _mintAmounts
    ) public isPaused onlyOwner {
        for (uint256 i = 0; i < _recievers.length; i++) {
            require(
                totalSupply() + _mintAmounts[i] <= maxNfts,
                "All Nfts are solded out !!"
            );
            _mintNfts(_recievers[i], _mintAmounts[i]);
        }
    }

    modifier isPaused() {
        require(!paused, "Contract is paused right now !!");
        _;
    }

    modifier mintCompliance(uint256 _mintAmount) {
        require(_mintAmount > 0, "You have to mint atleast 1 Nft !!");
        require(_totalMinted() + _mintAmount <= maxNfts);
        _;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        ".json"
                    )
                )
                : "";
    }

    function togglePaused() public onlyOwner {
        paused = !paused;
    }

    function setBaseTokenURI(string memory _newBaseTokenURI) public onlyOwner {
        baseTokenURI = _newBaseTokenURI;
    }
}
