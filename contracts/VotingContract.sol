// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingContract {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    struct Voter {
        string name;
        string voterId; // 8-digit unique string for each voter
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => Voter) public voters;
    mapping(address => bool) public hasVoted;

    uint public candidatesCount;
    uint public totalVoters = 0;

    // Voted event
    event votedEvent(uint indexed _candidateId, address indexed _voter);

    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId, string memory _name, string memory _voterId) public {
        // Require that the voter hasn't voted before
        require(!hasVoted[msg.sender], "You have already voted.");

        // Store voter details
        voters[msg.sender] = Voter(_name, _voterId);
        
        // Record that the voter has voted
        hasVoted[msg.sender] = true;
        totalVoters++;

        // Update candidate vote count
        candidates[_candidateId].voteCount++;

        // Trigger voted event
        emit votedEvent(_candidateId, msg.sender);
    }

    function getCandidate(uint _candidateId) public view returns (uint, string memory, uint) {
        return (candidates[_candidateId].id, candidates[_candidateId].name, candidates[_candidateId].voteCount);
    }

    function getTotalVoters() public view returns (uint) {
        return totalVoters;
    }
}
