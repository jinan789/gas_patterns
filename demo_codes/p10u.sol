pragma solidity ^0.8.0;

contract Donate3  {
    function _transferToken(
        address token,
        address from,
        uint256 amountInDesired,
        address rAddress,
        bytes calldata merkleProof
    ) internal returns (uint256 amountOut) {
        return 1;
    }

    function donateERC20(
        address _token,
        string calldata _tokenSymbol,
        uint256 _amountInDesired,
        address _to,
        bytes calldata _message,
        bytes calldata _merkleProof
    ) external {
        address from = msg.sender;
        string calldata symbol = _tokenSymbol;
        bytes calldata message = _message;
        address token = _token;
        bytes calldata merkleProof = _merkleProof;
        uint256 amountInDesired = _amountInDesired;

        address to = _to;
        require(from != to, "The donor address is equal to receive");

        uint256 amountOut = _transferToken(
            token,
            from,
            amountInDesired,
            to,
            merkleProof
        );
    }
}