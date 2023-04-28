uint balance;

function deplosit(uint256 value){
	balance += value;
}

function withdraw(uint256 value){
	if(balance - value > 0)
	{
		user.send(value);
}
}
