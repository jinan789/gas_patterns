pragma solidity ^0.8.0;

contract UNCX_ProofOfReservesV2_UniV3 {
    event onRemoveFee(bytes32);
    function contains (bytes32) internal returns (bool) {
        return true;
    }

    function remove (bytes32) internal returns (bool) {
        return true;
    }

    function removeFee (string memory _name) external {
        bytes32 nameHash = keccak256(abi.encodePacked(_name));
        require(nameHash != keccak256(abi.encodePacked("DEFAULT")), "DEFAULT");
        require(contains(nameHash));
        remove(nameHash);
        emit onRemoveFee(nameHash);
    }
}