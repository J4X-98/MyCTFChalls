// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SchniCoin.sol";

contract Setup {
    SchniCoin public immutable TARGET; // Contract the player will hack

    constructor() payable {
        require(msg.value == 100 ether);

        // Deploy the victim contract
        TARGET = new SchniCoin();
    }

    // Our challenge in the CTF framework will call this function to
    // check whether the player has solved the challenge or not.
    function isSolved() public view returns (bool) {
        return TARGET.getBestGrade() == SchniCoin.Grade.VeryGood;
    }
}