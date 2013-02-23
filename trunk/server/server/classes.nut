/*
 * Copyright (c) 2013, TheGhost
 *
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright notice, this
 *       list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright notice, this
 *       list of conditions and the following disclaimer in the documentation and/or other
 *       materials provided with the distribution.
 *     * Neither the name of the product nor the names of its contributors may be used
 *       to endorse or promote products derived from this software without specific prior
 *       written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

class Utility
{

	constructor ( )
	{
		
	}
	
	function concat ( params )
	{
		local text = "";
		foreach ( bloc in params )
		{
			text = text + " " + bloc.tostring ( );
		}
		return text;
	}
	
	function shuffle ( table )
	{
		local ntable = { };
		foreach ( s in table )
		{
			local q = false;
			while ( q == false )
			{
				local r = random ( 0, table.len ( ) - 1 );
				if ( !ntable.rawin ( r ) )
				{
					ntable[r] <- s;
					q = true;
				}
			}	
		}
		return ntable;
	}
	
	function replace ( string, a, b )
	{
		local pos = null;
		while ( ( pos = string.find ( a ) ) != null )
		{
			string = string.slice ( 0, pos ) + b + string.slice ( pos + a.len ( ) );
		}
		return string;
	}
	
	function randomstring ( length, onlyDigits = false )
	{
		local str = "";
		local rnd;
		if ( onlyDigits == false )
			for ( local i = 0; i < length; ++i )
			{
				rnd = random ( 0, 35 );
				if ( rnd < 10 )
				{	
					rnd += 48;
				}
				else	
					rnd += 55;
				str += rnd.tochar ( );
			}
		else
			for ( local i = 0; i < length; ++i )
			{
				rnd = random( 0, 9 );
				rnd += 48;
				str += rnd.tochar ( );
			}
		return str;
	}
	
	function gettimeasstring ( )
	{
		local h = date ( ).hour;
		local m = date ( ).min;
		local hour = ( h > 12 ) ? ( h - 12 ).tostring ( ) : h.tostring ( );
		local minute = ( m < 10 ) ? "0" + m.tostring ( ) : m.tostring ( );
		local suf = ( h > 11 ) ? "PM" : "AM";
		local str = hour + ":" + minute + " " + suf;
		return str;
	}
	
	function cleanup ( table )
	{
		local i = 0;
		local table2 = { }
		foreach ( key in table )
		{
			table2[i] <- key;
			++i;
		}
		table.clear ( );
		return table2;
	}
	
	function hashforpass ( string, salt = false )
	{
		local str = "";
		
		// default, no forums integration
		if ( SERVER.getconfig ( ).acctype == 0 )
		{
			if ( !salt )
				salt = randomstring ( 10 );
			
			str = md5 ( str );
			str = str.tolower ( ) + salt;
			str = md5 ( str ).tolower ( );
			
			return [ str, salt ];
		}
		// phpBB integration
		else if ( SERVER.getconfig ( ).acctype == 1 )
		{
			return [ str, salt ];
		}
		
		// vBulletin integration
		else if ( SERVER.getconfig ( ).acctype == 2 )
		{
			if ( !salt )
				salt = randomstring ( 10 );
				
			str = md5 ( str );
			str = str.tolower ( ) + salt;
			str = md5 ( str ).tolower ( );
			
			return [ str, salt ];
		}
		
		// IPB integration
		else if ( SERVER.getconfig ( ).acctype == 3 )
		{
			return [ str, salt ];
		}
		else
			return [ str, salt ];
	}
};

class Serverdata
{
	
	record = { };
	usedcommands = { };
	events = { };
	counter = 0;
	
	constructor ( )
	{
		
	}
	
	function savedata ( )
	{
		record[ SERVER.util.gettimeasstring ( ) ] <- SERVER.util.cleanup ( usedcommands );
		
		//EVERY 4 HOURS
		if ( record.len ( ) == 4 )
		{
			//local ini = EasyINI( GetPlayerName(playerid) + ".ini");
		}
		return true;
	}
	
	function processcommand ( commandname, playername )
	{
		local commandtable = false;
		if ( !usedcommands.rawin ( commandname ) )
			usedcommands[commandname] <- [ ];
		
		local stamp = [ SERVER.util.gettimeasstring ( ), playername ];
		usedcommands[commandname].push ( stamp );
		commandtable = usedcommands[commandname];
		return stamp;
	}
	
	function processevent ( eventname )
	{
	
	}
	
	function timestamp ( )
	{
		
	}
	
	function update ( )
	{
		this.counter++;
		
		// EVERY HOUR
		if ( this.counter % 60 == 0 )
		{
			savedata ( );
			this.counter = 0;
		}
		return true;
	}
	
};

class Server
{

	config = { };
	accounthandler = false;
	world = false;
	chatserver = false;
	missionhandler = false;
	acs = false;
	math = false;
	commandhandler = { };
	util = false;
	usergrouphandler = [ ];
	eventhandler = { };
	servertimer = false;
	updatecounter = 0;
	datahandler = false;
	gamemode = false;
	
	constructor ( )
	{
		loadconfig ( );
		math = Math ( );
		util = Utility ( );
		world = World ( );
		datahandler = Serverdata ( );
	}
	
	function getconfig ( )
	{
		return config;
	}
	
	function loadconfig ( )
	{
		local xfile = xml ( "settings.xml" );
		
		// Load gamemode settigns
		xfile.nodeFind ( "gamemode" );
		config.gamemode <- xfile.nodeContent (  );
		xfile.nodeParent ( );
		
		// Load chatserver settings filename
		xfile.nodeFind ( "accounts" );
		config.acctype <- xfile.nodeContent (  ).tointeger ( );
		if ( config.acctype == 0 )
		{
			// Load database connection settings
			xfile.nodeFind ( "database" );
			config.dbtype <- xfile.nodeAttribute ( "type" );
			config.ip <- xfile.nodeAttribute ( "ip" );
			config.user <- xfile.nodeAttribute ( "user" );
			config.pass <- xfile.nodeAttribute ( "pass" );
			config.db <- xfile.nodeAttribute ( "db" );
			config.usertable <- xfile.nodeAttribute ( "usertable" );
			config.grouptable <- xfile.nodeAttribute ( "grouptable" );
			config.statstable <- xfile.nodeAttribute ( "statstable" );
			xfile.nodeParent ( );
		}
		else if ( config.acctype == 1 )
		{
			xfile.nodeFind ( "xmlfile" );
			config.xmlfile <- xfile.nodeContent ( );
			xfile.nodeParent ( );
		}
		xfile.nodeParent ( );
		
		// Load chatserver settings filename
		xfile.nodeFind ( "chatfile" );
		config.chatfile <- xfile.nodeContent (  );
		xfile.nodeParent ( );
		
		// Load acs settings filename
		xfile.nodeFind ( "acs" );
		config.acs <- xfile.nodeContent (  );
		xfile.nodeParent ( );
		
		// Load map files
		config.maps <- [ ];
		xfile.nodeFind ( "maps" );
		xfile.nodeFirstChild ( );
		while ( true )
		{
			if ( xfile.nodeName ( ) == "map" )
			{
				local data = {
					state = xfile.nodeAttribute ( "start" ),
					name = xfile.nodeContent ( ).tostring ( )
				};
				
				config.maps.push ( data );
				if ( !xfile.nodeNext ( ) )
					break;
			}
		}

		return config;
	}
	
	function getdatahandler ( )
	{
		return datahandler;
	}
	
	function inittimer ( )
	{
		this.servertimer =  Timer (
			function ( )
			{
				SERVER.updatecounter = ( SERVER.updatecounter + 1 ) % 60
						
				// EVERY MINUTE
				if ( SERVER.updatecounter % 12 == 0 )
				{
					SERVER.datahandler.update ( );
					
					foreach ( id, player in SERVER.getworld ( ).getplayers ( ) )
					{
						if ( player != false )
							player.updateminute ( );
					}
				}
						
				// EVERY THREE MINUTES
				if ( SERVER.updatecounter % 36 == 0 )
				{
					foreach ( id, player in SERVER.getworld ( ).getplayers ( ) )
					{	
						if ( player )
							player.getaccount ( ).updateaccount ( );
					}
				}
			},
			5000,
			-1
		);	
	}
	
	function createworld ( )
	{
		this.world = World ( );
		return true;
	}
	
	function getworld ( )
	{
		return world;
	}
	
	function initchatserver ( )
	{
		this.chatserver = Chatserver ( );
		return true;
	}
	
	function getchatserver ( )
	{
		return chatserver;
	}
	
	function getcmdhandler ( )
	{
		return commandhandler;
	}
	
	function geteventhandler ( )
	{
		return eventhandler;
	}
	
	function addcommand ( command, handler, adminlevel )
	{
		commandhandler[command] <- { func = handler, perm = adminlevel };
		return true;
	}
	
	function addevent ( event, handler )
	{
		eventhandler[event] <- { func = handler };
		return true;
	}
	
	function execute ( command, params, player )
	{
		if ( commandhandler.rawin ( command ) )	
		{
			if ( !player.isloggedin ( ) )
			{
				if ( commandhandler[command].perm > 0 )
					player.message ( "Insufficent permissions to use this command.", Red );
				else
					return commandhandler[command].func ( player, params );
			}
			else
			{
				if ( player.getaccount ( ).getadminlevel ( ) < commandhandler[command].perm  )
					player.message ( "Insufficent permissions to use this command.", Red );
				else
					return commandhandler[command].func ( player, params );
			}
		}
		else
			return false;
	}
	
	function initaccounthandler ( )
	{
		accounthandler = AccountHandler ( );
		accounthandler.initaccounts ( );
	}
	
	function getaccounthandler ( )
	{
		return accounthandler;
	}
	
	function initusergroups ( )
	{
		/*local usergroups = sql.query_assoc ( "SELECT * FROM " + SERVER.getconfig ( ).grouptable );
		foreach ( group in usergroups )
			usergrouphandler.push ( Usergroup ( group ) );*/
	}
	
	function getusergroup ( groupname )
	{
		if ( typeof ( groupname ) == "string" ) 
		{
			foreach ( usergroup in usergrouphandler )
			{
				if ( usergroup.getname ( ) == groupname )
					return usergroup;
			}
			return false;
		}
		else if ( typeof ( groupname ) == "integer" )
		{
			foreach ( usergroup in usergrouphandler )
			{
				if ( usergroup.getid ( ) == groupname )
					return usergroup;
			}
			return false;
		}
		
		return false;	
	}
	
	function createusergroup ( groupname )
	{
		/*local result = sql.query_insertid ( "INSERT into " + SERVER.getconfig ( ).grouptable + " ( groupname ) VALUES ( '" + sql.escape ( groupname ) + "' )" );
		if ( result )
			return usergrouphandler.push ( Usergroup ( { id = result, groupname = groupname } ) );
		return false;*/
	}
	
	function initacs ( )
	{
		this.acs = ACS ( );
	}
	
	function getacs ( )
	{
		return acs;
	}
	
};

