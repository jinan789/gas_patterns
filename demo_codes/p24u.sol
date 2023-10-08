pragma solidity ^0.8.0;

contract ExampleContract  {
    uint x = 1;
    uint y = 2;

    function exampleFunction(uint k) public returns (uint256 amountOut) {
        uint sum = 0;
        for ( uint i = 1 ; i <= k ; i++) {
            sum = sum + x + y;
        }
        return sum;
    }
}