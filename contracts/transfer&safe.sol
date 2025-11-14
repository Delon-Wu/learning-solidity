// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Demo {
    event Receive(address sender, uint amount);
    receive() external payable {
        emit Receive(msg.sender, msg.value);
    }

    event FallbackCalled(address sender, uint amount, bytes data);
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }
}