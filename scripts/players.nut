/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/*********************** Create SQL Tables ***********************/

// INITIALIZE MYSQL TABLES

/*****************************************************************/
/************************** Player Class *************************/

// PLAYER STORAGE
players <- { };

// RETURNS PLAYER WITH GIVEN USERID, FALSE IF PLAYER ID NOT FOUND
function findPlayer ( uid )
{
	foreach ( player in players )
		if ( player.getUserID ( ) == uid )
			return player;
	return false;
}

// PLAYER CLASS
class CPlayer extends CEntity
{
	// PLAYER ID
	playerid = -1;
	
	// ACCOUNT
	account = false;
	
	// PLAYER INVENTORY
	inventory = false;
	// PLAYER MONEY
	bankmoney = 0;
	// PLAYER ACTIVE TIME
	timeplayed = 0;
	// PLAYER MODEL ID
	dModel = 0;
	// USERGROUP ID
	usergroup = 0;
	// USERGROUP RANK
	usergroupRank = 0;
	
	// ADMIN DUTY
	aduty = false;
	// ADMIN LOG-DUTY
	logduty = false;
	// ADMIN LEVEL
	admin = 0;
	
	// PLAYER MESSAGE ENABLED
	pmsEnabled = true;
	// AFK STATUS
	isafk = false;
	// AFK MESSAGE
	afkmsg = "";
	
	constructor ( playerid, setPos = false )
	{
		// SET PLAYERID
		this.playerid = playerid;
		// SET PLAYER ENTITYTYPE
		entityType = entityTypes.player;
		
		// WELCOME MESSAGE
		clearChat ( 8 );
		message ( "Welcome " + getPlayerName ( playerid ) + "!" );
		message ( "Server: " + config.servername + " || Gamemode: " + config.gamemode );
		message ( "Please use /help for more information!" );
		
		// INITIALIZE PLAYER INFO
		setPosition ( 1489, 682, 32.46 );
		setRotation ( 180 );
		setHealth ( 100 );
		setPlayerMoney ( playerid, 0 );
		
		// INITIALIZE PLAYER INVENTORY
		inventory = CInventory ( this );
	}
	
/*************************/
/***** Player Info *******/
	
	// RESET PLAYER INVENTORY
	function cleanup ( )
	{
		inventory = false;
	}
	
	// LOG-IN PLAYER
	function login ( userid, username, info )
	{
		if ( !userid || !username || !info )
			return false;
			
		if ( info != "table" && infor != "array" )
			return false;
			
		account = CAccount ( username, info.password, userid );
		
		this.admin = info.admin;
		
		return true;
	}
	
	// SENDS PLAYER MESSAGE
	function message ( text, color = color.white, formatting = false )
	{
		if ( text.len ( ) > 126 ) text = text.slice ( 0, 126 );
		return sendPlayerMessage ( playerid, text );
	}
	
	// CLEARS PLAYER CHATBOX BY GIVEN AMOUNT OF LINES, DEFAULT IS 10 LINES
	function clearChat ( lines = 10 )
	{
		for( local i = 0; i < lines; i ++ )
			message( " " );
	}
	
	// RETURNS PLAYERID
	function getID ( )
	{
		return playerid;
	}
	
	// RETURNS USERID
	function getUserID ( )
	{
		return userid;
	}
	
	// RETURNS USERNAME
	function getUserName ( )
	{
		return username;
	}
	
	// SETS USERGROUP ID
	function setUsergroup( usergroup = 0, rank = 0 ) 
	{
		//if ( sql.query ( "UPDATE " + userid + " SET usergroupID = " + usergroup + ", usergroupRank = " + rank + "" ) )
		
		this.usergroup = usergroup;
		setUsergroupRank ( rank );
		return true;
	}
	
	// RETURNS USERGROUP ID
	function getUsergroup ( ) 
	{
		return usergroup;
	}
	
