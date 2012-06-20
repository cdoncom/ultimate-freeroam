/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/*********************** Create SQL Tables ***********************/

if ( getServerDatabaseType ( ) == "MYSQL" )
{
	// USE MYSQL
	
	//sql.create_table( "items", [
		//{ name = "index", type = "int(11) unsigned", primary_key = true, auto_increment = true },
		//{ name = "owner", type = "int(11) unsigned" },
		//{ name = "item", type = "int(11) unsigned" },
		//{ name = "value", type = "text" }
	//] );
	
}
else
{
	// USE EASYINI
	
}

/*****************************************************************/
/************************** Items List ***************************/

item_types <-
[
	generic,
	container,
	consumable,
];

items <-
[

	// VALUE CAN BE USED TO REPRESENT QUANTITY, OR ATTRIBUTE LIKE CREDIT CARD NUMBER, 
	// PHONE NUMBER, OR THE AMOUNT WITHIN SOMETHING SUCH AS PAGES IN A NOTEBOOK. TYPE
	// REPRESENTS THE ITEM'S TYPE, AS IN JUST A GENERIC ITEM, A CONTAINER TO HOLD OTHER
	// ITEMS, OR SOMETHING THAT IS CONSUMABLE LIKE FOOD OR DRUGS. ITEMS CAN BE ADDED.
	
	{ name = "Health Kit", value = 10, type = item_types.generic },
	{ name = "Cell Phone", value = -1, type = item_types.generic },
	{ name = "Dice", value = -1, type = item_types.generic },
	{ name = "Key", value = -1, type = item_types.generic },
	{ name = "Notebook", value = 10, type = item_types.generic }
];

// ASSIGN FALSE AS TYPE TO ITEMS WITHOUT A TYPE
foreach ( item in items )
{
	if ( !item.rawin ( "type" ) )
		item.type <- false;
}

/*****************************************************************/
/************************** Item Class ***************************/

class CItem extends CEntity
{
	// SET UP CITEM VARIABLES
	id = -1;
	name = "";
	value = "";
	owner = false;
	type = false;
	inventory = false;

	constructor ( id, value, owner, index )
	{
	
		// SET THE ID AND NAME OF THE ITEM - THIS IS WHAT IDENTIFIES THIS CITEM INSTANCE
		if ( typeof ( id ) == "integer" )
		{
			this.id = id;
			name = items[id].name;
		}
		else if ( typeof ( id ) == "string" )
		{
			local info = getItemInfo ( id )
			if ( !info )
				delete this;
			else
			{
				this.id = info[1];
				name = info[0].name;
			}
		}
		
		// ASSIGN A VALUE, OWNER, AND SET ENITITY DATA TO THE INSTANCE 
		this.value = value;
		this.owner = owner;
		this.type = items[id].type;
		entityType = entityTypes.item;
		entityID = index;
		
		// IF THE ITEM CAN HAVE A SUBINVENTORY WITHIN IT
		if ( this.type == item_types.container )
			this.inventory = CInventory ( this );
			
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
	
};

function getItemInfo ( i )
{
	if ( typeof ( i ) == "string" )
	{
		foreach ( k, v in items )
		{
			if ( v.name.tolower ( ) == i.tolower(  ) )
				return [ v, k ];
		}
		return false;
	}
	else if ( typeof ( i ) == "integer" )
	{
		return [ items[i], i ];
	}
	return false;
}

/*****************************************************************/
/*************************** Inventory ***************************/

class CInventory extends CEntity
{
	// SET UP CLASS VARIABLES, ENTITY IS THE PARENT THAT THE INSTANCE 
	// IS OF AND INVENTORY HOLDS THE CITEM INSTANCES
	entity = false;
	inventory = [ ];
	
	constructor ( entity )
	{
		this.inventory = [ ];
		this.entity = entity;
		entityType = entityTypes.inventory;
		load ( );
	}
	
