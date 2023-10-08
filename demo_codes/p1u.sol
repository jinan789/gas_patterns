pragma solidity ^0.8.17;

contract OperaBaseTokenTaxed {
    uint256 public _liquidityBuyTax;
    uint256 public _liquiditySellTax;

    function getTotalTax() internal view returns (uint) {
        return 300;
    }
    
    function tokenSwap() public {
        uint256 amount = 200;

        uint256 amountToLiquify = (_liquidityBuyTax + _liquiditySellTax > 0)
            ? amount * (_liquidityBuyTax + _liquiditySellTax) / getTotalTax() / 2
            : 0;
        uint256 totalETHFee = (_liquidityBuyTax + _liquiditySellTax > 0)
            ? getTotalTax() - (_liquidityBuyTax + _liquiditySellTax) / 2
            : getTotalTax();
    
        uint256 amountETH = 100;
        uint256 amountETHLiquidity = amountETH * (_liquidityBuyTax + _liquiditySellTax) / totalETHFee / 2;
    }
}