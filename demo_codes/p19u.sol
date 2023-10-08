pragma solidity ^0.8.0;

contract ExampleContract {
    function exampleFunction(uint x) public returns (uint256) {
        if ( x > 5) {
            if ( x*x < 20) {
                return 5 * x; 
            }
            else {
                return 4 * x;
            } 
        }
        else {
            return x;
        }
    }
    
}