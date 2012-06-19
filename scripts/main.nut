/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/**************************** Defines ****************************/

// DEFAULT COLORS
color <-
{
	white      = 0xFFFFFFFF,
	gray      = 0xAAAAAAAA,
	yellow     = 0xFFFF00FF,
	orange     = 0xFFBB00FF,
	green      = 0x00FF00FF,
	lightgreen = 0x8FFF8FFF,
	red        = 0xFF0000FF,
	syntax     = 0xFFFFFFFF,
	admin      = 0x00FFCCFF,
	usergroup    = 0x2222DDFF,
	usergroupchat = 0x03EDEDFF,
	purple = 0xD40696FF,
}

/*****************************************************************/
/**************************** Config *****************************/

// INITIALIZE CONFIG
config <-
{
	globalchat = false,
	servername = getServerName ( ),
	gamemode = "Ultimate Freeroam",
}

setGameModeText ( config.gamemode );

// RETURNS WHETHER GLOBAL CHAT IS ENABLED
function isGlobalChatEnabled ( )
{
	return config.globalchat;
}

/*****************************************************************/
/*************************** Includes ****************************/

dofile( "scripts/util.nut" );
dofile( "scripts/entity.nut" );
dofile( "scripts/players.nut" );
dofile( "scripts/inventory.nut" );
dofile( "scripts/commands.nut" );

/*****************************************************************/
/************************** Initalization **************************/

addEventHandler ( "scriptInit",
	function( )
	{
		log ( time( ) + "" );
		
		// SEED RANDOM GENERATOR
		srand ( time( ) );
		
		// CREATE PLAYER INSTANCE FOR EACH CONNECTED PLAYER
		foreach ( playerid, name in getPlayers ( ) )
			players[ playerid ] <- CPlayer ( playerid );		
	}
);

addEventHandler ( "scriptExit",
	function( )
	{
		// SAVE ALL PLAYER INFO
		foreach( player in players )
			player.save( );
	}
);

/*****************************************************************/
/************************** Commands **************************/

addEventHandler( "playerCommand",
	function( playerid, command )
	{
		local player = players[ playerid ];
		if( !player )
			return false;
		
		if( command.len( ) == 1 )
			return false;
		
		local cmd = split( command, " " );
		cmd[0] = cmd[0].slice( 1 ).tolower( );
		
		// OUTPUT PLAYER COMMAND TO ALL ADMINS ON LOG-DUTY
		foreach( admin in all.admins( ) )
		{
			if( admin.isOnLogDuty( ) )
			{
				admin.message( getPlayerName( playerid ) + ": " + command );
			}
		}
		
		// EXECUTE COMMAND HANDLER FUNCTION
		return executeCommand( player, cmd );
	}
);

/*****************************************************************/
/****************************** Chat *****************************/

addEventHandler ( "playerText",
	function ( playerid, text )
	{
		local player = players[ playerid ];
		if ( !player )
			return false;	
		
		if ( !isGlobalChatEnabled ( ) )
		{
			player.message ( "Global chat is disabled!" );
			return false;
		}
		else
		{
			
		}
		return true;
	}
);

/*****************************************************************/
/************************** Connections **************************/

addEventHandler ( "playerConnect", 
	function ( playerid )
	{
		// INITIALIZE PLAYER INSTANCE
		players[ playerid ] <- CPlayer ( playerid );
		
		// NOTIFY ALL PLAYERS OF NEW PLAYER
		all.message ( "* " + getPlayerName ( playerid ) + " has joined the server." );
		
		return true;
	}
);

addEventHandler ( "playerDisconnect", 
	function ( playerid, reason )
	{
		local player = players[playerid];	
		local r = reason ? "Timeout" : "Quit";
		
		// NOTIFY ALL PLAYER OF PLAYER LEAVE
		all.message( player.getName() + " (ID: " + player.getID() + ") disconnected (" + r + ").");
		
		// SAVE PLAYER INFO
		player.save( );
		
		// DELETE PLAYER INVENTORY
		player.cleanup( );
		
		// DELETE PLAYER INSTANCE
		delete players[ playerid ];
		return true;
	}
);

/*****************************************************************/
/*****************************************************************/