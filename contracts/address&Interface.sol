// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Address {
    address public myAddress;
    // address public caller = msg.sender;

    // function test1() public view returns (bool, bytes memory){
    //     return (msg.sender == caller, abi.encodePacked(caller));
    // }

    // function test2(address addr1, address payable addr2) public payable returns (uint256) {
    function test2(address addr1) public payable returns (uint256) {
        return (
            addr1.balance
        );
    }

    function sendEther(address payable recipient) public payable {
        // payable(addr);
        recipient.transfer(msg.value);
    }

    function add(uint a, uint b) public pure returns(uint) {
        return a + b;
    }

    function callContract(address addr, bytes memory data) public returns (bool, bytes memory) {
        (bool success, bytes memory result) = addr.call(data); // call 便于调用其他合约的函数，配合abi.encodeWithSignature生成data使用, 
        return (success, result);
    }
}

// interface IERC20 {
//     function transfer(address from, address to) external returns (bool);
//     function balanceOf(address account) external returns (uint256);
// }

// contract ERC20 is IERC20 {
//     function transfer(address to, uint256 amount) external returns (bool) {
//         return false;
//     }
//     function balanceOf(address account) external pure returns (uint256) {
//         return 1;
//     }
// }

interface IBank {
    function deposit() external payable;
    function withdraw(uint256 amount) external;
    function getBalance() external view returns(uint256);
}

contract Bank is IBank {
    mapping(address account => uint256 balance) public balances;
    function deposit() external payable {
        require(msg.value > 0, "deposit amount must greater than 0");
        balances[msg.sender] += msg.value;
    }
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Balance not enough");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
    function getBalance() external view returns(uint256) {
        return balances[msg.sender];
    }
}

contract BankUser {
    function depositToBank(address bankAddress) external payable {
        IBank bank = IBank(bankAddress); // 通过IBank 接口来实例化
        bank.deposit{value: msg.value}();
    }

    receive() external payable {}
    fallback() external payable {}

    function withdrawFromBank(address bankAddress, uint256 amount) external {
        IBank bank = IBank(bankAddress);
        bank.withdraw(amount);
    }

    function getBalance(address bankAddress) external view returns(uint256) {
        IBank bank = IBank(bankAddress);
        return bank.getBalance();
    }
}