/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/********************** Entity Helper Class **********************/

entityTypes <-
[
	unknown,
	account,
	player,
	vehicle,
	inventory,
	item,
	building,
	checkpoint,
	marker,
	
	// INCLUDE CUSTOM ENTITY TYPES HERE
	
];

class CEntity
{
	entityType = entityTypes.unknown;
	entityID = -1;
	
	function getType ( )
	{
		return entityType;
	}
	
	function getUniqueID ( )
	{
		return entityID;
	}
}

/*****************************************************************/
/*****************************************************************/