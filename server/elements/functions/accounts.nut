function getAccounts ( )
{
	return ACCOUNTS.getaccounts( );
}

function getAccount ( var )
{
	local account = ACCOUNTS.getaccount ( var );
	if ( account )
		return account;
	return false;
}