	function load ( )
	{
		clearAllItems ( );
		
		local inv = false;
		
		if ( getServerDatabaseType ( ) == "MYSQL" )
		{
			// MYSQL
			//inv = { };
		}
		else
		{
			// EASYINI
			//inv = { };
		}
		
		if ( inv )
		{
			foreach ( item in inv )
			{
				if ( item.item >= 0 && item.item < items.len ( ) )
				{
					// CREATE THE ITEM INSTANCE WITH THE GIVEN DETAILS
					inventory.push ( CItem ( inv.item, inv.value, inv.owner, inv.index ) );
				}
			}
			return true;
		}
		return false;
	}
	
	// GIVES THE INVENTORY AN ITEM
	function give ( item, value, stack = true )
	{		
		if ( typeof ( item ) == "integer" && item >= 0 && item < items.len ( ) ) // valid item
		{
		
			if ( getServerDatabaseType ( ) == "MYSQL" )
			{
				// MYSQL
				//local index = sql.query_insertid ( "INSERT INTO items (owner, item, value) VALUES (" + entity.getUserID( ) + "," + item + ",'" + sql.escape( value.tostring( ) ) + "')" );
			}
			else
			{
				// EASYINI
				// local index = "";
			}
			
			if ( index )
			{
				// CREATE THE ITEM INSTANCE WITH THE GIVEN DETAILS
				inventory.push ( CItem ( index.item, index.value, index.owner, index.index ) );
				return true;
			}
		}
		return false;
	}
	
	// RETURNS ALL ITEMS IN INVENTORY OR LOOKS FOR ITEM AN IF CRITERIA IS GIVEN
	function get ( item = false, value = false )
	{
		if ( item )
		{
			local arr = [ ];
			if ( typeof ( item ) == "integer" && item >= 0 && item < items.len ( ) )
				foreach ( i in inventory )
					if ( i.getID ( ) == item && ( value == false || value.tostring ( ) == i.getValue ( ) ) )
						arr.push ( i );
			return arr;
		}
		else
			return inventory;
	}
	
	// RETURNS THE ITEM WITHIN THE GIVEN INVENTORY SLOT
	function getOnSlot( slot )
	{
		if ( typeof ( slot ) == "integer" && slot > 0 && slot <= inventory.len ( ) )
			return inventory[ slot - 1 ];
		return false;
	}
	
	// DELETES AN ITEM FROM THE INVENTORY PERMANENTLY
	function deleteItem ( slot )
	{		
		local item;
		if ( typeof ( slot ) == "integer" )
			item = getOnSlot ( slot );
		else
			item = slot;	
		
		//if ( sql.query_affected_rows( "DELETE FROM items WHERE `index` = " + item.getIndex() ) == 1 )
		//{
			delete item;
			return true;
		//}
		return false;
	}
	
	// DELETES ALL ITEMS FROM THE INVENTORY PERMANENTLY
	function deleteAllItems ( )
	{
		foreach ( item in inventory )
			deleteItem ( item );
		return true;
	}
	
	// CLEARS ALL ITEMS FROM INVENTORY BUT NOT FROM DATABASE
	// FOR TEMPORARY INVENTORY CLEANUP
	function clearAllItems ( )
	{
		foreach ( item in inventory )
			delete item;
		return true;
	}
	
	
	// RETURNS AN ITEM WITH THE GIVEN ITEMID OR FINDS ONE WITH THE GIVEN VALUE
	// IF EXISTS, FALSE OTHERWISE
	function has ( item, value = false )
	{
		
		if ( typeof( item ) == "integer" && item >= 0 && item < items.len ( ) )
		{
			foreach ( i in inventory )
			{
				//if ( items[ i.getID ( ) ].type = item_types.container )
					//return i;
				
				if ( i.item == item && ( value == false || value.tostring ( ) == i.value ) )
					return i;
			}
		}
		return false;
	}	
};

/*****************************************************************/