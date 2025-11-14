// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract MyERC20 {
    error InvalidSender(address sender);
    error InvalidReceiver(address receiver);
    error InsufficientBalance(address from, uint256 fromBalance, uint256 value);
    error InvalidApprover(address approver);
    error InvalidSpender(address sender);

    event Transfer(address from, address to, uint256 value);
    event Approval(address owner, address spender, uint256 value);

    mapping(address account => uint256 balance) private _balances;
    mapping(address account => mapping(address spender => uint256)) private _allowances;
    string private _name;
    string private _symbol;
    uint256 private _totalSupply;

    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
        _mint(msg.sender, 10000);
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 amount) external returns (bool) {
        address owner = msg.sender;
        if (owner == address(0)) {
            revert InvalidSender(address(0));
        }
        if (to == address(0)) {
            revert InvalidReceiver(address(0));
        }

        _balances[to] += amount;
        uint256 fromBalance = _balances[owner];
        if (fromBalance < amount) {
            revert InsufficientBalance(owner, fromBalance, amount);
        }
        _balances[owner] -= amount;
        _balances[to] += amount;
        emit Transfer(owner, to, amount);
        return true;
    }

    function approve(address spender, uint256 value) external {
        address owner = msg.sender;
        if (owner == address(0)) {
            revert InvalidApprover(address(0));
        }
        if (spender == address(0)) {
            revert InvalidSpender(address(0));
        }
        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _mint(address account, uint256 value) internal {
        if (account == address(0)) {
            revert InvalidReceiver(address(0));
        }
        _totalSupply += value;
        _balances[account] += value;
    }

}