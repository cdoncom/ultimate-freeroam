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

function getElementsByType ( typ )
{
	if ( typeof ( typ ) == "string" )
	{
		if ( !elements[typ] )
		{
			return false;
		}else{
			return elements[typ];
		}
	}
	return false;
}

function getElementType ( element )
{
	if ( isElement(element) )
	{
		return element.getType();
	}
	return false;
}

function setElementData ( element, key, value )
{
	if ( typeof(key) == "string" )
	{
		if ( element.data[key] <- value )
			return true;
		return false;
	}
	return false
}

function getElementData ( element, key )
{
	if ( typeof(key) == "string" )
	{
		return element.getData(key);
	}
	return false;
}

function getElementPosition ( element )
{
	if ( !isElement ( element ) )
		return false;
	
	local pos;
	switch ( element.getType() )
	{
		case "player":
			pos = getPlayerCoordinates ( element.id );
			break;
		case "vehicle":
			pos = getVehicleCoordinates ( element.id );
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
		default:
			return false;
	}
	return pos;
}

function setElementPosition ( element, x, y, z )
{
	if ( isElement ( element ) )
	{
		switch ( element.getType() )
		{
			case "player":
				setPlayerCoordinates ( element.id, x, y, z );
				break;
			case "vehicle":
				setVehicleCoordinates ( element.id, x, y, z );
				break;
			case "object":
				setObjectCoordinates ( element.id, x, y, z );
				break;
			case "checkpoint":
				element.setPosition( x, y, z );
				break;
			case "blip":
				setBlipCoordinates ( element.id, x, y, z );
				break;
			case "pickup":
				setPickupCoordinates ( element.id, x, y, z );
				break;
			default:
				return false;
		}
		return true;
	}
	return false;
}

function createElement ( element_type, a = false, b = false, c = false, d = false, e = false, f = false, g = false, h = false )
{
	if ( !element_type )
		return false;
		
	if ( typeof ( element_type ) == "integer" )
	{		
		switch ( element_type )
		{
			case ID_PLAYER:
				if ( a != false )
					return elements.players[elements.players.len()] <- Player ( a );
				break;
			case ID_VEHICLE:
				if ( a != false && b != false && c != false )
					return elements.vehicles[elements.vehicles.len()] <- Vehicle ( a, b, c );
				break;
			case ID_PED:
				if ( a != false && b != false && c != false && d != false )
					return elements.peds[elements.peds.len()] <- Ped ( a, b, c, d );
				break;
			case ID_PICKUP:
				if ( a != false && b != false && c != false && d != false )
					return elements.pickups[elements.pickups.len()] <- Pickup ( a, b, c, d );
				break;
			case ID_HOUSE:
				if ( a != false && b != false && c != false && d != false && e != false && f != false && g != false )
					return elements.houses[elements.houses.len()] <- House ( elements.houses.len(), a, b, c, d, e, f );
				break;
			case ID_USERGROUP:
				if ( a != false && b != false )
					return elements.usergroups[elements.usergroups.len()] <- Usergroup ( a, b );
				break;
			case ID_BLIP:
				if ( a != false && b != false && c != false && d != false )
					return elements.blips[elements.blips.len()] <- Blip ( a, b, c, d );
				break;
			case ID_CHECKPOINT:
				if ( a != false && b != false && c != false && d != false && e != false && f != false && g != false )
					return elements.checkpoints[elements.checkpoints.len()] <- Checkpoint ( a, b, c, d, e, f, g );
				break;
			case ID_TIMER:
				if ( a != false && b != false && c != false )
					return elements.timers[elements.timers.len()] <- Timer ( a, b, c );
				break;
			case ID_SPAWNPOINT:
				if ( a != false && b != false && c != false && d != false )
					return elements.spawnpoints[elements.spawnpoints.len()] <- Spawnpoint ( elements.spawnpoints.len(), a, b, c, d );
				break;
			case ID_OBJECT:
				if ( a != false && b != false && c != false && d != false && e != false && f != false && g != false )
					return elements.objects[elements.objects.len()] <- Object ( a, b, c, d, e, f, g );
				break;
			case ID_ACCOUNT:
				if ( a != false && b != false && c != false && d != false )
					return elements.accounts[elements.accounts.len()] <- ACCOUNTS.insertaccount ( a, b, c, d );
				break;
			default:
				return false;
		}
	}
	else if ( typeof ( element_type ) == "string" )
	{
		switch ( element_type )
		{
			case "player":
				if ( a != false )
					return elements.players[a] <- Player ( a );
				break;
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
			case "usergroup":
				if ( a != false && b != false )
					return elements.usergroups[elements.usergroups.len()] <- Usergroup ( elements.usergroups.len(), a, b );
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
			case "account":
				if ( a != false && b != false && c != false && d != false )
					return elements.accounts[elements.accounts.len()] <- ACCOUNTS.insertaccount ( a, b, c, d );
				break;
			default:
				return false;
		}
	}else{
		return false;
	}
}

function deleteElement ( element )
{
	if ( !isElement ( element ) )
		return false;
	
	local id = element.getid ( );
	switch ( element.getType( ) )
	{
		case "player":
			delete elements.players[id];
			break;
		case "vehicle":
			deleteVehicle ( id )
			break;
		case "object":
			deleteObject ( id );
			break;
		case "checkpoint":
			deleteCheckpoint ( id );
			break;
		case "blip":
			break;
		case "pickup":
			deletePickup ( id );
			break;
		case "house":
			delete elements.houses[id];
			break;
		case "ped":
			deleteActor ( id );
			break;
		case "spawnpoint":
			delete elements.spawnpoints[id];
			break;
		case "usergroup":
			delete elements.usergroups[id];
			break;
		case "timer":
			element.getTimer().kill();
			break;
		case "account":
			ACCOUNTS.deleteaccount ( element );
			break;
		default:
			return false;
	}
	return true;
}

function findElement ( type, id )
{
	if ( !elements.rawin ( type ) )
		return false;
		
	foreach ( k, v in elements[type] )
	{
		if ( v.getid() == id )
			return v;
	}
	
	return false;
}

function deleteAllElements ( )
{
	foreach ( k, v in elements )
		foreach ( i, r in v )
			deleteElement ( r );
}

function isElement ( element )
{
	foreach ( k, v in elements )
	{
		foreach ( i, r in elements[k] )
		{
			if ( r == element )
			{
				return true;
			}
		}
	}
	return false;
}