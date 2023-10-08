pragma solidity ^0.8.0;

contract ExampleContract  {
    uint sum = 0;
    function exampleFunction(uint x) public returns (uint256 amountOut) {
        uint tmp = sum;
        for ( uint i = 1 ; i <= x ; i++) {
            tmp += i;
        }
        sum = tmp;
        return tmp;
    }
}