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

class MapHandler
{

	maps = { };
	
	constructor ( )
	{
		local name = "root";
		this.maps[name] <- Map ( 
		{ 
			name = name,
			vehicles = [ ],
			objects = [ ],
			blips = [ ],
			pickups = [ ],
			checkpoints = [ ],
			peds = [ ],
			spawnpoints = [ ] 
		} );
	}
	
	function loadmaps ( )
	{
		foreach ( k, map in SERVER.getconfig ( ).maps )
			loadmap ( map.name, map.state );
		
		return true;
	}
	
	function loadmap ( mapname, mapstate = "false" )
	{		
		local map = parsemapfile ( mapname );
		
		if ( map == false )
			return log ( "Map not loaded" );
			
		if ( mapstate == "true" )
			startmap ( map );
		
		callEvent ( "mapLoad", map );
		log ( "Map, " + mapname + ", was loaded successfully." );
		
		return true;
	}
	
	function parsemapfile ( mapname )
	{
		//local xfile = xml ( "maps/" + mapname );

		local map = { };
		map.name <- mapname;
		//map.name <- xfile.nodeAttribute ( "name" );
		map.vehicles <- [ ];
		map.objects <- [ ];
		map.blips <- [ ];
		map.checkpoints <- [ ];
		map.peds <- [ ];
		map.pickups <- [ ];
		map.spawnpoints <- [ ];
			
		/*xfile.nodeFirstChild ( );
		while ( true )
		{
			local nodename = xfile.nodeName ( );
			if ( nodename == "vehicle" )
			{
				map.vehicles.push ( { 
					model = xfile.nodeAttribute ( "model" ).tointeger ( ),
					x = xfile.nodeAttribute ( "x" ).tofloat ( ),
					y = xfile.nodeAttribute ( "y" ).tofloat ( ),
					z = xfile.nodeAttribute ( "z" ).tofloat ( ),
					rx = xfile.nodeAttribute ( "rx" ).tofloat ( ),
					ry = xfile.nodeAttribute ( "ry" ).tofloat ( ),
					rz = xfile.nodeAttribute ( "rz" ).tofloat ( ),
					color = [
						xfile.nodeAttribute ( "color1" ).tointeger ( ),
						xfile.nodeAttribute ( "color2" ).tointeger ( ),
						xfile.nodeAttribute ( "color3" ).tointeger ( ),
						xfile.nodeAttribute ( "color4" ).tointeger ( ),
					],
					lock = xfile.nodeAttribute ( "lock" ).tostring ( )
				} );
			}
			else if ( nodename == "blip" )
			{
				map.blips.push ( {
					model = xfile.nodeAttribute ( "model" ).tointeger ( ),
					x = xfile.nodeAttribute ( "x" ).tofloat ( ),
					y = xfile.nodeAttribute ( "y" ).tofloat ( ),
					z = xfile.nodeAttribute ( "z" ).tofloat ( )
				} );
			}
			else if ( nodename == "spawnpoint" )
			{
				map.spawnpoints.push ( {
					x = xfile.nodeAttribute ( "x" ).tofloat ( ),
					y = xfile.nodeAttribute ( "y" ).tofloat ( ),
					z = xfile.nodeAttribute ( "z" ).tofloat ( ),
					rot = xfile.nodeAttribute ( "rot" ).tofloat ( )
				} );
			}
				
			if ( !xfile.nodeNext ( ) )
				break;
				
		}
		
		xfile = false;/*
		return this.maps[ map.name ] <- Map ( map );
	}
	
	function newmap ( mapname )
	{
		local xfile = xml ( mapname.tostring ( ) + ".xml" );
		xfile.nodeNew ( "map" )
		xfile.nodeSetAttribute ( "name", mapname.tostring ( ) );
		xfile.save ( );
		loadmap ( mapname.tostring ( ) + ".xml" );
	}
	
	function saveelement ( element, mapname )
	{
		//local xfile = xml ( mapname.tostring ( ) + ".xml" );
		return true;
	}
	
	function startmap ( map )
	{
		map.start ( );
		callEvent ( "mapStart", map );
		return true;
	}
	
	function getdefault ( )
	{
		foreach ( k, v in maps )
		{
			if ( v.getname ( ) == "root" )
				return v;
		}
		return false;
	}
	
	function getmap ( name )
	{
		foreach ( k, v in maps )
		{
			if ( v.getname ( ) == name.tostring ( ) )
				return v;
		}
		return false;
	}
	
	function addspawntomapfile ( data )
	{
		local xfile = xml ( "maps/root.map" );
		
		xfile.nodeFirstChild ( );
		
		xfile.nodeNew ( true, "spawnpoint" );
		xfile.save ( );
		xfile.nodeSetAttribute ( "x", data.x.tostring ( ) );
		xfile.nodeSetAttribute ( "y", data.y.tostring ( ) );
		xfile.nodeSetAttribute ( "z", data.z.tostring ( ) );
		xfile.nodeSetAttribute ( "rot", data.rot.tostring ( ) );
		xfile.save ( );
		getdefault ( ).addspawnpoint ( data );
		return true;
	}
	
	function stopmap ( map )
	{
		map.stop ( );
		callEvent ( "mapStop", map );
		return true;
	}
	
};

class Map extends Element
{

	name = "";
	data = { };
	vehicles = [ ];
	blips = [ ];
	spawnpoints = [ ];
	
	constructor ( data )
	{
		this.name = data.name;
		this.data = data;
	}
	
	function getname ( )
	{
		return name;
	}
	
	function start ( )
	{
	
		foreach ( k, vehicle in data.vehicles )
		{
			addelement ( "vehicle", vehicle );
		}
		
		foreach ( k, blip in data.blips )
		{
			addelement ( "blip", blip );
		}
		
		foreach ( k, spawnpoint in data.spawnpoints )
		{
			addspawnpoint ( spawnpoint );
		}
		
		delete data.vehicles;
		delete data.blips;
		delete data.spawnpoints;
		
		return true;
	}
	
	function stop ( )
	{
		foreach ( vehicle in vehicles )
		{
			local id = vehicles.find ( vehicle );
			vehicles.remove ( id );
			//delete vehicle;
		}
		
		foreach ( object in objects )
		{
			local id = objects.find ( object );
			objects.remove ( id );
			//delete object;
		}
		
		foreach ( blip in blips )
		{
			local id = blips.find ( blip );
			blips.remove ( id );
			//delete blip;
		}
		
		foreach ( checkpoint in checkpoints )
		{
			local id = checkpoints.find ( checkpoint );
			checkpoints.remove ( id );
			//delete checkpoint;
		}
		
		foreach ( ped in peds )
		{
			local id = peds.find ( ped );
			peds.remove ( id );
			//delete ped;
		}
		
		foreach ( pickup in pickups )
		{
			local id = pickups.find ( pickup );
			pickups.remove ( id );
			//delete pickup;
		}
		
		foreach ( spawnpoint in spawnpoints )
		{
			local id = spawnpoints.find ( spawnpoint );
			spawnpoints.remove ( id );
			//delete spawnpoint;
		}
		
		return true;
	}
	
	function addspawnpoint ( data )
	{
		local spawnpoint = Spawnpoint ( spawnpoints.len ( ), data );
		spawnpoints.push ( spawnpoint );
		return spawnpoint;
	}
	
	function randomspawnpoint ( )
	{
		local num = SERVER.math.random ( 0, spawnpoints.len ( ) - 1 );
		log ( num.tostring ( ) );
		return spawnpoints [ num ];
	}
	
	function addelement ( element_type, data )
	{
		data.map <- this;
		switch ( element_type )
		{
			case "vehicle":
				local vehicle = Vehicle ( data );
				vehicles.push ( vehicle );
				return vehicle;
				break;
			case "object":
				return objects.push ( Object ( data ) );
				break;
			case "blip":
				return blips.push ( Blip ( data ) );
				break;
			case "checkpoint":
				local checkpoint = Checkpoint ( data )
				checkpoints.push ( checkpoint );
				elements.checkpoints.push ( checkpoint );
				return checkpoint;
				break;
			case "pickup":
				return pickups.push ( Pickup ( data ) );
				break;
			case "ped":
				return peds.push ( Ped ( data ) );
				break;
			case "house":
				return houses.push ( House ( data ) );
				break;
			default:
				return false;
				break;
		}
	}
	
};

class Mapeditor
{
	elements = [ ];
	
	constructor ( )
	{
	
	}
	
	function loadfile ( filename )
	{
	
	}
	
	function savefile ( filename )
	{
	
	}
	
};