pragma solidity ^0.8.0;

contract VoteForLaunch {
    uint32 public MAX_VOTING_DAYS = 10 * 24 * 3600;
    mapping(string => bool) public reservedTicks;     // check if tick is occupied
    event NewApplication(string tick, address applicant, uint40 expireAt, string cid, uint128 deposit);

    function newVote(string memory _tick, uint40 _expireSeconds, string memory _cid) public {
        require(_expireSeconds <= MAX_VOTING_DAYS, "more than max days to vote");
        require(!reservedTicks[_tick], "reserved ticks can not apply");

        emit NewApplication(_tick, msg.sender, uint40(block.timestamp + _expireSeconds), _cid, 10);
    }
}