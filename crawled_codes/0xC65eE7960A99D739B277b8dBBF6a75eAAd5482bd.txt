// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
********************          ********************          ********************
********************          ********************          ******************((
********************          ********************          ***************(((((
********************          ********************          *************(((((((
********************          ********************          **********((((((((((
********************          ********************          ********((((((((((((
********************          ********************          *****(((((((((((((((
********************          ********************          ***(((((((((((((((((
                                                                                
                                                                                
                                                                                
                                                                                
********************          ********************          ((((((((((((((((((((
********************          ******************((          ((((((((((((((((((((
********************          ***************(((((          ((((((((((((((((((((
********************          *************(((((((          ((((((((((((((((((((
********************          **********((((((((((          ((((((((((((((((((((
********************          ********((((((((((((          ((((((((((((((((((((
********************          *****(((((((((((((((          ((((((((((((((((((((
********************          ***(((((((((((((((((          ((((((((((((((((((((
********************                                                            
********************                                                            
********************                                                            
********************                                                            
********************((((((((((((((((((((((((((((((          ((((((((((((((((((((
******************((((((((((((((((((((((((((((((((          ((((((((((((((((((((
***************(((((((((((((((((((((((((((((((((((          ((((((((((((((((((((
*************(((((((((((((((((((((((((((((((((((((          ((((((((((((((((((((
**********((((((((((((((((((((((((((((((((((((((((          ((((((((((((((((((((
********((((((((((((((((((((((((((((((((((((((((((          ((((((((((((((((((((
*****(((((((((((((((((((((((((((((((((((((((((((((          ((((((((((((((((((((
***(((((((((((((((((((((((((((((((((((((((((((((((          ((((((((((((((((((((
 */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

struct NftInfo {
    uint256 moe;
    string uri;
    string originalCreator;
    bytes4 jsonId;
    bool isOriginal;
    bool isSecondaryCreation;
}

contract MoeErc721 is ERC721 {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdTracker;
    uint256 public constant fee = 10**18;
    address public immutable moeErc20Address;

    mapping (uint256 => NftInfo) public nftInfo;
    
    constructor(string memory _name, string memory _symbol, address _moeErc20Address) ERC721(_name, _symbol) {
        moeErc20Address = _moeErc20Address;
    }

    function mint(address to, uint256 moe, string memory uri, string memory originalCreator, bytes4 jsonId, bool isOriginal,  bool isSecondaryCreation) public {
        ERC20 moeErc20 = ERC20(moeErc20Address);
        require(moeErc20.balanceOf(_msgSender()) >= moe, "MOE: insufficient MOE balance");
        require(moe >= fee, "MOE: a minimum of 1 MOE is required");
        moeErc20.transferFrom(_msgSender(), address(this), moe);
        _mint(to, _tokenIdTracker.current());
        nftInfo[_tokenIdTracker.current()] = NftInfo(moe, uri, originalCreator, jsonId, isOriginal, isSecondaryCreation);
        _tokenIdTracker.increment();
    }

    function addMoe(uint256 moe, uint256 tokenId) public {
        _requireMinted(tokenId);
        require(moe > 0, "MOE: enter the additional amount of MOE");
        require(_ownerOf(tokenId) == _msgSender(), "MOE: caller is not token owner");

        ERC20 moeErc20 = ERC20(moeErc20Address);
        require(moeErc20.balanceOf(_msgSender()) >= moe, "MOE: insufficient MOE balance");

        moeErc20.transferFrom(_msgSender(), address(this), moe);
        nftInfo[tokenId].moe += moe;
    }

    function removeMoe(uint256 moe, uint256 tokenId) public {
        _requireMinted(tokenId);
        require(moe <= (nftInfo[tokenId].moe - fee) && moe > 0, "MOE: cannot reduce the amount of MOE");
        require(_ownerOf(tokenId) == _msgSender(), "MOE: caller is not token owner");

        nftInfo[tokenId].moe -= moe;
        ERC20 moeErc20 = ERC20(moeErc20Address);
        moeErc20.transfer(_msgSender(), moe);
    }

    function tokenMoe(uint256 tokenId) public view returns (uint256) {
        _requireMinted(tokenId);

        return nftInfo[tokenId].moe;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireMinted(tokenId);

        return nftInfo[tokenId].uri;
    }

    function tokenOriginalCreator(uint256 tokenId) public view returns (string memory) {
        _requireMinted(tokenId);

        return nftInfo[tokenId].originalCreator;
    }

    function tokenJsonId(uint256 tokenId) public view returns (bytes4) {
        _requireMinted(tokenId);

        return nftInfo[tokenId].jsonId;
    }

    function tokenIsOriginal(uint256 tokenId) public view returns (bool) {
        _requireMinted(tokenId);

        return nftInfo[tokenId].isOriginal; 
    }
    
    function tokenIsSecondaryCreation(uint256 tokenId) public view returns (bool) {
        _requireMinted(tokenId);

        return nftInfo[tokenId].isSecondaryCreation;
    }

}