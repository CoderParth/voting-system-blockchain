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
        string voterId;
    }

    mapping(uint => Candidate) public candidates;
    mapping(string => Voter) public voterDetails;
    mapping(string => bool) public hasVoted;

    uint public candidatesCount;
    uint public totalVoters = 0;

    // Voted event
    event votedEvent(uint indexed _candidateId, string _candidateName, uint _newVoteCount, address indexed _voter);

    constructor() {
        addCandidate("Yama Buddha");
        addCandidate("Uniq Poet");
        addCandidate("Balen");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId, string memory _name, string memory _voterId) public {
        require(!hasVoted[_voterId], "You have already voted.");
         voterDetails[_voterId] = Voter(_name, _voterId);
        hasVoted[_voterId] = true;
        totalVoters++;
        candidates[_candidateId].voteCount++;

        // Emitting the event with the candidate's name and the new vote count
        emit votedEvent(_candidateId, candidates[_candidateId].name, candidates[_candidateId].voteCount, msg.sender);
    }

    function getCandidate(uint _candidateId) public view returns (uint, string memory, uint) {
        return (candidates[_candidateId].id, candidates[_candidateId].name, candidates[_candidateId].voteCount);
    }

    function getTotalVoters() public view returns (uint) {
        return totalVoters;
    }

    function hasAlreadyVoted(string memory _voterId) public view returns (bool) {
        return hasVoted[_voterId];
    }

    function getCandidates() public view returns (Candidate[] memory) {
        Candidate[] memory allCandidates = new Candidate[](candidatesCount);
        for (uint i = 1; i <= candidatesCount; i++) {
            allCandidates[i-1] = candidates[i];
        }
        return allCandidates;
    }
}
