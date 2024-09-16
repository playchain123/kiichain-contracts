# Playchain Smart Contracts

Welcome to the Playchain Smart Contracts repository. This directory contains the Solidity contracts that form the backbone of the Playchain decentralized gaming platform, enabling players to turn their in-game engagement into real-world value.

## Overview

Playchain leverages blockchain technology to create a decentralized ecosystem where players can earn, trade, and stake Game Engagement Tokens (GETs) based on their in-game performance. The contracts in this folder are designed to manage various aspects of the platform, including token minting, NFT creation, oracle data integration, staking mechanisms, and decentralized governance.

## Contracts

### 1. **GameEngagementToken.sol**
- **Description**: An ERC20 token contract that represents Game Engagement Tokens (GETs). Players earn GETs based on their in-game activities, which can then be traded, staked, or used for governance on the platform.
- **Key Functions**:
  - `mint(address to, uint256 amount)`: Mints new tokens to the specified address.
  - `burn(address from, uint256 amount)`: Burns tokens from the specified address.
  - `transferAdmin(address newAdmin)`: Transfers administrative rights to another address.
- **GameEngagementToken**: 0xDa90984a3835a5F9Dd6C0b97915a25Dd35d1c763

### 2. **CrossChainGamingNFT.sol**
- **Description**: An ERC721 NFT contract that allows the creation and transfer of gaming NFTs across multiple blockchains. These NFTs represent in-game assets that can be traded within the Playchain ecosystem.
- **Key Functions**:
  - `mint(address to, string memory _tokenURI)`: Mints a new NFT to the specified address.
  - `transferNFT(address to, uint256 tokenId)`: Transfers an existing NFT to another address.
- **CrossChainGamingNFT**: 0x6b4A01663F15664815a1bF49428Bc9D5dD025053

### 3. **GameDataOracle.sol**
- **Description**: A contract that integrates with an external oracle to fetch real-time gaming data, which is then used to calculate and distribute rewards to players based on their in-game performance.
- **Key Functions**:
  - `getGameData()`: Fetches the latest game data from the oracle.
  - `distributeRewards(address player, uint256 multiplier)`: Distributes rewards to a player based on the fetched game data and a specified multiplier.
  - `depositRewards(uint256 amount)`: Allows the admin to deposit reward tokens into the contract.
  - `withdrawRewards(uint256 amount)`: Allows the admin to withdraw tokens from the contract.
- **GameDataOracle**: 0x77488a0B44d3a46b6BDc917c8B0cA808c15df6E8

### 4. **GETStaking.sol**
- **Description**: A staking contract that allows players to stake their GET tokens and earn rewards or increase their voting power within the platform.
- **Key Functions**:
  - `stake(uint256 amount)`: Stakes a specified amount of GET tokens.
  - `unstake(uint256 amount)`: Unstakes a specified amount of GET tokens.
  - `claimRewards()`: Claims earned rewards based on staked tokens.
- **GETStaking**: 0xfFeDADD73d9E1e7A747A52624DE5E62bAe78f436

### 5. **PlaychainDAO.sol**
- **Description**: A governance contract that enables decentralized decision-making within the Playchain platform. Token holders can create proposals and vote on platform updates, new features, and game integrations.
- **Key Functions**:
  - `createProposal(string memory description)`: Creates a new governance proposal.
  - `vote(uint256 proposalId, bool support)`: Votes on an active proposal.
  - `executeProposal(uint256 proposalId)`: Executes a proposal if it passes the vote.
- **PlayChainDao**: 0xD210A39100667ceC6256087Bb63f61E0afB29D32
