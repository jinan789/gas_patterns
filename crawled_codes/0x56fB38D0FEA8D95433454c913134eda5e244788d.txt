// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

// is MarkExchangeInput.

import "./MarkExchangeInput.sol";

contract MarkExchangeRouter is MarkExchangeInput {
    /**
     * @notice Entry point for futureverse exchange
     *
     */
    constructor(
        IMatchCriteriaRouter _matchCriteriaRouter,
        address _oracle,
        uint _blockRange,
        uint256 _maxPlatformFeeRate
    ) MarkExchangeInput(
        _matchCriteriaRouter,
        _oracle,
        _blockRange,
        _maxPlatformFeeRate
    ) {}


}