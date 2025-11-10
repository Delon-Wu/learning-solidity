// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract ReverseString {
    function reverse(string memory str) public pure returns (string memory) {
        bytes memory bs = bytes(str);
        uint256 len = bs.length;
        require(len > 0, "Error");
        bytes1 b = bs[0];
        uint256 i; 
        uint256 j = len - 1; 
        while (i < j) {
            bs[i] = bs[j];
            bs[j] = b;
            b = bs[i+1];
            i++;
            j--;
        }
        return string(bs);
    }
}