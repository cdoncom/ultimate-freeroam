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

class Player extends Element
{

	name = "";
	money = 0;
	usergroup = ID_GUEST;
	ip = "";
	serial = "";
	mute = false;
	freeze = false;
	inventory = false;
	chatchannel = false;
	vehicle = false;
	account = false;
	timeplayed = 0;
	afk = false;
	stats = { };
	
	constructor ( playerid )
	{
		this.name = getPlayerName ( playerid );
		this.id = playerid;
		this.type = "player";
		this.inventory = Inventory ( this );
		this.usergroup = SERVER.getusergroup ( 0 );
		this.stats.kills <- 0;
		this.stats.deaths <- 0;
		this.stats.killstreak <- 0;
	}
	
	function getname ( )
	{
		return name;
	}
	
	function setname ( )
	{
		this.name = name;
		setPlayerName ( this.id, name );
		return true;
	}
	
	function setserial ( serial )
	{
		this.serial = serial;
	}
	
	function setip ( ip )
	{
		this.ip = ip;
	}
	
	function setadmin ( level )
	{
		this.admin = level;
	}
	
	function setusergroup ( team )
	{
		this.usergroup = team;
	}
	
	function getname ( )
	{
		return name;
	}
	
	function getusergroup ( )
	{
		return usergroup;
	}
	
	function getmoney ( )
	{
		return money;
	}
	
	function getadmin ( )
	{
		return admin;
	}
	
	function ismuted ( )
	{
		return mute;
	}
	
	function isfrozen ( )
	{
		return freeze;
	}
	
	function setmute ( state )
	{
		if ( typeof ( state ) != "bool" )
			return false;
		
		this.mute = state;
		return true;
	}
	
	function setfrozen ( state )
	{
		if ( typeof ( state ) != "bool" )
			return false;
		
		togglePlayerFrozen ( this.id, state );
		this.freeze = state;
		return true;
	}
	
	function clearchat ( )
	{
		for ( local i = 0; i < 10; i++ )
		{
			message ( " " );
		}
	}
	
	function message ( text, color = false )
	{
		if ( !color )
			sendPlayerMessage ( this.id, text.tostring ( ) );
		else
			sendPlayerMessage ( this.id, text.tostring ( ), color );
			
		return true;
	}
	
	function randomspawn ( )
	{
		local gamemode = SERVER.getconfig ( ).gamemode.tointeger ( );
		local spawnpoint = false;
		
		if ( gamemode == 0 ) 
			spawnpoint = SERVER.getworld ( ).getmaphandler ( ).getmap ( "freeroam" ).randomspawnpoint ( );
		else if ( gamemode == 1 ) 
			spawnpoint = SERVER.getworld ( ).getmaphandler ( ).getmap ( "race" ).randomspawnpoint ( );
		else if ( gamemode == 2 ) 
			spawnpoint = SERVER.getworld ( ).getmaphandler ( ).getmap ( "roleplay" ).randomspawnpoint ( );
		else if ( gamemode == 3 ) 
			spawnpoint = SERVER.getworld ( ).getmaphandler ( ).getmap ( "tdm" ).randomspawnpoint ( );
		else if ( gamemode == 4 ) 
			spawnpoint = SERVER.getworld ( ).getmaphandler ( ).getmap ( "assult" ).randomspawnpoint ( );
			
		local pos = spawnpoint.getposition ( );
		setPlayerSpawnLocation ( this.id, pos[0], pos[1], pos[2], spawnpoint.getrotation( ) );
		return true;
	}
	
	function spawn ( x, y, z, rot )
	{
		setPlayerSpawnLocation ( this.id, x.tofloat ( ), y.tofloat ( ), z.tofloat ( ), rot.tofloat ( ) );
		return true;
	}
	
	function getinventory ( )
	{
		return inventory;
	}
	
	function joinchatchannel ( chatchannel )
	{
		this.chatchannel = chatchannel;
		return true;
	}
	
	function getchatchannel ( )
	{
		return chatchannel;
	}
	
	function isdriving ( )
	{
		if ( !vehicle )
			return false;
		return true;
	}
	
	function getposition ( )
	{
		return getPlayerCoordinates ( this.id );
	}
	
	function getrotation ( )
	{
		return getPlayerHeading ( this.id );
	}
	
	function entervehicle ( vehicle )
	{
		this.vehicle = vehicle;
		return true;
	}
	
	function exitvehicle ( )
	{
		this.vehicle = false;
		return true;
	}
	
	function getvehicle ( )
	{
		return vehicle;
	}
	
	function login ( account )
	{
		this.account = account;
		callEvent ( "playerLogin", this, account );
		return true;
	}
	
	function logout ( )
	{
		if ( this.account != false )
			callEvent ( "playerLogout", this, this.account );
			
		this.account = false;
		return true;
	}
	
	function giveweapon ( wid, ammo )
	{
		return givePlayerWeapon ( this.id, wid, ammo );
	}
	
	function setskin ( sid )
	{
		return setPlayerModel ( this.id, sid );
	}
	
	function kill ( )
	{
		return setPlayerHealth ( this.id, -1 );
	}
	
	function setposition ( x, y, z )
	{
		return setPlayerCoordinates ( this.id, x, y, z );
	}
	
	function isloggedin ( )
	{
		if ( this.account == false )
			return false;
		else
			return true;
	}
	
	function getserial ( )
	{
		return getPlayerSerial ( this.id );
	}
	
	function getip ( )
	{
		return getPlayerIp ( this.id );
	}
	
	function getaccount ( )
	{
		return account;
	}
	
	function gethealth ( )
	{
		return getPlayerHealth ( this.id );
	}
	
	function sethealth ( var )
	{
		return setPlayerHealth ( this.id, var );	
	}
	
	function setarmour ( var )
	{
		return setPlayerArmour ( this.id, var );
	}
	
	function getarmour ( )
	{
		return getPlayerArmour ( this.id );
	}
	
	function givemoney ( amount )
	{
		return givePlayerMoney ( this.id, amount.tointeger ( ) );
	}
	
	function initplayeracs ( )
	{
		setPlayerInvincible ( this.id, true );
	}
	
	function exitplayeracs ( )
	{
		setPlayerInvincible ( this.id, false );
	}
	
	function adminmode ( state )
	{
		this.adminstate = state;
		
		if ( this.adminstate == true )
			initplayeracs ( );
		else if ( this.adminstate == false )
			exitplayeracs ( );
		else
		{
			this.adminstate = false;
			return false;
		}
			
		return true;
	}
	
	function updateminute ( )
	{
		timeplayed ++;
		this.account.updateminute ( );
		return true;
	}
	
	function gethoursplayed ( )
	{
		return ( timeplayed / 60 ).tointeger ( );
	}
	
	function getminutesplayed ( )
	{
		return timeplayed.tointeger ( );
	}
	
	function setafk ( state )
	{
		if ( typeof ( state ) != "bool" )
			return false;
		
		this.afk = state;
		return true;
	}
	
	function isafk ( )
	{
		return afk;
	}
	
};