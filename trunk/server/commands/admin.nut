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
 
registerCommand ( "slap",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /slap <playerid> .", Red );
			
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).slapplayer ( player, target );
		return true;
	},
	2
);

registerCommand ( "warn",
	function ( player, params )
	{
	
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
		
		params.remove ( 0 );
		SERVER.getacs ( ).warnplayer ( player, target, SERVER.util.concat ( params ) );
		return true;
	},
	2
);

registerCommand ( "freeze",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /freeze <playerid> .", Red );
	
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).freezeplayer ( player, target );
		return true;
	},
	2
);

registerCommand ( "unfreeze",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /unfreeze <playerid> .", Red );
	
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).unfreezeplayer ( player, target );
		return true;
	},
	2
);

registerCommand ( "kick",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /kick <playerid> .", Red );
	
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		return true;
	},
	2
);


registerCommand ( "ban",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /ban <playerid> .", Red );
	
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		return true;
	},
	3
);

registerCommand ( "sethealth",
	function ( player, params )
	{
		if ( params.len ( ) != 2 )
			return player.message ( "Inappropriate command parameters. Please use /sethealth <playerid> <ammount> .", Red );
		
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).sethealth ( player, target, params[1] );
		return true;
	},
	2
);

registerCommand ( "setarmour",
	function ( player, params )
	{
		if ( params.len ( ) != 2 )
			return player.message ( "Inappropriate command parameters. Please use /setarmour <playerid> <ammount> .", Red );
		
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).setarmour ( player, target, params[1] );
		return true;
	},
	2
);

registerCommand ( "mute",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /mute <playerid> .", Red );
	
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).muteplayer ( player, target );
		return true;
	},
	2
);

registerCommand ( "unmute",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /unmute <playerid> .", Red );
		
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).unmuteplayer ( player, target );
		return true;
	},
	2
);

registerCommand ( "createchannel",
	function ( player, params )
	{
	
	},
	3
);

registerCommand ( "warp",
	function ( player, params )
	{
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		return true;
	},
	2
);

registerCommand ( "acs", 
	function ( player, params )
	{
		
	},
	4
);

registerCommand ( "akill", 
	function ( player, params )
	{
		if ( !params[0] )
			return player.message ( "Use /akill <playerid>", Red );
			
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
		
		SERVER.getacs ( ).adminkill ( player, target );
		return true;
	},
	2
);

registerCommand ( "givemoney",
	function ( player, params )
	{
		if ( params.len ( ) != 2 )
			return player.message ( "Inappropriate command parameters. Please use /givemoney <playerid> <ammount> .", Red );
		
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).givemoney ( player, target, params[1] );
		return true;
	},
	2
);

registerCommand ( "giveweapon",
	function ( player, params )
	{
		if ( params.len ( ) != 3 )
			return player.message ( "Inappropriate command parameters. Please use /giveweapon <playerid> <weapon> <ammount> .", Red );
		
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		SERVER.getacs ( ).giveweapon ( player, target, params[1] );
		return true;
	},
	2
);

registerCommand ( "goto", 
	function ( player, params )
	{
		if ( !params[0] )
			return player.message ( "Use /goto <playerid>", Red );
			
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
		
		SERVER.getacs ( ).goto ( player, target );
		return true;
	},
	2
);

registerCommand ( "dv",
	function ( player, params )
	{
		if ( !player.isdriving ( ) )
			return player.message ( "You are not in any vehicle!", Red );
			
		SERVER.getacs ( ).deletevehicle ( player );
		return true;
	},
	2
);