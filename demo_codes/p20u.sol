pragma solidity ^0.8.0;

contract DOLLARAI {
    uint256 private _redisFeeOnBuy = 0;  
    uint256 private _taxFeeOnBuy = 30;  
    uint256 private _redisFeeOnSell = 0;  
    uint256 private _taxFeeOnSell = 45;

    function setFee(uint256 taxFeeOnBuy, uint256 taxFeeOnSell) public {
        require(taxFeeOnBuy >= 0 && taxFeeOnBuy <= 99, "Buy tax must be between 0% and 99%");
        require(taxFeeOnSell >= 0 && taxFeeOnSell <= 99, "Sell tax must be between 0% and 99%");

        _taxFeeOnBuy = taxFeeOnBuy;
        _taxFeeOnSell = taxFeeOnSell;
    }
}