// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Demo {
    event Receive(address sender, uint amount);

    receive() external payable  {
        emit Receive(msg.sender, msg.value);
    }

    event FallbackCalled(address sender, uint amount, bytes data, uint state);

    function getSig(bool flag) external pure returns(bytes4) {
        if (flag) {
            revert();
        }
        return msg.sig;
    }

    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data, 1);
    }
}

contract GetSig {
    function getSig() external pure returns(bytes4) {
        return msg.sig;
    }
}

contract Bank {
    event CallLog(bytes input, bytes output);
    receive() external payable {}

    function withdrawWithTransfer() external {
        payable(msg.sender).transfer(1 ether);
    }

    function withdrawWithSend() external {
        bool success = payable(msg.sender).send(1 ether);
        require(success, "Send failed");
    }

    function withdrawWithCall(bytes memory input) external {
        (bool success, bytes memory data) = payable(msg.sender).call{value: 1 ether}("");
        require(success, "Call failed");
        emit CallLog(input, data);
    }
}

contract BankUser {
    Bank bank;
    constructor() {
        bank = new Bank();
    }
    receive() external payable {}
    function withdrawWithTransfer() external {
        bank.withdrawWithTransfer();
    }

    function withdrawWithSend() external {
        bank.withdrawWithSend();
    }

    function withdrawWithCall(bytes memory input) external {
        bank.withdrawWithCall(abi.encodePacked(input));
    }

    function testPay() external payable {

    }
}

// 重入攻击
// 可用openzeppelin的工具来预防