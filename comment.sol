// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Casino {
    uint256 private balance;
    uint256 public minVal = 100;
    uint256 public maxVal = 1000;
    uint256 public Cap = 10;
    uint256 public payments;
    uint256 public profit;
    address public owner;


    constructor() {
        owner = msg.sender;
    }  

    modifier onlyOwner() {
        require(msg.sender == owner, "Access restricted, not an owner");
        _;
    }

    function setMinTopUp(uint  val) public onlyOwner() {
        require(val < maxVal, 'Val should not be max then ${maxVal}');
        minVal = val;
    }

    function setMaxTopUp(uint  val) public onlyOwner() {
        require( val > minVal);
        maxVal = val;
    }
    
    function setCap(uint val) public onlyOwner() {
        Cap = val;
    }

    function topUp() public payable {
        require(payments > minVal);
        payments += msg.value;
        if( payments >= Cap) {
            address payable to = payable(msg.sender);
            to.transfer((payments/100)*80);
            profit += (payments/100)*20;
            payments = 0;
        }
    }

    function withdrawAll() public {
        address payable Owner = payable(owner);
        Owner.transfer(profit);
    }
}