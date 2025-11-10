// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Findnum {
    function find (uint256[] memory nums, uint256 target) public pure returns (uint256) {
        uint256 n = nums.length;
        uint256 left = 0;
        uint256 right = n - 1;
        while (left <= right) {
            uint256 mid = left + (right - left) / 2;
            if (nums[mid] == target) {
                return mid;
            } else if (nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        require(false, "Target not found");
        return 0;
    }
}