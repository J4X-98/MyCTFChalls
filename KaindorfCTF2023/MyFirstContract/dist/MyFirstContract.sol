//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract MyFirstContract {

    string public flag;
    
    constructor(string memory _flag)
    {
       flag = _flag;
    } 

    function giveMeMoney() payable public {
        
    }
}