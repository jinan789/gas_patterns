// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SprotoApes is ERC721A, Ownable {
    uint256 public maxSupply = 1000;
    uint256 public mintPrice = .001 ether;
    uint256 public maxPerTx = 10;

    string public baseURI =
        "ipfs://QmWzhHkefkqTPmwTrP6ueo9fVXu9DwxuhPdLyrM1hKygeW/";
    bool public sale = false;

    error SaleNotActive();
    error MaxSupplyReached();
    error MaxPerTxReached();
    error NotEnoughETH();

    constructor() payable ERC721A("SprotoApes", "SPES") {}

    function mint(uint256 _amount) external payable {
        if (!sale) revert SaleNotActive();
        if (_totalMinted() + _amount > maxSupply) revert MaxSupplyReached();
        if (_amount > maxPerTx) revert MaxPerTxReached();
        if (msg.value < mintPrice * _amount) revert NotEnoughETH();

        _mint(msg.sender, _amount);
    }

    function ownerMint(address receiver, uint256 _amount) external onlyOwner {
        _mint(receiver, _amount);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();
        return string(abi.encodePacked(baseURI, _toString(tokenId), ".json"));
    }

    function _startTokenId() internal pure override returns (uint256) {
        return 1;
    }

    function setBaseURI(string calldata _newURI) external onlyOwner {
        baseURI = _newURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setMintPrice(uint256 _price) external onlyOwner {
        mintPrice = _price;
    }

    function setSupply(uint256 _newSupply) external onlyOwner {
        maxSupply = _newSupply;
    }

    function toggleSale() external onlyOwner {
        sale = !sale;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }
}