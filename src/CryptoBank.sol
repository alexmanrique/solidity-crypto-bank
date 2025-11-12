// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract CryptoBank {
    mapping(address => uint256) private balances;

    address public admin;
    uint256 public maxBalance;

    constructor(address _admin, uint256 _maxBalance) {
        maxBalance = _maxBalance;
        admin = _admin;
    }

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this function");
        _;
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        require(balances[msg.sender] + msg.value <= maxBalance, "Deposit amount exceeds max balance");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount_) public {
        require(amount_ > 0, "Withdraw amount must be greater than zero");
        require(balances[msg.sender] >= amount_, "Insufficient balance");
        balances[msg.sender] -= amount_;
        (bool success,) = msg.sender.call{value: amount_}(""); // RECEIVE
        require(success, "Transfer failed");
        emit Withdraw(msg.sender, amount_);
    }

    function getUserBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function setMaxBalance(uint256 _maxBalance) public onlyAdmin {
        maxBalance = _maxBalance;
    } 
}