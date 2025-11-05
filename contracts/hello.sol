// SPDX-License-Identifier: MIT
pragma solidity >=0.8.9 <0.9.0;

contract Hello3Dot0 {
    string public hello = "Hello 3.0";

    // learning data type
    // int public account = 1 * 2 ** 255 - 1;
    // uint public account1 = 1 * 2 ** 256 - 1;
    // bool public flag = true;

    // address public addr = 0x233FBb242353720Fa98115db73448a662A2D0888; // 16 20位 keccack256
    // bytes32 public b1 = hex"1111";
    // enum Status {
    //     Active,
    //     Inactive
    // }
    // Status public status = Status.Active;

    // int[] public arr;
    // string[] public arr2;
    // bool[] public arr3;
    // address public arr4;
    // bytes10[] public arr5;
    // string public str = "hello";
    // struct Person {
    //     string name;
    //     bool isMan;
    //     uint8 age;
    // }
    // Person public tom = Person("Tom", true, 19);

    string private helloPrivate = "Hello, ";
    function greeting1(string memory name) public view returns (string memory) {
        return greeting2(name);
    }

    function changeHello(string memory newHello) public {
        hello = newHello;
    }

    function greeting2(string memory name) internal view returns (string memory) {
        return string.concat(helloPrivate, name);
    }

    function greeting3() public pure returns(string memory) {
        return "Hello world!";
    }

    function learnFunction(
        string memory name
    ) public pure returns (string memory) {
        // 1. 可见修饰符:
        // public external private internal

        // 2. 状态可变性修饰符
        // view只读; pure不可读不可写; default
        return string.concat("hello ", name);
    }

    function claimVar() public  pure returns (uint256) {
        // // 1. Memory 变量，随函数执行完就消失
        // uint256[] memory memoryArray = new uint256[](3);
        // string memory str = "Hello";
        // bytes memory tempBytes = new bytes(10);

        // // 2. Stack 变量 存储在栈上
        // uint256 stackVar = 123;
        // bool flag = true;
        // address sender = msg.sender;
        // uint8 smallNum = 255;

        // return memoryArray[0];
    }
}
