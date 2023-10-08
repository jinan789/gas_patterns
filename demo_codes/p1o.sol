pragma solidity ^0.8.17;

contract OperaBaseTokenTaxed {
    uint256 public _liquidityBuyTax;
    uint256 public _liquiditySellTax;

    function getTotalTax() internal view returns (uint) {
        return 300;
    }
    
    function tokenSwap() public {
        uint256 amount = 200;

        uint256 taxSum = _liquidityBuyTax + _liquiditySellTax;
        uint256 amountToLiquify = (taxSum > 0)
            ? amount * (taxSum) / getTotalTax() / 2
            : 0;
        uint256 totalETHFee = (taxSum > 0)
            ? getTotalTax() - (taxSum) / 2
            : getTotalTax();
    
        uint256 amountETH = 100;
        uint256 amountETHLiquidity = amountETH * (taxSum) / totalETHFee / 2;
    }
}