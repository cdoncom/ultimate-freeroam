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
 
registerCommand ( "createvehicle", 
	function ( player, params )
	{
		if ( params.len ( ) > 1 )
			params = params[0];
		
		local pos = player.getposition ( );
		data <- {
			model = params[0].tointeger ( ),
			x = ( pos[0] + 5.0 ),
			y = ( pos[1] + 5.0 ),
			z = ( pos[2] + 1.0 ),
			rz = player.getrotation ( ),
			ry = 0.0,
			rx = 0.0,
			lock = false,
			color = [ 0, 0, 0, 0 ],
			pos = [ ]
		};
		
		if ( player.isdriving ( ) )
			data.pos = player.getvehicle ( ).getposition ( );
		else
			data.pos = player.getposition ( );
			
		local vehicle = SERVER.getworld ( ).maphandler.getdefault ( ).addelement ( "vehicle", data );
		player.entervehicle ( vehicle );
		player.message ( player.getname ( ) + " has spawned a " + getVehicleName ( data.model ), Gray );
		
	},
	1
);

registerCommand ( "startengine", 
	function ( player, params )
	{
		
		if ( !player.isdriving ( ) )
		{
			player.message ( "You are not in a vehicle!", Gray );
			return;
		}
		
		local vehicle = player.getvehicle ( );
		vehicle.startengine ( );		
	},
	1
);

registerCommand ( "stopengine", 
	function ( player, params )
	{
		
		if ( !player.isdriving ( ) )
		{
			player.message ( "You are not in a vehicle!", Gray );
			return;
		}
		
		local vehicle = player.getvehicle ( );
		vehicle.stopengine ( );		
	},
	1
);

registerCommand ( "setcolor",
	function ( player, params )
	{
		local vehicle = player.getvehicle ( );
		if ( !vehicle )
			return player.message ( "You are not in a vehicle!", Gray );
			
		if ( params.len ( ) < 4 )
			return player.messge ( "Use /setcolor [c1] [c2] [c3] [c4]" );
		
		return vehicle.setcolor ( params[0].tointeger ( ), params[1].tointeger ( ), params[2].tointeger ( ), params[3].tointeger ( ) );
	},
	1
);