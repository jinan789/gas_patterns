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
        require(nameHash != 0x9F28225C7D0ACE67FA2516BD7725F3949E9A591DE0EAE9DB822B2CB79F38A6B0, "DEFAULT");
        require(contains(nameHash));
        remove(nameHash);
        emit onRemoveFee(nameHash);
    }
}