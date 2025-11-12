// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "contracts/array.sol"; // 本地导入
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // 远程导入
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol"; // 远程导入

import {LearningLoop as Demo1} from "contracts/loop.sol"; // 导入时重命名
// import "./task/task1/*"; // ???

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        // super.constructor();
    }
}

contract Parent {
    function foo() public pure virtual returns (string memory) { // 希望被子合约覆盖就使用virtual
        return "Parent";
    }
    function getAddress() public view returns (address) {
        return address(this); // 这里的this指向继承者（子合约）
    }
}

contract Child is Parent {
    function foo() public pure override returns (string memory) {
        return "Child";
    }
}

contract Ownable {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner");
        _;
    }
}

contract MyContract is ERC20, ERC20Permit, Ownable { // 继承有限度取决于这里is后的顺序
    constructor() ERC20("MyContract", "MC") ERC20Permit("MyContract") {
        _mint(msg.sender, 1000000);
    }

    // function test(address newOwner) public onlyOwner {
    //     owner = newOwner;
    // }
}