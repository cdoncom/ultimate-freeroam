/*
 * "TheGhost's Ultimate Freeroam"
 */
 
/*****************************************************************/
/*********************** Create SQL Tables ***********************/

sql.create_table( "items", [
	{ name = "index", type = "int(11) unsigned", primary_key = true, auto_increment = true },
	{ name = "owner", type = "int(11) unsigned" },
	{ name = "item", type = "int(11) unsigned" },
	{ name = "value", type = "text" }
] );

/*****************************************************************/
/************************** Items List ***************************/
items <-
[
	{ name = "Health Kit", value = 10 },
	{ name = "Cell Phone", value = 0 },
	{ name = "Dice" },
	{ name = "Key", value = 0 },
	{ name = "Notebook", value = 5 }
];

foreach( item in items )
{
	if( !item.rawin( "type" ) )
		item.type <- false
}

/*****************************************************************/
/************************** Item Class ***************************/

class CItem extends CEntity
{
	id = -1;
	name = "";
	value = "";
	owner = false;

	constructor ( id, value, owner, index )
	{
		if ( typeof ( id ) == "integer" )
		{
			this.id = id;
			name = items[id].name;
		}
		else if ( typeof ( id ) == "string" )
		{
			local info = getItemInfo ( id )
			if ( !info )
			{
			
			}
			else
			{
				this.id = info[1];
				name = info[0].name;
			}
		}
		this.value = value;
		this.owner = owner;
		entityType = entityTypes.item;
		entityID = index;
	}
	
	function getName ( )
	{
		return name;
	}
	
	function getID ( )
	{
		return this.id;
	}
	
	function getValue ( )
	{
		return value;
	}
	
	function getOwner ( )
	{
		return owner;
	}
}

function getItemInfo ( i )
{
	if ( typeof ( i ) == "string" )
	{
		foreach ( k, v in items )
		{
			if ( v.name.tolower() == i.tolower() )
				return [ v, k ];
		}
		return false;
	}
	return false;
}

/*****************************************************************/
/*************************** Inventory ***************************/
class CInventory extends CEntity
{
	entity = false;
	inventory = [ ];
	containerId = false;
	
	constructor( entity )
	{
		this.inventory = [ ];
		this.entity = entity;
		entityType = entityTypes.inventory;
		load();
	}
	
	function load ( )
	{
		clearAllItems();
		
		local inv = sql.query_assoc( "SELECT * FROM items WHERE owner = " + entity.getUserID( ) + " ORDER BY `index` ASC" );	
		if( inv )
		{
			foreach( item in inv )
			{
				if( item.item >= 0 && item.item < items.len( ) )
				{
					inventory.push ( CItem ( inv.item, inv.value, inv.owner, inv.index ) );
				}
			}
			return true;
		}
		return false;
	}
	
	// Gives the Inventory an item
	function give( item, value, stack = true )
	{		
		if( typeof( item ) == "integer" && item >= 0 && item < items.len( ) ) // valid item
		{
			local index = sql.query_insertid ( "INSERT INTO items (owner, item, value) VALUES (" + entity.getUserID( ) + "," + item + ",'" + sql.escape( value.tostring( ) ) + "')" );
			if( index )
			{
				inventory.push ( CItem ( index.item, index.value, index.owner ) );
				return true;
			}
		}
		return false;
	}
	
	// returns a table of all items in the inventory, if given criteria then matching those
	function get( item = false, value = false )
	{
		if( item )
		{
			local arr = [ ];
			if( typeof( item ) == "integer" && item >= 0 && item < items.len( ) ) // valid item
				foreach( i in inventory )
					if( i.getID() == item && ( value == false || value.tostring( ) == i.getValue() ) )
						arr.push( i );
			return arr;
		}
		else
			return inventory;
	}
	
	// returns the item on the slot
	function getOnSlot( slot )
	{
		if( typeof( slot ) == "integer" && slot > 0 && slot <= inventory.len( ) )
		{
			return inventory[ slot - 1 ];
		}
		return false;
	}
	
	// takes an item from a certain slot or removes a certain item
	function deleteItem ( slot )
	{		
		local item;
		if( typeof( slot ) == "integer" )
			item = getOnSlot ( slot );
		else
			item = slot;	
		
		if ( sql.query_affected_rows( "DELETE FROM items WHERE `index` = " + item.getIndex() ) == 1 )
		{
			delete item;
			return true;
		}
		return false;
	}
	
	// Removes all items from the inventory
	function deleteAllItems ( )
	{
		foreach( item in inventory )
			take ( item );
		return true;
	}
	
	// Clears out inventory but does not delete item from database
	function clearAllItems ( )
	{
		foreach( item in inventory )
			delete item;
		return true;
	}
	
	
	// returns the first found item if the player has any of that kind, false otherwise
	function has( item, value = false )
	{
		
		if( typeof( item ) == "integer" && item >= 0 && item < items.len( ) ) // valid item
		{
			foreach( i in inventory )
			{
				if ( items[i.item].type = "container" )
				{
					if ( i.inventory )
					{
						local inside = i.inventory.has ( item, value );
						if ( inside )
							return inside;
					}
				}
				
				if( i.item == item && ( value == false || value.tostring( ) == i.value ) )
					return i;
			}
		}
		return false;
	}	
};

/*****************************************************************/