 // SPDX-License-Identifier: MIT
 pragma solidity ^0.8;

 contract BeggingContract {
    event DonationReceived(address donor, uint256 donation);

    address private _owner;
    mapping(address donor => uint256 donation) public donationRecord;
    address[] private _recordDecrease;


    modifier OnlyOwner() {
        require(_owner == msg.sender, "Only owner!");
        _;
    }
    constructor() {
        _owner = msg.sender;
    }

    // 捐款
    function donate() external payable returns (bool) {
        uint256 amount = msg.value;
        require(amount > 0, "Donation must greater than 0");
        donationRecord[msg.sender] += amount;
        payable(_owner).transfer(amount);
        emit DonationReceived(msg.sender, amount);
        sortRecord(msg.sender, amount);
        return true;
    }

    function getTop3() public view returns(address[3] memory) {
        address[3] memory result;
        uint256 count;
        for (uint256 i; count < 3 && i < _recordDecrease.length; i++) {
            if (_recordDecrease[i] != address(0)) {
                result[count] = _recordDecrease[i];
                count++;
            }
        }
        return result;
    }

    function sortRecord(address donor, uint256 amount) private {
        if (amount > 0) {
            _recordDecrease.push(donor);
            uint256 n = _recordDecrease.length;
            for (uint256 i = n - 1; i > 0; i--) {
                if (donationRecord[_recordDecrease[i]] > donationRecord[_recordDecrease[i - 1]]) {
                    if (_recordDecrease[i] == address(0) ||_recordDecrease[i - 1] == _recordDecrease[i]) {
                        delete _recordDecrease[i];
                    } else {
                        (_recordDecrease[i - 1], _recordDecrease[i]) = (_recordDecrease[i], _recordDecrease[i - 1]);
                    }
                } else {
                    break;
                }
            }   
        }
    }

    // 提款
    function withdraw(address payable to) external OnlyOwner {
        if (to == address(0)) {
            revert("Invalid address");
        }
        to.transfer(address(this).balance);
    }

    // 获取捐款者捐款金额
    function getDonation(address donor) public view returns (uint256) {
        return donationRecord[donor];
    }
 }