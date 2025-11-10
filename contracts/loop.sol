// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LearningLoop {
    function test1() public pure returns(uint) {
        uint sum = 0;
        for(uint i; i < 10; i++) {
            sum += i;
            if (i == 5) {
                break;
            }
        }
        for(uint i = 2;;) {
            i++;
            sum--;
            if (i == 5) break;
        }
        return sum;
    }

    function test2() public pure returns (uint) {
        uint sum = 0;
        uint i = 0;
        do {
            sum += 2;
            i++;
        } while (i < 10);

        while (i > 0) {
            i--;
            sum -= 2;
        }
        return sum;
    }
}