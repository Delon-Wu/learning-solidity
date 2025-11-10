// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructNote {
    // 成员不能为mapping

    struct Person {
        uint8 age;
        string name;
        Hobby hobby;
        Role role;
    }
    struct Hobby {
        string label;
        uint8 value;
    }
    enum Role {
        Admin,
        User
    }
    Person public Admin;
    Person[] public PersonGroup;
    mapping(uint8 userID => Person person) public PersonMapping;
}