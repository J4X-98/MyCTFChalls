//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.7.0;

contract KaiVault {
    mapping(address => uint) public tokens;
    address payable owner;
    string vault_name;
    bool pwned;
    uint counter =1;

    modifier onlyOwner() {
        require(owner == msg.sender, "ALARM: caller is not the owner");
        _;
    }

    constructor() 
    {
        owner = payable(msg.sender);
        tokens[owner] = 133742069133742069;
        pwned = false;
    }
    
    function random() private returns (uint) {
        counter++;
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, counter)));
    }

    function renameVault(string memory new_name) public payable onlyOwner {
        if (msg.value > 100)
        {
            vault_name = new_name;
        }
    }

    function createAccount() public
    {
        require (tokens[msg.sender] == 0, "Account was already created");
        tokens[msg.sender] = 1337;
    }

    function createNewTokens(uint guess) public
    {
        if (guess == random() % 1337)
        {
            tokens[msg.sender] += 1;
        }
    }

    function burn(uint burn_amount) public 
    {
        if (tokens[msg.sender] - burn_amount > 0)
        {
            tokens[msg.sender] -= burn_amount;
        }
    }

    function becomeOwner() public {
        require (tokens[owner] < tokens[msg.sender], "You ain't the biggest fish");

        owner = payable(msg.sender);
        pwned = true;
    }

    function haveIBeenPwned() public view returns (bool pwn){
        return pwned;
    }
}