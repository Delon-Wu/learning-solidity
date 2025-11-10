// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract GlobalVariable {
    function testMsg() public view returns(address){
        return msg.sender;
    }

    function testTx() public view returns(address) {
        return tx.origin; // 可能导致安全漏洞
    }

    function getMessageDetails() public payable returns(address, uint) {
        return (msg.sender, msg.value);
    }

    function testThis() public view returns(uint, address){
        return (address(this).balance, address(this));
    }
}

contract Attack {
    GlobalVariable globalVariable;
    constructor() {
        globalVariable = new GlobalVariable();
    }

    function testMsg() public view returns(address){
        return globalVariable.testMsg();
    }

    function testTx() public view returns(address) {
        return globalVariable.testTx();
    }
}

// Application Binary Interface 应用二进制接口
contract ABI {
    // 1. 编码
    function encodeData(string memory text, uint256 number) public pure returns (bytes memory, bytes memory) {
        return (
            abi.encode(text, number),
            abi.encodePacked(text, number)
        );
    }

    // 2. 解码
    function decodeData(bytes memory data) public pure returns (string memory, uint256) {
        return abi.decode(data, (string, uint256));
    }

    // 3. 获取当前函数的签名
    function getSelector() public pure returns(bytes4) {
        return msg.sig;
    }
    function getSelector1() public pure returns(bytes4) {
        return msg.sig;
    }

    // 4. 计算函数选择器
    function computeSeletor(string memory func) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(func)));
    }

    function transfer(address addr, uint256 amount) public pure returns(bytes4, bytes memory) {
        return (msg.sig, msg.data);
    }

    // 5. abi调用函数，生成msg.data
    function encodeFunctionCall() public pure returns (bytes memory) {
        return abi.encodeWithSignature("transfer(address,uint256)", 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4, 100);
    }

    // 6. 哈希运算
    function hash(string memory input) public pure returns(bytes32, bytes32, bytes32) {
        bytes memory data = abi.encodePacked(input);
        return (
            keccak256(data),
            sha256(data),
            ripemd160(data)
        );
    }

    // 7. 数学运算 addmod(x, y, m), mulmod(x, y, m)
    function modularMath(uint256 x, uint256 y, uint256 m) public pure returns (uint256, uint256) {
        return (
            addmod(x, y, m),
            mulmod(x, y, m)
        );
    }

    // 8. 椭圆曲线回复公钥 
    function recoverAddress(bytes32 hash, uint8 v, bytes32 r, bytes32 s) public pure returns (address) {
        return ecrecover(hash, v, r, s);
    }
}