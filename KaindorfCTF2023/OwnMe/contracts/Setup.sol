pragma solidity ^0.8.13;

import "./Chal.sol";

contract Setup {
    OwnMe public immutable TARGET;

    uint private initialBalance;

    constructor() {
        TARGET = new OwnMe();
    }

    function isSolved() public view returns (bool) {
        return TARGET.haveIBeenPwned();
    }
}