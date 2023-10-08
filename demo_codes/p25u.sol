pragma solidity ^0.8.0;

contract ExampleContract  {
    uint sum = 0;
    function exampleFunction(uint x) public returns (uint256 amountOut) {
        for ( uint i = 1 ; i <= x ; i++) {
            sum += i;
        }
        return sum;
    }
}