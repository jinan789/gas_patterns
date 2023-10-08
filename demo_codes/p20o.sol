pragma solidity ^0.8.0;

contract DOLLARAI {
    uint256 private _redisFeeOnBuy = 0;  
    uint256 private _taxFeeOnBuy = 30;  
    uint256 private _redisFeeOnSell = 0;  
    uint256 private _taxFeeOnSell = 45;

    error InvalidRangeOfInput();

    function setFee(uint256 taxFeeOnBuy, uint256 taxFeeOnSell) public {
        if (taxFeeOnBuy < 0) revert InvalidRangeOfInput();
        if (taxFeeOnBuy > 99) revert InvalidRangeOfInput();
        if (taxFeeOnSell < 0) revert InvalidRangeOfInput();
        if (taxFeeOnSell > 99) revert InvalidRangeOfInput();

        _taxFeeOnBuy = taxFeeOnBuy;
        _taxFeeOnSell = taxFeeOnSell;
    }
}