# CryptoBank

A decentralized bank smart contract built with Solidity that allows users to securely deposit and withdraw ETH.

## Description

CryptoBank is a smart contract that implements a basic banking system on the Ethereum blockchain. Users can deposit ETH into the contract and withdraw their funds whenever they want, with a configurable maximum balance limit per user.

## Features

- **Deposits**: Users can deposit ETH into the contract
- **Withdrawals**: Users can withdraw their deposited funds
- **Balance Limit**: Control of the maximum balance allowed per user
- **Access Control**: Protected administrative functions
- **Events**: Emission of events for deposits and withdrawals to facilitate tracking

## Main Functionality

### For Users

- `deposit()`: Deposits ETH into the contract
- `withdraw(uint256 amount)`: Withdraws a specific amount of ETH
- `getUserBalance()`: Queries the current balance of the user

### For Administrator

- `setMaxBalance(uint256 _maxBalance)`: Sets the maximum balance allowed per user

## Security Requirements

- Deposits must be greater than zero
- Withdrawals cannot exceed available balance
- A user's total balance cannot exceed the configured `maxBalance`
- Only the administrator can modify the `maxBalance`

## Technology

This project uses **Foundry**, a fast and modular toolkit for Ethereum application development written in Rust.

Foundry includes:

- **Forge**: Ethereum testing framework
- **Cast**: Tool for interacting with EVM contracts
- **Anvil**: Local Ethereum node
- **Chisel**: Solidity REPL

## Foundry Documentation

https://book.getfoundry.sh/

## Installation

```shell
# Install dependencies
$ forge install

# Build the contract
$ forge build
```

## Testing

```shell
# Run all tests
$ forge test

# Run tests with more details
$ forge test -vvv
```

Tests cover:

- Successful deposits
- Successful withdrawals
- Validation of deposits with zero amount
- Validation of deposits exceeding maximum balance
- Validation of withdrawals with insufficient balance
- Validation of withdrawals with zero amount

## Formatting

```shell
$ forge fmt
```

## Gas Snapshots

```shell
$ forge snapshot
```

## Local Development

```shell
# Start a local Ethereum node
$ anvil
```

## Deployment

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

## Project Structure

```
solidity-crypto-bank/
├── src/
│   └── CryptoBank.sol      # Main contract
├── test/
│   └── CryptoBankTest.t.sol # Contract tests
└── foundry.toml            # Foundry configuration
```

## License

UNLICENSED
