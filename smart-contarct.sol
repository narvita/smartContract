// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Casino {
    uint private balance;
    uint public minVal;
    uint public maxVal;
    uint public Cap;
    address public owner;
    uint public payments;
    uint public profit;

    constructor() {
        owner = msg.sender;
    }  

    modifier onlyOwner() {
        require(msg.sender == owner, "Access restricted, not an owner");
        _;
    }

    function setMinTopUp(uint  val) public onlyOwner() {
        minVal = val;
    }

    function setMaxTopUp(uint  val) public onlyOwner() {
        maxVal = val;
    }
    
    function setCap(uint val) public onlyOwner() {
        Cap = val;
    }

    function topUp() public payable {
        payments = msg.value;
        if( payments >= Cap) {
            address payable to = payable(msg.sender);
            to.transfer((payments/100)*80);
            profit += (payments/100)*20;
        }
    }

    function withdrawAll() public {
        address payable Owner = payable(owner);
        address thisContract = address(this);
        Owner.transfer(thisContract.balance);
    }
}