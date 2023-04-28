//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.17;

contract KaiNFT{
    mapping(address => uint) public nfts_owned;
    mapping(address => bool) public free_claimed;
    address payable owner;
    bool pwned;

    constructor() 
    {
        owner = payable(msg.sender);
        pwned = false;
    }

    function buyNFT() public payable {
        if (!free_claimed[msg.sender] && msg.value == 1)
        {
            //first NFT is free, you get your money back
            nfts_owned[msg.sender] += 1;
            msg.sender.call{value: 1}("");
            free_claimed[msg.sender] = true;
        }
        else if (msg.value > 1000000000000000000000)
        {
            //The first dose is cheap, but now i'll take all your money ;)
            nfts_owned[msg.sender] += 1;
        }
    }

    function becomeOwner() public {
        if (nfts_owned[msg.sender] > 13)
        {
            owner = payable(msg.sender);
            pwned = true;
        }
    }

    function haveIBeenPwned() public view returns (bool pwn){
        return pwned;
    }
}