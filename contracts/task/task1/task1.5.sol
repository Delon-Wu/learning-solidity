// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract MergeArray {
    function merge(uint256[] memory nums1, uint256[] memory nums2) public pure returns (uint256[] memory nums) {
        uint256 p1 = 0;
        uint256 p2 = 0;
        nums = new uint256[](nums1.length + nums2.length); // Initialize the merged array with the correct size
        uint256 i = 0;
        while (p1 < nums1.length && p2 < nums2.length) {
            if (nums1[p1] < nums2[p2]) {
                nums[i] = nums1[p1];
                p1++;
            } else {
                nums[i] = nums2[p2];
                p2++;
            }
            i++;
        }
        while (p1 < nums1.length) {
            nums[i] = nums1[p1];
            p1++;
            i++;
        }
        while (p2 < nums2.length) {
            nums[i] = nums2[p2];
            p2++;
            i++;
        }
    }
}