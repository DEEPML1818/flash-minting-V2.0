// SPDX-License-Identifier: MIT

pragma solidity >=0.6.6 <0.9.0;

import {FlashLoanSimpleReceiverBase} from "@aave/core-v3/contracts/flashloan/base/FlashLoanSimpleReceiverBase.sol";
import {IPoolAddressesProvider} from "@aave/core-v3/contracts/interfaces/IPoolAddressesProvider.sol";
import {IPool} from "@aave/core-v3/contracts/interfaces/IPool.sol";

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {IJoeRouter02} from "@traderjoe-xyz/core/contracts/traderjoe/interfaces/IJoeRouter02.sol";

import {IPangolinRouter} from "@pangolindex/exchange-contracts/contracts/pangolin-periphery/interfaces/IPangolinRouter.sol";

import "hardhat/console.sol";
import "./interfaces/IFlashMinter.sol";


contract FlashMinter is IFlashMinter {
    uint256 public totalBorrowed;
    address private immutable _controller;

    constructor() {
        _controller = msg.sender;
    }

    function onFlashMint(
        address sender,
        uint256 amount,
        bytes calldata data
    ) external override {
        require(sender == _controller);
        totalBorrowed += amount;
    }
}
