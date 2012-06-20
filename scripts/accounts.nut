/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/**************************** Accounts ***************************/

accounts <- { };

class CAccount
{
	username = false;
	password = false;
	userid = false;
	data = { };
	entity = false;

	constructor ( entity, name, pass, id )
	{
		username = name;
		password = pass;
		userid = id;
		this.entity = entity;
		entityType = entityTypes.account;
	}
	
	function getUsername ( )
	{
		return username;
	}
	
	function getPassword ( )
	{
		return password;
	}
	
	function getUserID ( )
	{
		return userid;
	}
	
	function getEntity ( )
	{
		return entity;
	}
	
	// SET CUSTOM ACCOUNT DATA
	function setData ( key, value )
	{
		if ( data.rawin ( key ) )
			data[key] = value;
		else
			data[key] <- value;
		return true;
	}
	
	// GET CUSTOM ACCOUNT DATA
	function getData ( key )
	{
		if ( data.rawin ( key ) )
			return data[key];
		else
			return false;
	}
};

/*****************************************************************/
/************************** Functions ****************************/

function loginPlayer ( player, username )
{
	local info = 
	if ( player.login ( info.userid, username, info ) )
		return true;
	return false;
}

function addAccount  ( player, username, password )
{
	return true;
}

function removeAccount ( account )
{
	return true;
}

function setAccountData ( account, key, value )
{
	return account.setData ( key, value );
}

function getAccountData ( account, key )
{
	return account.getData ( key );
}

function setAccountPassword ( account, pass )
{
	return true;
}

function getPlayerAccount ( player )
{
	return player.getAccount ( );
}

function getAccountName ( account )
{
	return account.getUsername( );
}

function getAccountPlayer ( account )
{
	return acocunt.getEntity ( );
}

function getAllAccountData ( account )
{
	return account.data;
}

/*****************************************************************/