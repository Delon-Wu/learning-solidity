// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Task1dot3 {
    uint[] values;
    string[] symbols;
    constructor() {
        values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"];
    }
    function intToRoman(uint256 num) public view returns (string memory) {
        string memory romanNum = "";
        for (uint i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                num -= values[i];
                romanNum = string.concat(romanNum, symbols[i]);
            }
        }
       
        return romanNum;
    }
}