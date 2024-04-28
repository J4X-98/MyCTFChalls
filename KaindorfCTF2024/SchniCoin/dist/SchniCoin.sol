// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract SchniCoin
{
    enum Grade {
        NoGrade,
        Sufficient,
        Okay,
        Good,
        VeryGood
    }

    address public owner;                               // The owner of the contract
    uint256 public year;                                // The year of the school year
    Grade public bestGrade;                             // The best grade in the class
    mapping(address => uint) public lastAttendance;     // The last time a student checked in
    mapping(address => uint) public balances;           // The balances of the students
    mapping(address => Grade) public grades;            // The grades of the students
    mapping(address => string) public messagesToSchni;  // The messages to Schni

    constructor() 
    {
        owner = msg.sender;
    }

    //This is the function you need to call to get your weekly SchniCoin
    function attend() public payable
    {
        // Require a single eth transfer so you don't spam the school server (you'll get it back afterwards this is no p2w)
        require(msg.value == 1 ether, "You need to send some ether");

        // Require that you only check in once per week so you have to be in class regularly
        require(block.timestamp - lastAttendance[msg.sender] > 1 weeks ||  lastAttendance[msg.sender] == 0, "You can only check in once per week");
        
        //You get one SchniCoin
        _mint(1, msg.sender);

        // Refund your ether
        (bool success, ) = payable(msg.sender).call{value: 1 ether}("");

        require(success, "Transfer failed.");

        // Set your last attendance to now
        lastAttendance[msg.sender] = block.timestamp;
    }

    // Makes it possible to deduct tokens from your balance if you misbehaved in class
    function deduct(uint amount, address student) public
    {
        //check that only the teacher can call this
        require(msg.sender == owner, "You are not the teacher");

        //check that the student has enough SchniCoins
        require(balances[student] >= amount, "He does not have enough SchniCoins");
        _burn(amount, student);
    }

    //Get your grade for the year
    function getGrade() public
    {
        if(balances[msg.sender] < 10)
        {
            grades[msg.sender] = Grade.Sufficient;

            if(Grade.Sufficient > bestGrade)
            {
                bestGrade = Grade.Sufficient;
            }
        }
        else if(balances[msg.sender] < 20)
        {
            grades[msg.sender] = Grade.Okay;

            if(Grade.Okay > bestGrade)
            {
                bestGrade = Grade.Okay;
            }
        }
        else if(balances[msg.sender] < 30)
        {
            grades[msg.sender] = Grade.Good;
            
            if(Grade.Good > bestGrade)
            {
                bestGrade = Grade.Good;
            }
        }
        else
        {
            grades[msg.sender] = Grade.VeryGood;
            
            if(Grade.VeryGood > bestGrade)
            {
                bestGrade = Grade.VeryGood;
            }
        }
    }   

    //Send a message to Schni
    function sendMessage(string memory message) public
    {
        messagesToSchni[msg.sender] = message;
    }

    // Get the best grade
    function getBestGrade() public view returns (Grade)
    {
        return bestGrade;
    }

    //Get your balance
    function getBalance(address student) public view returns (uint)
    {
        return balances[student];
    }

    // ------------------ INTERNAL FUNCTIONS ------------------

    //Mint new tokens
    function _mint(uint amount, address to) internal
    {
        balances[to] += amount;
    }

    //Burn tokens
    function _burn(uint amount, address from) internal
    {
        balances[from] -= amount;
    }
}