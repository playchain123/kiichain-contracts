// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GETStaking {
    IERC20 public getToken;
    uint256 public rewardRate = 100; // Example reward rate
    mapping(address => uint256) public stakedAmounts;
    mapping(address => uint256) public rewardBalances;

    constructor(address _getToken) {
        getToken = IERC20(_getToken);
    }

    function stake(uint256 amount) external {
        require(amount > 0, "Cannot stake 0 tokens");
        getToken.transferFrom(msg.sender, address(this), amount);
        stakedAmounts[msg.sender] += amount;
    }

    function unstake(uint256 amount) external {
        require(stakedAmounts[msg.sender] >= amount, "Insufficient staked amount");
        stakedAmounts[msg.sender] -= amount;
        getToken.transfer(msg.sender, amount);
    }

    function claimRewards() external {
        uint256 reward = stakedAmounts[msg.sender] * rewardRate / 1000;
        rewardBalances[msg.sender] += reward;
        getToken.transfer(msg.sender, reward);
    }

    function getStakedAmount(address staker) external view returns (uint256) {
        return stakedAmounts[staker];
    }

    function getRewardBalance(address staker) external view returns (uint256) {
        return rewardBalances[staker];
    }
}

