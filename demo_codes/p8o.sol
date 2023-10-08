pragma solidity ^0.8.0;

contract DigiMonkzStaking {

    mapping(address => mapping(uint16 => bool)) public gen1StakedArray;
    mapping(uint16 => bool) public isGen1Staked;

    function gen1IndividualStake(uint16 _tokenId) private {
        require(isGen1Staked[_tokenId] == false);
        gen1StakedArray[msg.sender][_tokenId] = true;
        isGen1Staked[_tokenId] = true;
        // emit Stake(_tokenId);
    }

    function gen1Stake(uint16[] memory _tokenIds) private returns (bool) {
        uint256 tokenLen = _tokenIds.length;
        for (uint256 i = 0; i < tokenLen; i++) {
            gen1IndividualStake(_tokenIds[i]);
        }
        return true;
    }

    function gen1IndividualUnstake(uint16 _tokenId) private {
        require (gen1StakedArray[msg.sender][_tokenId] == true);

        gen1StakedArray[msg.sender][_tokenId] = false;
        isGen1Staked[_tokenId] = false;

        // emit Unstake(_tokenId, stakedTime, block.timestamp);
    }

    function gen1Unstake(uint16[] memory _tokenIds) external returns (bool) {
        // for testing purposes, we first load the token ids
        gen1Stake(_tokenIds);
        uint256 tokenLen = _tokenIds.length;
        for (uint256 i = 0; i < tokenLen; i++) {
            gen1IndividualUnstake(_tokenIds[i]);
        }
        return true;
    }
}