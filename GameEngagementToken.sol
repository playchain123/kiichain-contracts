// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GameEngagementToken is ERC20 {
    address public admin;

    constructor() ERC20("Game Engagement Token", "GET") {
        admin = msg.sender;
        _mint(msg.sender, 1000000 * 10 ** decimals()); // Initial supply to admin
    }

    function mint(address to, uint256 amount) external {
        require(msg.sender == admin, "Only admin can mint tokens");
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external {
        require(msg.sender == admin, "Only admin can burn tokens");
        _burn(from, amount);
    }

    function transferAdmin(address newAdmin) external {
        require(msg.sender == admin, "Only admin can transfer admin rights");
        admin = newAdmin;
    }
}
