// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingNote {
    mapping(address => uint) public myMapping;
    // 语义化
    mapping(address account => uint amount) public myMapping1;

    mapping(string commpany => mapping(uint8 employeeID => address account)) public commpanyAccountMap;
    function setMapping1(address addr1, uint value) public {
        // mapping(address account => uint amount) public myMapping21; // 不能在函数中声明
        myMapping[addr1] = value;
    }

    // 不能作为入参、出参。
    // function test(mapping(address => uint) memory m) public returns(mapping(address => uint)) {
    // }

    function setMapping2(string memory commpanyCode, uint8 employeeID, address account) public {
        commpanyAccountMap[commpanyCode][employeeID] = account;
    }

    function testDelete(address key, string memory commpanyCode, uint8 employeeID) public {
        delete myMapping[key];
        delete commpanyAccountMap[commpanyCode][employeeID];
    }

}