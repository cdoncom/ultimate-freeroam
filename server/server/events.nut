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

function onScriptInit ( )
{	
	
}

function onServerRecieve ( data_type, data = false )
{
	switch ( data_type )
	{
		case ID_SERVER_DATA_CHANGE:
			break;
		default:
			return false;
	}
}

function onConsoleInput ( input )
{
	local text = split( input, " " ); 
	text[0].slice ( 0 );
	
	switch ( text[0] )
	{
		case "register":
			if ( text.len ( ) != 3 )
				return false;
			createElement ( ID_ACCOUNT, text[1], text[2], "", "127.0.0.1" );
			break;
		case "adminchat":
			SERVER.getchatserver ( ).getchannel ( "admin" ).addchat ( "Console", input );
			break;
		default:
			return false;
	}
}

function onClientRequestData ( playerid )
{
	local players = SERVER.getworld ( ).getplayers ( );
	local data = array ( MAX_PLAYERS, false );
	foreach ( id, name in getPlayers ( ) )
	{	
		local player = SERVER.getworld ( ).getplayer ( id );
		local v = player.getvehicle ( );
		if ( !v )
			v = "On foot";
		else
			v = getVehicleName ( getVehicleModel ( player.getvehicle ( ).getid ( ) ) );
			
		data[id] = [ player.stats.kills, player.stats.deaths, v ];
	}
	triggerClientEvent ( playerid, "onServerSendData", data );
	return true;
}

addEvent ( "onConsoleInput", onConsoleInput );
addEvent ( "onScriptInit", onScriptInit );
addEvent ( "clientRequestData" , onClientRequestData ); 