/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/**************************** Accounts ***************************/

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
	if ( player.login ( info.userid, username, info )
}