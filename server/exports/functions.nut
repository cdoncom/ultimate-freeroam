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
 
function registerEvent ( eventname, handler, source )
{
	
}

function registerCommand ( commandname, handler, adminlevel = 0 )
{
	if ( !SERVER.getcmdhandler ( ).rawin ( commandname ) )
		SERVER.addcommand ( commandname, handler, adminlevel );
	else
		return false;
		
	return true;
}

function isElement ( element )
{
	if ( !element.type )
		return false;
	
	switch ( element.gettype ( ) )
	{
		case "player":
			return true;
			break;
		case "vehicle":
			return true;
			break;
		case "blip":
			return true;
			break;
		case "checkpoint":
			return true;
			break;
		case "ped":
			return true;
			break;
		case "house":
			return true;
			break;
		case "usergroup":
			return true;
			break;
		case "pickup":
			return true;
			break;
		case "spawnpoint":
			return true;
			break;
		case "object":
			return true;
			break;
		case "account":
			return true;
			break;
		case "timer":
			return true;
			break;
		default:
			return false;
	}
	return false;
}

function createElement ( element_type, a = false, b = false, c = false, d = false, e = false, f = false, g = false, h = false )
{
	if ( !element_type )
		return false;
		
	if ( typeof ( element_type ) == "string" )
	{
		switch ( element_type )
		{
			case "vehicle":
				if ( a != false && b != false && c != false )
					return elements.vehicles[elements.vehicles.len()] <- Vehicle ( a, b, c );
				break;
			case "ped":
				if ( a != false && b != false && c != false && d != false )
					return elements.peds[elements.peds.len()] <- Ped ( a, b, c, d );
				break;
			case "pickup":
				if ( a != false && b != false && c != false && d != false )
					return elements.pickups[elements.pickups.len()] <- Pickup ( a, b, c, d );
				break;
			case "house":
				if ( a != false && b != false && c != false && d != false && e != false && f != false )
					return elements.houses[elements.houses.len()] <- House ( elements.houses.len(), a, b, c, d, e, f );
				break;
			case "blip":
				if ( a != false && b != false && c != false && d != false )
					return elements.blips[elements.blips.len()] <- Blip ( a, b, c, d );
				break;
			case "checkpoint":
				if ( a != false && b != false && c != false && d != false && e != false && f != false && g != false )
					return elements.checkpoints[elements.checkpoints.len()] <- Checkpoint ( a, b, c, d, e, f, g );
				break;
			case "timer":
				if ( a != false && b != false && c != false )
					return elements.timers[elements.timers.len()] <- Timer ( elements.timers.len(), a, b, c );
				break;
			case "spawnpoint":
				if ( a != false && b != false && c != false && d != false )
					return elements.spawnpoints[elements.spawnpoints.len()] <- Spawnpoint ( elements.spawnpoints.len(), a, b, c, d );
				break;
			case "object":
				if ( a != false && b != false && c != false && d != false && e != false && f != false && g != false )
					return elements.objects <- Object ( a, b, c, d, e, f, g );
				break;
			default:
				return false;
		}
	}else{
		return false;
	}
}

function getElementPosition ( element )
{
	if ( !isElement ( element ) )
		return false;
	
	local pos;
	switch ( element.getType ( ) )
	{
		case "player":
			pos = element.getposition ( );
			break;
		case "vehicle":
			pos = element.getposition ( );
			break;
		case "object":
			pos = getObjectCoordinates ( element.id );
			break;
		case "checkpoint":
			pos = element.getPosition();
			break;
		case "blip":
			pos = getBlipCoordinates ( element.id );
			break;
		case "pickup":
			pos = getPickupCoordinates ( element.id );
			break;
		case "house":
			return { [0] = element.pos[0], [1] = element.pos[1], [2] = element.pos[2] };
			break;
		case "spawnpoint":
			return element.getposition ( );
			break;
		default:
			return false;
	}
	return pos;
}

function isAccount ( account )
{
	if ( !account.getname ( ) )
		return false;

	return SERVER.getaccounthandler ( ).getaccount ( account.getname ( ) );
}

function getAccounts ( )
{
	return SERVER.getaccounthandler ( ).getaccounts( );
}

function getAccount ( var )
{
	local account = SERVER.getaccounthandler ( ).getaccount ( var );
	if ( account )
		return account;
	return false;
}

// Creates a new account
function addAccount ( username, password, serial = "", ip = "" )
{
	local account = SERVER.getaccounthandler ( ).insertaccount ( username, password, serial, ip );
	if ( account )
		return account;
	return false;
}


// Returns hashed password
function getAccountPassword ( account )
{
	if ( !account.getname ( ) )
		return false;
		
	if ( !SERVER.getaccounthandler ( ).getaccount ( account.getname ( ) ) )
		return false;
		
	return account.getpassword ( );
	
}

function setAccountPassword ( account, password )
{
	if ( !SERVER.getaccounthandler ( ).getaccount ( account.getname ( ) ) )
		return false;
		
	return account.setpassword ( password );
}

function getUsergroup ( var )
{
	local usergroup = SERVER.getusergroup ( var );
	if ( usergroup )
		return usergroup;
	return false;
}

function getRandomNumber ( min = 0, max = RAND_MAX )
{
	return SERVER.math.random ( min, max );
}

function spawnPlayer ( player, x = false, y = false, z = false, rot = false )
{
	return SERVER.getworld ( ).spawnplayer ( player, x, y, z, rot );
}

function loginPlayer ( player, account, auto = false )
{
	if ( !player || !account )
		return false;
		
	player.login ( account );
	account.assignplayer ( player );
			
	local usergroup = false;
	if ( account.getusergroup ( ) )
		usergroup = SERVER.getusergroup ( account.getusergroup ( ) );
	
	if ( usergroup )
	{
		player.setusergroup ( usergroup );
		
		if ( !auto )
			player.message ( "You have logged in! Usergroup: " + usergroup.getname ( ) );
		else
			player.message ( "You have been auto-logged. Usergroup: " + usergroup.getname ( ) );
			
		return true;
	}
	else
		return false;
}

function logoutPlayer ( player, account )
{
	player.logout ( );
	account.unassignplayer ( );
	player.setusergroup ( SERVER.getusergroup ( 1 ) );
	player.message ( "You have logged out of your account." );
	return true;
}

function joinChatChannel ( player, channel )
{
	if ( !player.getchatchannel ( ) )
	{

	}	
	else
		player.getchatchannel ( ).removemember ( player );
		
	channel.addmember ( player );
	player.joinchatchannel ( channel );
		
	return true;
}

function getPlayer ( var )
{
	return SERVER.getworld ( ).getplayer ( var );
}

function getVehicle ( id )
{
	if ( typeof ( id ) != "integer" )
		return false;
	
	foreach ( k, map in SERVER.getworld ( ).getmaphandler ( ).maps )
	{
		foreach ( i, vehicle in map.vehicles )
		{
			if ( vehicle.getid ( ) == id )
				return vehicle;
		}
	}
	
	return false;
}

function getUsergroup ( var )
{
	return SERVER.getusergroup ( var );
}