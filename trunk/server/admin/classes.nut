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
 
class ACS
{

	constructor ( )
	{
	
	}
	
	function logaction ( text )
	{
		local xfile = file ( "acs/" + SERVER.getconfig ( ).acs.tostring ( ), "a+" );
		local stamp = date ( );
		local line = "[" + stamp.month.tostring ( ) + "/" + stamp.day.tostring ( ) + "/" + stamp.year.tostring ( ) + " || " + stamp.hour.tostring ( ) + ":" + stamp.min.tostring ( ) + "] " + text.tostring ( );
				
		foreach ( char in line ) 
			xfile.writen ( char, 'c');	
		
		xfile.writen('\n', 'c');		
		return true;
	}
	
	function slapplayer ( admin, player )
	{
		local pos = player.getposition ( );
		player.sethealth ( player.gethealth ( ) - 20 );
		player.setposition ( pos[0], pos[1], pos[2] + 1 );
		player.message ( "You have been slapped by admin.", Red );
		admin.message ( "You have slapped " + player.getname ( ), Orange );
		logaction ( admin.getname ( ) + " has slapped " + player.getname ( ) + "." );
		callEvent ( "playerSlapped", player );
		return true;
	}
	
	function warnplayer ( admin, player, message )
	{
		player.message ( "Admin has sent you a warning: " + message.tostring ( ) );
		admin.message ( "You sent " + player.getname ( ) + " a warning: " + message.tostring ( ) );
		logaction ( admin.getname ( ) + " has sent " + player.getname ( ) + " a warning: " + message.tostring ( ) + "." );
		return true;
	}
	
	function adminkill ( admin, player )
	{
		player.sethealth ( -1 );
		admin.message ( "You have admin-killed " + player.getname ( ), Orange );
		player.message ( "You have been admin-killed.", Red );
		logaction ( admin.getname ( ) + " has admin-killed " + player.getname ( ) + "." );
		return true;
	}
	
	function sethealth ( admin, player, amount )
	{
		player.sethealth ( amount.tointeger ( ) );
		player.message ( "Your health has been set to " + amount + " by admin.", Red );
		admin.message ( "You have set " + player.getname ( ) + "'s health to " + amount + ".", Orange );
		logaction ( admin.getname ( ) + " has set " + player.getname ( ) + "'s health to " + amount.tostring ( ) + "." );
		return true;
	}
	
	function setarmour ( admin, player, amount )
	{
		player.setarmour ( amount.tointeger ( ) );
		player.message ( "Your armour has been set to " + amount + " by admin.", Red );
		admin.message ( "You have set " + player.getname ( ) + "'s armour to " + amount + ".", Orange );
		logaction ( admin.getname ( ) + " has set " + player.getname ( ) + "'s armour to " + amount.tostring ( ) + "." );
		return true;
	}
	
	function muteplayer ( admin, player )
	{
		player.setmute ( true );
		player.message ( "You have been muted by admin.", Red );
		admin.message ( "You have muted " + player.getname ( ), Orange );
		logaction ( admin.getname ( ) + " has muted " + player.getname ( ) + "." );
		callEvent ( "playerMute", player, true );
		return true;
	}
	
	function unmuteplayer ( admin, player )
	{
		player.setmute ( false );
		player.message ( "You have been unmuted by admin.", Red );
		admin.message ( "You have unmuted " + player.getname ( ), Orange );
		logaction ( admin.getname ( ) + " has unmuted " + player.getname ( ) + "." );
		callEvent ( "playerMute", player, false );
		return true;
	}
	
	function freezeplayer ( admin, player )
	{
		player.setfrozen ( true );
		player.message ( "You have been froze by admin.", Red );
		admin.message ( "You have froze " + player.getname ( ), Orange );
		logaction ( admin.getname ( ) + " has froze " + player.getname ( ) + "." );
		callEvent ( "playerFreeze", player, true );
		return true;
	}
	
	function unfreezeplayer ( admin, player )
	{
		player.setfrozen ( false );
		player.message ( "You have been unfroze by admin.", Red );
		admin.message ( "You have unfroze " + player.getname ( ), Orange );
		logaction ( admin.getname ( ) + " has unfroze " + player.getname ( ) + "." );
		callEvent ( "playerFreeze", player, false );
		return true;
	}
	
	function givemoney ( admin, player, amount )
	{
		player.givemoney ( amount.tointeger ( ) );
		player.message ( "Admin has given you $" + amount.tostring ( ) );
		admin.message ( "You have given " + player.getname ( ) + " $" + amount.tostring ( ) );
		logaction ( admin.getname ( ) + " has given " + player.getname ( ) + " $" + amount.tostring ( ) + "." );
		return true;
	}
	
	function giveweapon ( admin, player, wepid, amount )
	{
		player.giveweapon ( wepid, amount );
		player.message ( "Admin has given you a " + getWeaponName ( wepid ) + " with " + amount.tostring ( ) + " rounds." );
		admin.message ( "You have given " + player.getname ( ) + " a " + getWeaponName ( wepid ) + " with " + amount.tostring ( ) + " rounds." );
		logaction ( admin.getname ( ) + " has given " + player.getname ( ) + " a " + getWeaponName ( wepid ) + " with " + amount.tostring ( ) + " rounds." );
		return true;
	}
	
	function goto ( admin, player )
	{
		if ( player.isdriving ( ) )
			warpPlayerIntoVehicle ( admin.getid ( ), player.getvehicle ( ).getid ( ) );
		else
		{
			local pos = player.getposition ( );
			admin.setposition ( pos[0], pos[1], pos[2] + 1 );
		}
		
		player.message ( "Admin has warped to you." );
		admin.message ( "You have warped to " + player.getname ( ) + "." );
		logaction ( admin.getname ( ) + " has warped to " + player.getname ( ) + "." );
		return true;
	}
	
	function deletevehicle ( admin )
	{
		//local vehicle = admin.getvehicle ( );
	}
	
	function moveusergroups ( admin, player, group )
	{
		player.getusergroup ( ).removemember ( player );
		player.setusergroup ( group );
		group.addmember ( player );
		player.message ( "Admin has moved you to " + group.getname ( ) + ".", Red );
		admin.message ( "You have moved " + player.getname ( ) + " to " + group.getname ( ) + ".", Orange );
		logaction ( admin.getname ( ) + " has moved " + player.getname ( ) + " to " + group.getname ( ) + "." );
		return true;
	}
	
};