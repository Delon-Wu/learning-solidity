// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArrayContract {
    uint8[] public arr1;
    uint8[] public arr2 = [1, 2, 3];
    uint8[] public arr3 = new uint8[](9);

    uint[3] public staticArr1;
    uint[3] public staticArr2 = [1, 2]; // 第三个元素为 0， 即：[1, 2, 0]

    function readArray() external view returns(uint8[] memory a1, uint256 len1, uint8[] memory a2, uint256 len2, uint8[] memory a3, uint256 len3){
        a1 = arr1;
        len1 = arr1.length;
        a2 = arr2;
        len2 = arr2.length;
        a3 = arr3;
        len3 = arr3.length;
    }
    
    bytes public bs = "abcDelon";
    bytes public data = new bytes(10);
    string public str1;
    string public str2 = "Hello\u718A";

    function readBytes(uint index) public view returns (bytes1) {
        return bs[index];
    }
    function find(bytes1 b) public view returns (int256) {
        for(uint i; i < bs.length; i++) {
            if (bs[i] == b) {
                return int256(i);
            }
        }
        return -1;
    }

    function testSlice(uint256[] calldata data1, uint256 start, uint256 end) public pure returns(uint256[] memory arr) {
        arr = data1[start:end]; // 只支持 calldata 类型的数组
    }

}