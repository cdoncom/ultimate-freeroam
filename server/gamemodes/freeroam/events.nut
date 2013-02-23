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

function onPlayerSpawn ( playerid )
{
	local player = SERVER.getworld ( ).getplayer ( playerid );
    SERVER.getworld ( ).spawnplayer ( player );
    return true;
}

function onPlayerDeath ( playerid, killerid, vehicleid )
{

	local world = SERVER.getworld ( );
	local message = "";
	local player = world.getplayer ( playerid );
		
	if ( playerid && killerid )
	{
		local killer = world.getplayer ( killerid );
		
		if ( playerid == killerid )
			message =  player.getname ( ) + " committed suicide.";
		else
		{
			killer.stats.kills++;
			killer.getaccount ( ).stats.kills++;
			message =  killer.getname ( ) + " killed " + player.getname ( ) + ".";
		}
	}
	else
		message = player.getname ( ) + "died.";
		
	player.stats.kills++;
	player.getaccount ( ).stats.kills++;
	return world.messageall ( message, Grayblue );
}

addEvent ( "playerDeath", onPlayerDeath );
addEvent ( "playerSpawn", onPlayerSpawn );