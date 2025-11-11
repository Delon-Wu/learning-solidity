// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Address {
    address public myAddress;
    address public caller = msg.sender;

    function test1() public view returns (bool, bytes memory){
        return (msg.sender == caller, abi.encodePacked(caller));
    }

    function test2(address addr1, address payable addr2) public payable returns (uint256) {
        // payable(addr2);
        addr2.transfer(msg.value);
        return (
            addr1.balance
        );
    }
}
