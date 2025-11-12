// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "contracts/array.sol"; // 本地导入
import "@openzeppelin/contracts/token/ERC20/ERC20.sol"; // 远程导入

import {LearningLoop as Demo1} from "contracts/loop.sol"; // 导入时重命名
// import "./task/task1/*"; // ???

contract MyToken is ERC20 {
    constructor() ERC20("MyToken", "MTK") {
        // super.constructor();
    }
}

contract Parent {
    function foo() public pure virtual returns (string memory) {
        return "Parent";
    }
}

contract Child is Parent {
    function foo() public pure virtual override returns (string memory) {
        return "Child";
    }
}

contract Ownerable {
    address public owner;
    constructor() {
        owner = msg.sender;
    }
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner");
        _;
    }
}

contract MyContract is ERC20, Ownerable {

    constructor() ERC20("MyContract", "MC") {
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function test(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}