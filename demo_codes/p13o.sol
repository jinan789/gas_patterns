pragma solidity ^0.8.0;

contract DoughImplementationM1 {
    mapping (address => bool) internal _auth;
    address internal immutable doughIndex = address(0x0);

    function isConnectors(string[] calldata) internal returns (bool) {
        return false;
    }

    function cast(
        string[] calldata _targetNames,
        bytes[] calldata _datas,
        address _origin
    )
    public
    payable 
    returns (bytes32) // Dummy return to fix doughIndex buildWithCast function
    {   
        uint256 _length = _targetNames.length;
        require(_auth[msg.sender] || msg.sender != doughIndex, "1: permission-denied");
        require(_length != 0, "1: length-invalid");
        require(_length == _datas.length , "1: array-length-invalid");

        bool isOk = isConnectors(_targetNames);
        require(isOk, "1: not-connector");

        string[] memory eventNames = new string[](_length);
        bytes[] memory eventParams = new bytes[](_length);
    }
}