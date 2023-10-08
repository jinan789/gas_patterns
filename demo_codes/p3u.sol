pragma solidity ^0.8.0;

contract PumpNft {
    uint256 public gStartsAt;
    uint256 public gEndsAt;
    uint256 public fcfsStartsAt;
    uint256 public fcfsEndsAt;
    uint256 public publicStartsAt;
    uint256 public publicEndsAt = type(uint256).max;

    constructor(
        uint256 _gStartsAt,
        uint256 _gEndsAt,
        uint256 _fcfsStartsAt,
        uint256 _fcfsEndsAt,
        uint256 _publicStartsAt
    ) {
        gStartsAt = _gStartsAt;
        gEndsAt = _gEndsAt;
        fcfsStartsAt = _fcfsStartsAt;
        fcfsEndsAt = _fcfsEndsAt;
        publicStartsAt = _publicStartsAt;
    }

    function currentStage() public returns (uint256 stage) {
        if (block.timestamp >= gStartsAt && block.timestamp <= gEndsAt) {
            return 1;
        }

        if (block.timestamp >= fcfsStartsAt && block.timestamp <= fcfsEndsAt) {
            return 2;
        }

        if (
            block.timestamp >= publicStartsAt && block.timestamp <= publicEndsAt
        ) {
            return 3;
        }

        return 0;
    }
}