pragma solidity ^0.8.0;

contract presale {
    address public presale_owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    modifier owner {
        require(msg.sender == presale_owner, "Requires owner");
        _;
    }

    function updateRatePresale(uint256 _rate, uint256 _rateStable) external owner {
        uint256 ratePresale; //listing price in wei
        uint256 ratePresaleStable;

        ratePresale = _rate;
        ratePresaleStable = _rateStable;
    }
}