pragma solidity ^0.8.0;

contract BBB {
    uint256 private _initialBuyTax=10;
    uint256 private _initialSellTax=30;
    uint256 private _finalBuyTax=2;
    uint256 private _finalSellTax=2;
    uint256 private _reduceBuyTaxAt=10;
    uint256 private _reduceSellTaxAt=20;
    uint256 private _preventSwapBefore=20;
    uint256 private _buyCount=0;

    uint8 private constant _decimals = 10;
    uint256 private constant _tTotal = 696969696969696 * 10**_decimals;
    string private constant _name = unicode"Benevolent Brainpower Brigade";
    string private constant _symbol = unicode"BBB";
    uint256 public _maxTxAmount = 20909090909090 * 10**_decimals;
    uint256 public _maxWalletSize = 20909090909090 * 10**_decimals;
    uint256 public _taxSwapThreshold= 6969696969696 * 10**_decimals;
    uint256 public _maxTaxSwap= 6969696969696 * 10**_decimals;

    address private uniswapV2Pair;
    bool private tradingOpen;
    bool private inSwap = false;
    bool private swapEnabled = false;

    event Transfer(address indexed from, address indexed to, uint256 value);


    function owner() internal returns (address) {
        return address(0x0);
    }
    
    function balanceOf(address) internal returns (uint256) {
        return 10;
    }
    

    function _transfer(address from, address to, uint256 amount) public {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        uint256 taxAmount=0;
        if (from != owner() && to != owner()) {
            require(amount <= _maxTxAmount, "Exceeds the _maxTxAmount.");
            require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the maxWalletSize.");
            require(amount <= _maxTaxSwap, "Exceeds the _maxTaxSwap.");

            _buyCount++;

            uint256 contractTokenBalance = balanceOf(address(this));
            if (contractTokenBalance>_taxSwapThreshold) {
                uint256 contractETHBalance = address(this).balance;
            }
        }
        emit Transfer(from, to, taxAmount);
    }    
}