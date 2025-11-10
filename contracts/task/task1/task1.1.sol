// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Voting {
    mapping(address candidate => uint256 votes) public votesReceived;
    address[] public candidates;
    
    function vote(address candidate) public {
        if (votesReceived[candidate] == 0) {
            candidates.push(candidate);
        }
        votesReceived[candidate]++;
    }

    function getVotes(address candidate) public view returns (uint256) {
        return votesReceived[candidate];
    }
    
    function resetVotes() public {
        for (uint i = 0; i < candidates.length; i++) {
            votesReceived[candidates[i]] = 0;
        }
    }
}
