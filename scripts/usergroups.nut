/*
 * "Ultimate Freeroam by TheGhost"
 */

/*****************************************************************/
/************************** Usergroup ****************************/

class CUsergroup extends CEntity
{

	groupname = " ";
	groupcolor = false;
	members = [ ];
	
	constructor ( name )
	{
		groupname = name;
		entityType = entityTypes.usergroup;
	}
	
	function getName ( )
	{
		return groupname;
	}
	
	function getMembers ( )
	{
		return members;
	}
	
	function addMember ( member )
	{
		if ( members <- member )
			return true;
		return false;
	}
	
	function removeMember ( member )
	{
		foreach ( k in members )
		{
			if ( k == member )
			{
				delete k;
				return true;
			}
		}
		return false;
	}
	
	function countMembers ( )
	{
		return members.len ( );
	}
	
	function getColor ( )
	{
		return groupcolor;
	}
	
	function setColor ( color )
	{
		if ( typeof ( color ) == "integer" )
		{
			//groupcolor = color;
			return true;
		}
		return false;
	}
};

/*****************************************************************/
/************************** Functions ****************************/

function createUsergroup ( name )
{
	return CUsergroup ( name );
}

function getUsergroupName ( t )
{
	return t.getName ( );
}

function getUsergroupMember ( t )
{
	return t.getMembers ( );
}

function getUsergroupColor ( t )
{
	return t.getColor ( );
}

function countUsergroupMembers ( )
{
	return t.countMembers ( );
}

function addMemberToUsergroup ( m, t )
{
	if ( t.addMember ( m ) )
		return true
	return false;
}

function removeMemberFromUsergroup ( m, t )
{
	if ( t.removeMember ( m ) )
		return true;
	return false;
}

/*****************************************************************/