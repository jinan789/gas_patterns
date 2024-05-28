pragma solidity ^0.8.0;

contract VoteForLaunch {
    uint32 public MAX_VOTING_DAYS = 10 * 24 * 3600;
    mapping(bytes32 => bool) public reservedTicks;     // check if tick is occupied
    event NewApplication(bytes32 tick, address applicant, uint40 expireAt, bytes32 cid, uint128 deposit);

    function newVote(bytes32 _tick, uint40 _expireSeconds, bytes32 _cid) public {
        require(_expireSeconds <= MAX_VOTING_DAYS, "more than max days to vote");
        require(!reservedTicks[_tick], "reserved ticks can not apply");

        emit NewApplication(_tick, msg.sender, uint40(block.timestamp + _expireSeconds), _cid, 10);
    }
}