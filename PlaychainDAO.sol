// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract PlaychainDAO {
    IERC20 public getToken;
    uint256 public proposalCount;

    struct Proposal {
        uint256 id;
        string description;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 deadline;
        address proposer;
        bool executed;
    }

    mapping(uint256 => Proposal) public proposals;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    constructor(address _getToken) {
        getToken = IERC20(_getToken);
    }

    function createProposal(string memory description) external {
        proposals[proposalCount++] = Proposal({
            id: proposalCount,
            description: description,
            votesFor: 0,
            votesAgainst: 0,
            deadline: block.timestamp + 7 days,
            proposer: msg.sender,
            executed: false
        });
    }

    function vote(uint256 proposalId, bool support) external {
        require(block.timestamp < proposals[proposalId].deadline, "Voting period has ended");
        require(!hasVoted[proposalId][msg.sender], "Already voted");

        uint256 voterWeight = getToken.balanceOf(msg.sender);
        require(voterWeight > 0, "No voting power");

        if (support) {
            proposals[proposalId].votesFor += voterWeight;
        } else {
            proposals[proposalId].votesAgainst += voterWeight;
        }

        hasVoted[proposalId][msg.sender] = true;
    }

    function executeProposal(uint256 proposalId) external {
        Proposal storage proposal = proposals[proposalId];
        require(block.timestamp >= proposal.deadline, "Voting period not over");
        require(!proposal.executed, "Proposal already executed");

        if (proposal.votesFor > proposal.votesAgainst) {
            proposal.executed = true;
        }
    }
}