class World
{	

	maphandler = false;
	players = array ( getPlayerSlots ( ), false );

	constructor ( )
	{
		foreach ( playerid, name in getPlayers ( ) )
			playerjoin ( playerid );
	}
	
	function getweather ( )
	{
		return getWeather ( );
	}
	
	function setweather ( id )
	{
		return setWeather ( id );
	}
	
	function getmaphandler ( )
	{
		return maphandler;
	}
	
	function initmaphandler ( )
	{
		maphandler = MapHandler ( );
		maphandler.loadmaps ( );
		return true;
	}
	
	function createmap ( mapname )
	{
		maphandler.newmap ( mapname );
		return true;
	}
	
	function playerjoin ( playerid )
	{
		this.players [ playerid ] = Player ( playerid );
		return this.players [ playerid ];
	}
	
	function playerleave ( playerid )
	{
		
		local player = players [ playerid ];
		
		player.getchatchannel ( ).removemember ( player );
		logoutPlayer ( player, player.getaccount ( ) );
		players [ playerid ] = false;
		return true;
		
	}
	
	function getplayers ( )
	{
		return players;
	}
	
	function getplayer ( var )
	{
		if ( typeof ( var ) == "integer" )
			return this.players [ var ];
		else if ( typeof ( var ) == "string" )
		{
			if ( SERVER.math.isnumeric ( var ) )
				return this.players [ var.tointeger ( ) ];
			else
			{
				foreach ( k, v in getplayers ( ) )
				{
					if ( v.getname ( ).tolower ( ) == var.tolower ( ) )
						return v;
				}
				return false;
			}
		}
	}
	
