pragma solidity ^0.8.0;

contract PumpNfto {
    uint32 public gStartsAt;
    uint32 public gEndsAt;
    uint32 public fcfsStartsAt;
    uint32 public fcfsEndsAt;
    uint32 public publicStartsAt;
    uint32 public publicEndsAt = type(uint32).max;

    constructor(
        uint32 _gStartsAt,
        uint32 _gEndsAt,
        uint32 _fcfsStartsAt,
        uint32 _fcfsEndsAt,
        uint32 _publicStartsAt
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

        if (block.timestamp >= publicStartsAt && block.timestamp <= publicEndsAt) {
            return 3;
        }

        return 0;
    }
}