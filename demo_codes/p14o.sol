pragma solidity ^0.8.0;

contract IdleStrategy  {
    uint256 private _lastIdleTokenPrice;

    function _calculateYieldPercentage(uint256 inVal) internal returns (uint256) {
        return inVal % 2 + inVal;
    }

    function tokenPriceWithFee(address inVal) internal returns (uint256) {
        return 0;
    }

    function _getYieldPercentage() public returns (uint256 baseYieldPercentage) {
        uint256 currentIdleTokenPrice = tokenPriceWithFee(address(this));
        uint256 cachedVal = _lastIdleTokenPrice;

        baseYieldPercentage = _calculateYieldPercentage(cachedVal);

        if (currentIdleTokenPrice != cachedVal) {
            _lastIdleTokenPrice = currentIdleTokenPrice;
        }
    }
}