	// SETS USERGROUP RANK
	function setUsergroupRank ( r )
	{
		//if ( sql.query ( "UPDATE userid SET usergroupRank = " + r + "" ) )
		usergroupRank = r;
		return true;
	}
	
	// RETURNS USERGROUP RANK
	function getUsergroupRank ( )
	{
		return usergroupRank;
	}
	
	// SETS PLAYER MODEL
	function setModel ( id )
	{
		if ( typeof ( id ) != "integer" )
			return false;
		else
		{
			dModel = id;
			return setPlayerModel ( playerid, id );
		}
	}
	
	// RETURNS PLAYER MODEL
	function getModel ( )
	{
		return dModel;
	}
	
/*************************/
/******* Position ********/
	
	// SETS PLAYER POSITION TO GIVEN COORDINATES
	function setPosition ( x, y = null, z = null )
	{
		if( ( typeof ( x ) == "array" || typeof ( x ) == "table" ) && x.len ( ) == 3 && y == null && z == null )
		{
			if( x.rawin ( 0 ) && x.rawin ( 1 ) && x.rawin ( 2 ) )
			{
				y = x[1];
				z = x[2];
				x = x[0];
			}
			else if( x.rawin ( "x" ) && x.rawin ( "y" ) && x.rawin ( "z" ) )
			{
				if( x.rawin ( "rotation" ) )
					setRotation ( x.rotation );
				y = x.y;
				z = x.z;
				x = x.x;
			}
		}
		
		if ( !x || !y || !z )
			return false;
		
		return setPlayerPosition ( playerid, x.tofloat( ), y.tofloat( ), z.tofloat( ) );
	}
	
	// RETURNS PLAYER POSITION
	function getPosition ( )
	{
		return getPlayerPosition ( playerid );
	}
	
	// SETS PLAYER ROTATION
	function setRotation ( rotation = 0 )
	{
		return setPlayerRotation ( playerid, rotation.tofloat( ) );
	}
	
	// RETURNS PLAYER POSITION
	function getRotation ( )
	{
		return getPlayerRotation ( playerid );
	}
	
/*************************/
/******** Health *********/

	// SETS PLAYER HEALTH
	function setHealth ( health )
	{
		if ( health <= 0 )
			health = -1;
		else if ( health > 100 )
			health = 100;
		
		return setPlayerHealth ( playerid, health );
	}
	
	// RETURNS PLAYER HEALTH
	function getHealth ( )
	{
		local health = getPlayerHealth ( playerid );
		
		if ( health <= 0 )
			return 0;
		else if ( health > 100 )
			return 100;
		else
			return health;
	}
	
	// INCREASES PLAYER HEALTH BY GIVEN AMOUNT
	function increaseHealth ( h )
	{
		return setHealth ( getHealth( ) + h.tointeger ( ) );
	}
	
	// DECREACES PLAYER HEALTH BY GIVEN AMOUNT
	function decreaseHealth ( h )
	{
		return setHealth ( getHealth ( ) - h.tointeger ( ) );
	}
	
	// TOGGLES PLAYER HUD
	function toggleHUD ( t )
	{
		if ( typeof( t ) == "bool" )
		{
			togglePlayerHud ( playerid, t );
			return true;
		}
		return false;
	}
	
/*************************/
/******* Setttings *******/
	
	// TOGGLES PLAYER MESSAGES
	function togglePMsEnabled ( )
	{
		if ( arePMsEnabled() )
		{
			pmsEnabled = false;
			message ( "You have turned your PMs off." );
		}
		else
		{
			pmsEnabled = true;
			message ( "You have turned your PMs on." );
		}
	}
	
	// RETURNS WHETHER PLAYER MESSAGES ARE ENABLED
	function arePMsEnabled ( )
	{
		return pmsEnabled;
	}
	
	// RETURNS WHETHER IS AFK
	function isAFK ( )
	{
		return isafk;
	}
	
