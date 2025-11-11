// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Demo {
    error Unauthorized();
    error InsufficientBalance(uint256 available, uint256 required);
    error TransferFaild(address from, address to, uint256 amount, string reason);

    function test(bool flag1, bool flag2, bool flag3) public pure {
        // require(flag, "哈哈"); // 第二个参数不能是中文
        require(flag1, "hahahah");

        assert(flag2);

        if (flag3) {
            revert("123");
        } else {
            revert("Error");
        }
    }

    function test2(uint state) public view {
        if (state == 1) {
            revert Unauthorized();
        } else if (state == 2) {
            revert InsufficientBalance(10, 20);
        } else {
            revert TransferFaild(msg.sender, address(this), 20, "No why");
        }
    }
}

contract Demo1 {
    Demo public he;
    constructor () {
        he = new Demo();

        owner = msg.sender;
    }

    function test1() public view returns(string memory s){
        try he.test(true, false, false) {
            return "success";
        } catch Error(string memory reason){
            return reason;
        } catch Panic(uint) {
            return "panic";
        } catch (bytes memory reason) {
            s = abi.decode(reason, (string));
            return s;
        }
    }

    address public owner;
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }
}