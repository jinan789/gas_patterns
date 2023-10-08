pragma solidity ^0.8.18;

contract InitialFairOffering {
    function addLiquidity(uint16 slippage) public {
        uint256 balanceOfWeth = 100;
        uint256 liquidityEtherPercent = 200;
        uint256 maxRollups = 300;
        uint256 fundingCommission = 400;
        uint256 crowdFundingRate = 500;

        
        require(slippage <= 10000, "slippage error");

        // Send ether back to deployer, the eth liquidity is based on the balance of this contract. So, anyone can send eth to this contract
        uint256 backToDeployAmount = (balanceOfWeth *
            (10000 - liquidityEtherPercent)) / 10000;
        uint256 maxBackToDeployAmount = (maxRollups *
            (10000 - fundingCommission) *
            crowdFundingRate *
            (10000 - liquidityEtherPercent)) / 100000000;

    }
}