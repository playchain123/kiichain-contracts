// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract GameDataOracle {
    AggregatorV3Interface internal dataFeed;
    IERC20 public rewardToken; // Token used for rewards
    address public admin;

    constructor(address _oracle, address _rewardToken) {
        dataFeed = AggregatorV3Interface(_oracle);
        rewardToken = IERC20(_rewardToken);
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    function getGameData() public view returns (int) {
        (
            uint80 roundID, 
            int data,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = dataFeed.latestRoundData();
        return data;
    }

    function distributeRewards(address player, uint256 multiplier) external onlyAdmin {
        // Fetch the game data using the oracle
        int gameData = getGameData();
        
        require(gameData > 0, "Invalid game data");

        // Convert gameData to a uint256 for reward calculation (ignoring decimals)
        uint256 rewardAmount = uint256(gameData) * multiplier;

        // Check if the contract has enough tokens to distribute
        uint256 contractBalance = rewardToken.balanceOf(address(this));
        require(contractBalance >= rewardAmount, "Insufficient reward tokens in contract");

        // Transfer the calculated reward to the player
        rewardToken.transfer(player, rewardAmount);
    }

    function depositRewards(uint256 amount) external onlyAdmin {
        require(amount > 0, "Cannot deposit 0 tokens");
        rewardToken.transferFrom(msg.sender, address(this), amount);
    }

    function withdrawRewards(uint256 amount) external onlyAdmin {
        require(amount > 0, "Cannot withdraw 0 tokens");
        require(rewardToken.balanceOf(address(this)) >= amount, "Insufficient balance");
        rewardToken.transfer(admin, amount);
    }
}
