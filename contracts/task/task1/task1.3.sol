// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Task1dot3 {
    mapping(string b => uint256 v) public romanMap;
    constructor() {
        romanMap["I"] = 1;
        romanMap["V"] = 5;
        romanMap["X"] = 10;
        romanMap["L"] = 50;
        romanMap["C"] = 100;
        romanMap["D"] = 500;
        romanMap["M"] = 1000;
    }
    function romanToInt(string calldata romanStr) public view returns (uint256 num) {
        bytes memory bs = bytes(romanStr);
        for (uint256 i = 0; i < bs.length; i++) {
            uint256 current = romanMap[string(abi.encodePacked(bs[i]))];
            if (i == bs.length - 1) {
                num += current;
            } else {
                uint256 next = romanMap[string(abi.encodePacked(bs[i + 1]))];
                if (current < next) {
                    num = num + next - current;
                    i++;
                } else {
                    num += current;
                }
            }
        }
        return num;
    }
}