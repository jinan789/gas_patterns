pragma solidity ^0.8.0;

contract KSElasticLMV2 {
    event WithdrawUnusedRewards(
        address token,
        uint256 amount,
        address receiver
    );

    function withdrawUnusedRewards(
        address[] calldata tokens,
        uint256[] calldata amounts
    ) external {
        uint256 rewardTokenLength = tokens.length;
        for (uint256 i; i < rewardTokenLength; ) {
            emit WithdrawUnusedRewards(tokens[i], amounts[i], msg.sender);

            unchecked {
                ++i;
            }
        }
    }
}
