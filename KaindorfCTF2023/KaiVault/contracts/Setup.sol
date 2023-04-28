pragma solidity ^0.7.0;

import "./Chal.sol";

contract Setup {
    KaiVault public immutable TARGET; // Contract the player will hack

    constructor() payable {
        // Deploy the victim contract
        TARGET = new KaiVault();
    }

    // Our challenge in the CTF framework will call this function to
    // check whether the player has solved the challenge or not.
    function isSolved() public view returns (bool) {
        return TARGET.haveIBeenPwned();
    }
}