	// TOGGLES PLAYER AFK STATUS
	function setAFK ( b )
	{
		if ( typeof ( b ) == "bool" )
		{
			isafk = b;
			if ( isafk == false )
				setAFKMsg ( "" );
			return true;
		}
		return false;
	}
	
	// RETURNS PLAYER AFK MESSAGE
	function getAFKMsg ( )
	{
		return afkmsg;
	}
	
	// SETS PLAYER AFK MESSAGE
	function setAFKMsg ( m )
	{
		afkmsg = m.tostring ( );
		return true;
	}
	
	// KILLS THE PLAYER
	function kill ( )
	{
		setHealth ( 0 );
	}
	
	// RETURNS WHETHER PLAYER IS LOGGED-IN
	function isLoggedIn ( )
	{
		return userid > 0;
	}
	
	// GIVES PLAYER WEAPON WITH GIVEN AMMO AMOUNT
	function giveWeapon ( weaponid, ammo )
	{
		givePlayerWeapon (  playerid, weaponid, ammo );
		return true;
	}
	
	// RETURNS WEAPON NAME
	function getWeaponName ( )
	{
		return true;
	}
	
	// RETURNS AMMO AMOUNT FOR GIVEN WEAPON
	function getAmmo ( weapon )
	{
		return true;
	}
	
	// SETS AMMO FOR GIVEN WEAPON TO GIVEN AMOUNT
	function setAmmo ( weapon, ammo )
	{
		return true;
	}
	
	// REMOVES ALL WEAPONS FROM PLAYER
	function takeWeapons ( )
	{
		return true;
	}
	
	// SETS PLAYER MONEY
	function setMoney ( money )
	{
		if ( typeof ( money ) == "integer" && money >= 0 )
			return setPlayerMoney ( playerid, money );
		return false;
	}
	
	// RETURNS PLAYER MONEY
	function getMoney ( )
	{
		return getPlayerMoney ( playerid );
	}
	
	// INCREASE MONEY BY GIVEN AMOUNT
	function giveMoney ( money )
	{
		if ( typeof( money ) == "integer" && money > 0 )
			return setPlayerMoney ( playerid, money );
		return false;
	}
	
	// DECREACES MONEY BY GIVEN AMOUNT
	function takeMoney ( money )
	{
		if ( typeof( money ) == "integer" && money > 0 && getMoney ( ) - money >= 0 )
			return takePlayerMoney ( playerid, money );
		return false;
	}
	
	// SAVES PLAYER INFO
	function save ( )
	{
		return true;
		//local health = getHealth ( );
		//sql.query( "UPDATE users SET health = " + health + ", timeplayed = " + timeplayed );
	}
	
	// RETURNS DISTANCE BETWEEN PLAYER AND GIVEN POSITION
	function distance ( pos )
	{
		if ( isPlayerConnected ( playerid ) )
		{
			local lpos = getPosition( );
			if ( lpos )
			{
				return getDistanceBetweenPoints3D( lpos[0], lpos[1], lpos[2], pos[0].tofloat( ), pos[1].tofloat( ), pos[2].tofloat( ) );
			}
		}
		return false;
	}
	
	// RETURNS ARRAY WITH PLAYERS THAT ARE WITHIN THE GIVEN RANGE, DEFAULT RADIUS IS 20
	function nearbyPlayers ( from, range = 20 )
	{
		local pos = getPosition ( );
		local t = { };
		
		foreach ( player in players )
		{
			if ( isPlayerConnected ( player.getID ( ) ) )
			{
				local dist = player.distance( pos );
				if ( typeof ( dist ) != "bool" )
				{
					if ( player.distance ( pos ) <= range )
						t[player] <- player.distance ( pos );
				}
			}
		}
		return t;
	}
	
	// SENDS MESSAGE TO PLAYERS WITHIN GIVEN RANGE, DEFAULT RADIUS IS 20
	function localMessage ( text, range = 20 )
	{
		local nbPlayers = nearbyPlayers ( this, range );		
		foreach ( player, distance in nbPlayers )
			player.message ( text );
		
		return true;
	}
	
