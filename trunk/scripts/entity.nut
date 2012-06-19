/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/********************** Entity Helper Class **********************/

entityTypes <-
{
	unknown = 0,
	player = 1,
	vehicle = 2,
	inventory = 3,
	item = 4,
}

class CEntity
{
	entityType = entityTypes.unknown;
	entityID = -1;
	
	function getType( )
	{
		return entityType;
	}
	
	function getUniqueID( )
	{
		return entityID;
	}
}

/*****************************************************************/
/*****************************************************************/