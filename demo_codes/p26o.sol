pragma solidity ^0.8.0;

contract CreditDAO  {
    struct Election {
        address maxVotes;
        uint nextCandidateIndex;
        mapping(address => bool) candidates;
        mapping(address => bool) userHasVoted;
        mapping(uint => uint) candidateVotes;
        
        uint idProcessed;
    }

    uint numMaxVotes;
    uint public nextEId;
    mapping(uint => Election) public elections;

    constructor() public {
        nextEId ++;
    }

    function submitForElection() public {
        elections[nextEId - 1].nextCandidateIndex ++;
        elections[nextEId - 1].candidates[msg.sender] = true;
    }

    function vote(uint candidateId) public {
        elections[nextEId - 1].candidateVotes[candidateId] += 1;
        elections[nextEId - 1].userHasVoted[msg.sender] = true;
    }

    function finishElections(uint _iterations) public {
        uint currentVotes;
        Election storage election = elections[nextEId - 1];
        uint nextId = election.idProcessed;

        for (uint cnt = 0; cnt < _iterations; cnt++) {
            currentVotes = election.candidateVotes[nextId];
            if (currentVotes > numMaxVotes) {
                numMaxVotes = currentVotes;
            }
            nextId++;
        }
        election.idProcessed = nextId;
    }
}