	// RETURNS ADMIN LEVEL
	function getAdmin ( )
	{
		return admin;
	}
	
	// SETS ADMIN LEVEL
	function setAdmin( admin )
	{
		if( typeof( admin ) != "integer" || admin < 0 || admin > 6 )
			return false;
		
		if( sql.query ( "UPDATE users SET admin = " + admin + " WHERE userID = " + userid ) )
		{
			this.admin = admin;
			return true;
		}
		return false;
	}
	
	// RETURN PLAYER ADMIN LEVEL AS TITLE STRING
	function getAdminTitle ( )
	{
		local ranks = { 
			[1] = "Tester", 
			[2] = "Moderator", 
			[3] = "Super Moderator", 
			[4] = "Administrator", 
			[5] = "Super Administrator", 
			[6] = "Lead Administrator",
			[7] = "Owner" 
		};
		
		if ( ranks.rawin ( getAdmin( ) ) )
			return ranks[ getAdmin( ) ]; 
		return false;
	}
	
	// RETURNS WHETHER PLAYER IN ON ADMIN DUTY
	function isOnAduty ( )
	{
		return aduty;
	}
	
	// RETURNS WHETHER PLAYER IS ON LOG-DUTY
	function isOnLogDuty ( )
	{
		return logduty;
	}
	
	// SETS PLAYER LOG DUTY
	function setLogDuty ( state )
	{
		logduty = state;
		
		foreach ( admin in all.admins ( ) )
		{
			if ( logduty )
				admin.message ( getName ( ) + " is not on Log-duty." );
			else
				admin.message ( getName ( ) + " is no longer on Log-duty." );
		}
			
		return logduty;
	}
	
	// SETS PLAYER ADMIN DUTY
	function setAduty ( state )
	{
		aduty = state;
		
		if ( aduty )
		{
			foreach ( admin in all.admins ( ) )
				admin.message ( getName ( ) + " is now on admin duty." );
		}
		else
		{
			if ( isOnLogDuty ( ) )
				setLogDuty ( false );
			foreach ( admin in all.admins ( ) )
				admin.message ( getName ( ) + " is no longer on admin duty." );
		
		}
		return aduty;
	}
	
	// SETS PLAYER SAVED POSITION
	function savePos ( )
	{
		savedpos = getPlayerPosition ( playerid );
	}
	
	// RETURNS PLAYER LOAD POSITION
	function loadPos ( )
	{	
		setPosition ( playerid, savedpos[0], savedpos[1], savedpos[2] );
	}	

	// RETRNS PLAYER INVENTORY INSTANCE
	function getInventory ( )
	{
		return inventory;
	}

	// UPDATES PLAYER ACTIVE TIME BY ONE MINUTES
	function updateMinute ( )
	{
		timeplayed ++;
	}
	
	// RETURNS PLAYER ACTIVE TIME IN HOURS
	function getHoursPlayed ( )
	{
		return ( timeplayed / 60 ).tointeger ( );
	}
	
	// RETURNS PLAYER ACTIVE TIME IN MINUTES
	function getMinutesPlayed ( )
	{
		return ( timeplayed ).tointeger ( );
	}
	
	// RETURNS PLAYER IP
	function getIP()
	{
		return getPlayerIp ( playerid );
	}
		
	// KICKS A PLAYER FROM THE SERVER
	function kick ( reason = "-", responsible = null )
	{
		local name = getName(  );
		if( !name )
			name = getPlayerName ( playerid );
		
		clearChat ( );
		message ( "YOU WERE KICKED FROM THE SERVER." );
		message ( "  Your Name: " + name + "." );
		
		if ( isLoggedIn ( ) )
			message( "  Your Account: " + getUserName ( ) + "." );
		message ( "  Admin: " + ( responsible == null ? "-" : responsible.getName ( ) ) + "." );
		message ( "  Reason: " + reason );
		
		kickPlayer ( playerid, true );
		
		if ( responsible )
			all.message ( "Admin Kick: " + responsible.getName ( ) + " kicked " + name + ". Reason: " + reason );
		else
			all.message ( "Admin Kick: " + name + " has been kicked. Reason: " + reason );
	}
	
