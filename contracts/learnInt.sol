// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearnInt {
    function test() public pure returns (uint8 a, uint b) {
        a = 0;
        b = 255;
        return (a - 1, b + 1);
    }
}
