pragma solidity ^0.8.0;

contract DigiMonkzStaking {

    mapping(address => uint16[]) public gen1StakedArray;
    mapping(uint16 => bool) public isGen1Staked;

    function gen1IndividualStake(uint16 _tokenId) private {
        require(isGen1Staked[_tokenId] == false);
        gen1StakedArray[msg.sender].push(_tokenId);
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

        uint256 len = gen1StakedArray[msg.sender].length;
        require(len != 0);

        uint256 idx = len;
        for (uint16 i = 0; i < len; i++) {
            if (gen1StakedArray[msg.sender][i] == _tokenId) {
                idx = i;
            }
        }
        require(idx != len);

        // uint256 stakedTime = gen1InfoPerStaker[msg.sender][idx].stakedAt;
        if (idx != len - 1) {
            gen1StakedArray[msg.sender][idx] = gen1StakedArray[msg.sender][
                len - 1
            ];
        }

        gen1StakedArray[msg.sender].pop();
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