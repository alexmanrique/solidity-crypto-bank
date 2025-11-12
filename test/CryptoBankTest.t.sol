// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../src/CryptoBank.sol"; 

contract CryptoBankTest is Test {
    CryptoBank public cryptoBank;
    address public user1 = address(0x1);
    address public user2 = address(0x2);
    uint256 public maxBalance = 5 ether;
    address public admin = address(0x3);

    function setUp() public {
        cryptoBank = new CryptoBank(admin, maxBalance);
    }

    function testDepositSuccess() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        cryptoBank.deposit{value: 0.5 ether}();
        uint256 balance = cryptoBank.getUserBalance();
        assertEq(balance, 0.5 ether);
        vm.stopPrank();
    }

    function testDepositFailureWithZeroAmount() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        vm.expectRevert("Deposit amount must be greater than zero");
        cryptoBank.deposit{value: 0}();
        vm.stopPrank();
    }

    function testDepositFailureWithExceedingMaxBalance() public {
        vm.deal(user1, 6 ether);
        vm.startPrank(user1);
        vm.expectRevert("Deposit amount exceeds max balance");
        cryptoBank.deposit{value: 6 ether}();
        vm.stopPrank();
    }

    function testWithdrawSuccess() public {
        vm.deal(user1, 1 ether);
        vm.startPrank(user1);
        cryptoBank.deposit{value: 0.5 ether}();
        cryptoBank.withdraw(0.3 ether);
        uint256 balance = cryptoBank.getUserBalance();
        assertEq(balance, 0.2 ether);
        vm.stopPrank();
    }

    function testWithdrawInsufficientBalance() public {
        vm.deal(user2, 1 ether);
        vm.prank(user2);
        cryptoBank.deposit{value: 0.2 ether}();

        vm.prank(user2);
        vm.expectRevert("Insufficient balance");
        cryptoBank.withdraw(0.3 ether);
        vm.stopPrank();
    }

    function testDepositZeroAmount() public {
        vm.prank(user1);
        vm.expectRevert("Deposit amount must be greater than zero");
        cryptoBank.deposit{value: 0}();
        vm.stopPrank();
    }

    function testWithdrawZeroAmount() public {
        vm.prank(user1);
        vm.expectRevert("Withdraw amount must be greater than zero");
        cryptoBank.withdraw(0);
        vm.stopPrank();
    }

}