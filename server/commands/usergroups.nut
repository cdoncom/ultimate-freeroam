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
 
registerCommand ( "createteam",
	function ( player, params )
	{
		if ( params.len ( ) != 1 )
			return player.message ( "Inappropriate command parameters. Please use /creategroup <groupname> .", Red );
			
		local group = SERVER.createusergroup ( params[0] );
		if ( group )
			return player.message ( "You created a new usergroup with the name '" + group.getname ( ) + "'.", Orange );
		
		return player.message ( "An error occurred in creating a team.", Red );
	},
	3
);

registerCommand ( "myteam",
	function ( player, params )
	{
		player.message ( "Your team: " + player.getusergroup ( ).getname ( ), Gray );
	},
	0
);

registerCommand ( "setteam",
	function ( player, params )
	{
		if ( params.len ( ) != 2 )
			return player.message ( "Inappropriate command parameters. Please use /setteam <playerid> <groupname> .", Red );
			
		local target = getPlayer ( params[0] );	
		if ( !target )
			return player.message ( "Invalid player selected.", Red );
			
		local group = getUsergroup ( params[1] );
		if ( !group )
			return player.message ( "Invalid usergroup selected.", Red );

		SERVER.getacs ( ).moveusergroups ( player, target, group );
		return true;
	},
	3
);