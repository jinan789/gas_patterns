pragma solidity ^0.8.17;

contract AaveV2Strategy {
    function assetRatio() public returns (uint256) {
        uint256[] memory _assetRatio = new uint256[](3);
        _assetRatio[0] = 1;
        _assetRatio[1] = 2;
        _assetRatio[2] = 3;
        return 1;
    }
}