	// BANS A PLAYER FROM THE SERVER
	function ban ( reason = "-", duration = 0, responsible = null )
	{
		local date = date ( );
		local name = getName ( );
		if ( !name )
			name = getPlayerName ( playerid );
		
		clearChat ( );
		message ( "YOU WERE BANNED FROM THE SERVER." );
		message ( "  Your Name: " + name + "." );
		
		if ( isLoggedIn ( ) )
			message ( "  Your Account: " + getUserName ( ) + "." );
		message ( "  Admin: " + ( responsible == null ? "-" : responsible.getName ( ) ) + "." );
		message ( "  Reason: " + reason );
		
		if ( duration == 0 )
			message ( "  Duration: Permanent." );
		else
			message ( "  Duration: " + duration + " hour" + ( duration != 1 ? "s" : "" ) + "." );
		
		banPlayer ( playerid, duration * 60 * 60 * 1000 );
		
		if ( responsible )
			all.message( "Admin Ban: " + responsible.getName ( ) + " banned " + name + ". Reason: " + reason );
		else
			all.message ( "Admin Ban: " + name + " has been banned. Reason: " + reason );
	}	
};

class CAllPlayers
{
	// SENDS MESSAGE TO ALL PLAYERS
	function message ( text, color = color.white, formatting = false )
	{
		foreach ( player in players )
			player.message ( text, color, formatting );
	}
	
	// FINDS A PLAYER
	function find ( player, name, needsToBeLoggedIn = true )
	{
		local found = []
		if ( name == "*" )
			found.push ( player );
		else if ( isNumeric ( name ) )
		{
			if ( players.rawin ( name.tointeger ( ) ) )
			{
				local other = players.rawget ( name.tointeger ( ) );
				if ( other )
					found.push ( other );
			}
		}
		else
		{
			for ( local i = 0; i < name.len ( ); i ++ )
				if ( name[i] == '_' )
					name = name.slice ( 0, i ) + " " + name.slice ( i + 1 );
			local name = name.tostring ( ).tolower ( );
			foreach ( other in players )
			{
				if ( other.getName ( ).tostring ( ).tolower ( ).find ( name ) != null )
					found.push ( other );
			}
		}
		
		if ( found.len( ) == 1 )
		{
			local other = found[0];
			if ( needsToBeLoggedIn )
			{
				local name = other.getName ( );
				if ( !name )
					name = getPlayerName ( other.getID ( ) );
				player.message ( name + " is not logged in." );
			}
			else
				return other;
		}
		else if ( found.len ( ) == 0 )
		{
			player.message ( "No player matches your search." );
		}
		else if ( found.len ( ) > 5 )
		{
			player.message ( found.len ( ) + " players match your search." );
		}
		else
		{
			player.message ( found.len ( ) + " players match your search:" );
			found.sort ( function ( a, b ) { return a.getID ( ) < b.getID ( ) ? -1 : 1; } );
			foreach ( other in found )
			{
				player.message ( "  (ID " + other.getID ( ) + ") " + other.getName ( ) );
			}
		}
		return false;
	}
	
	// RETURNS ARRAY WITH ADMINS AT OR ABOVE GIVEN ADMIN LEVEL, DEFAULT ADMIN LEVEL IS 1
	function admins ( level = 1 )
	{
		local t = [ ];
		foreach ( player in players )
			if ( player.getAdmin ( ) >= level )
				t.push ( player );
		return t;
	}
};

// CREATE ALL PLAYERS INSTANCE
all <- CAllPlayers;