	function messageall ( text, color = false )
	{
		foreach ( id, player in players )
		{
			if ( isPlayerConnected ( id ) )	
				player.message ( text, color );
		}
	}
	
	function spawnplayer ( player, x = false, y = false, z = false, rot = false )
	{
		if ( x == false || y == false || z == false || rot == false )
			player.randomspawn ( );
		else
			player.spawn ( x, y, z, rot );
		
		return true;
	}
	
	function getnearbyplayers ( element, range = 20 )
	{
		local pos = element.getposition ( );
		local t = [ ];
		
		foreach ( target in SERVER.getworld ( ).getplayers ( ) )
		{
			local distance = SERVER.math.distance ( pos, target.getposition ( ) );
			if ( typeof ( distance ) == "integer" )
			{
				if ( distance <= range )
					t.push ( target );
			}
		}
		return t;
	}
	
};

function loadGamemode ( )
{
	local _g = SERVER.getconfig ( ).gamemode.tointeger ( );
	if ( _g == 0 )
		dofile ( "scripts/gamemodes/freeroam/main.nut" );
	else if ( _g == 1 )
		dofile ( "scripts/gamemodes/race/main.nut" );
	else if ( _g == 2 )
		dofile ( "scripts/gamemodes/roleplay/main.nut" );
	else if ( _g == 3 )
		dofile ( "scripts/gamemodes/tdm/main.nut" );
	else if ( _g == 4 )
		dofile ( "scripts/gamemodes/assault/main.nut" );
	
	//callEvent ( "gamemodeStart", _g );
	return true;
}