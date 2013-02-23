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

class Vehicle extends Element
{

	owner = false;
	colors = { };
	model = -1;
	islocked = false;
	inventory = false;
	engine = false;
	
	constructor ( data )
	{
		this.model = data.model;
		this.type = "vehicle";
		this.id = createVehicle ( data.model, data.x, data.y, data.z, data.rx, data.ry, data.rz );
		if ( data.lock == true )
			lock ( );
		this.inventory = Inventory ( this );
	}
	
	function lock ( )
	{
		lock = true;
		//setVehicleLocked ( this.id, 2 );
	}
	
	function unlock ( )
	{
		lock = false;
		//setVehicleLocked ( this.id, 0 );
	}
	
	function gethealth ( )
	{
		//return getVehicleHealth ( this.id );
	}
	
	function sethealth ( val )
	{
		//return setVehicleHealth ( this.id, val.tointeger ( ) );
	}
	
	function soundhorn ( )
	{
		return setVehicleHornState ( this.id, true );
	}
	
	function lightson ( )
	{
		//return setVehicleLights ( this.id, true );
	}
	
	function lightsoff ( )
	{
		//return setVehicleLights ( this.id, false );
	}
	
	function getinventory ( )
	{
		return inventory;
	}
	
	function getposition ( )
	{
		return getVehiclePosition ( this.id );
	}
	
	function getdriver ( )
	{
		local occ = getVehicleOccupants ( this.id );
		if ( isPlayerConnected ( occ[1] ) )
			return SERVER.getworld ( ).getplayer ( occ[1] );
		return false;
	}
	
	function startengine ( )
	{
		this.engine = true;
		setVehicleEngineState ( this.id, true );
		return true;
	}
	
	function shutdownengine ( )
	{
		this.engine = false;
		setVehicleEngineState ( this.id, false );
		return true;
	}
	
	function getmodel ( )
	{
		return model;
	}
	
	function setcolor ( a, b, c, d, e, f )
	{
		return setVehicleColour ( this.id, a, b, c, d, e, f );
	}
	
};