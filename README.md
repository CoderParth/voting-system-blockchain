# Decentralized Voting System - Blockchain

This repository contains the blockchain part of a simple decentralized voting system. It utilizes the Solidity programming language to create smart contracts that facilitate the voting process, while the frontend is managed in a separate repository found [here](https://github.com/CoderParth/voting-system-web3). The smart contracts are deployed on the Sepolia testnets via Truffle, a development environment, testing framework, and asset pipeline for Ethereum.

## Getting Started

### Prerequisites

**Create a Metamask Account**:
Create a free account on [Metamask](https://metamask.io/). After creating and securing your account, navigate to the "Settings" -> "Security & Privacy" -> "Reveal Seed Phrase" to find your mnemonic.

**Install Truffle**:
Truffle is utilized for deploying the smart contracts onto the Ethereum blockchain.

```bash
npm install -g truffle
```

### Install Ganache (Optional):

Ganache is a personal blockchain for Ethereum development that you can use to deploy contracts, develop your applications, and run tests.

- Download and install Ganache from the [official website](https://www.trufflesuite.com/ganache).

### Environment Variables:

You'll need to create a `.env` file in the root of your project with the following variables:

```env
INFURA_API_KEY=your_infura_api_key
MNEMONIC=your_mnemonic
```

### Configuration

The `truffle-config.js` file is crucial for specifying the network and compiler configurations. In this project, the smart contracts are deployed on the Sepolia testnets. The configuration file also specifies the version of the Solidity compiler to use, which in this case is version `0.8.21`.

### Installation

**Clone the Repository**:

```bash
git clone https://github.com/CoderParth/voting-system-blockchain.git
```

```bash
cd voting-system-blockchain
```

```bash
npm install
```

**Deployment**:
Before deploying the smart contracts onto the Sepolia testnets, ensure you have compiled the smart contracts and run migrations:

1. **Compile Smart Contracts**:

```bash
truffle compile
```

2. **Test**:

```bash
truffle test
```

3. **Deploy to Sepolia network**:

```bash
truffle migrate --network sepolia
```
