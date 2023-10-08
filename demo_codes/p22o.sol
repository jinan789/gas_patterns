pragma solidity ^0.8.0;

contract PancakeChainlinkOracle {
    uint256 public constant Q96 = 2 ** 96;
    uint256 public constant s = 96;

    function latestAnswer() public returns (uint) {
        uint256 priceX96 = 1;
        return (Q96 << s) / priceX96;
    }
}