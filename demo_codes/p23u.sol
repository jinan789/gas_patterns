pragma solidity ^0.8.0;

contract ExampleContract {

    struct Struct {
        uint mem1 ; 
        address mem2 ;
        uint mem3 ;
        bool mem4 ;
    }

    Struct public data ;

    function setData () internal {
        data = Struct (1 , address (0) , 1 , true ) ;
    }

    function getData () internal returns (Struct memory) {
        return data ;
    }

    function exampleFunction() public returns  (Struct memory) {
        setData();
        return getData();
    }
}