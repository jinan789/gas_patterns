pragma solidity ^0.8.0;

contract OperaBaseTokenTaxed{
    mapping(address => mapping(address => uint256)) _allowances;
    uint256 public _totalSupply;
    mapping(address => uint256) _balances;

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool) {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        return _transferFrom(sender, recipient, amount);
    }

    function _transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) internal returns (bool) {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender] - amount;

        _balances[recipient] = _balances[recipient] + amount;

        return true;
    }
}