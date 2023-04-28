//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract OwnMe {
    address owner;
    bool pwned;

    constructor() 
    {
        owner = msg.sender;
        pwned = false;
    }

    function haveIBeenPwned() public view returns (bool pwn){
        return pwned;
    }

    function becomeOwner() public {
        owner = msg.sender;
        pwned = true;
    }
}