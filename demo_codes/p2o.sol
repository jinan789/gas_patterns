pragma solidity ^0.8.13;
error OperatorNotAllowed(address a);

contract IOperatorFilterRegistry {
    function isOperatorAllowed(address a, address b) public returns (bool) {
        return true;
    }
}

contract HolographDropERC721 {
    IOperatorFilterRegistry public openseaOperatorFilterRegistry =
        new IOperatorFilterRegistry();

    function beforeTransferNew(
        address _from,
        address, /* _to*/
        uint256, /* _tokenId*/
        bytes calldata /* _data*/
    ) internal returns (bool) {
        if (
            _from != address(0) && // skip on mints
            _from != msgSender() // skip on transfers from sender
        ) {
            bool osRegistryEnabled;
            assembly {
                osRegistryEnabled := sload(osRegistryEnabled)
            }
            if (osRegistryEnabled) {
                try
                    openseaOperatorFilterRegistry.isOperatorAllowed(
                        address(this),
                        msgSender()
                    )
                returns (bool allowed) {
                    return allowed;
                } catch {
                    revert OperatorNotAllowed(msgSender());
                }
            }
        }
        return true;
    }

    function msgSender() public returns (address) {
        return address(this);
    }

    function beforeSafeTransfer(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes calldata _data
    ) external returns (bool) {
        return beforeTransferNew(_from, _to, _tokenId, _data);
    }

    function beforeTransfer(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes calldata _data
    ) external returns (bool) {
        return beforeTransferNew(_from, _to, _tokenId, _data);
    }
}