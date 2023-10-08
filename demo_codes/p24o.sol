pragma solidity ^0.8.0;

contract ExampleContract  {
    uint x = 1;
    uint y = 2;

    function exampleFunction(uint k) public returns (uint256 amountOut) {
        uint sum = 0;
        uint s = x + y;
        for ( uint i = 1 ; i <= k ; i++) {
            sum = sum + s;
        }
        return sum;
    }
}