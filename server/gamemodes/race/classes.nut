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
 
 class Race
 {
	
	map = false;
	members = [ ];
	finish = [ ];
	
	constructor ( mapname )
	{
		local tmap = SERVER.getworld ( ).getmaphandler ( ).getmap ( mapname );
		if ( !tmap )
		
		else
			this.map = tmap;
	}
	
	function countdown ( )
	{
		local time = 3;
		timer ( 
			function ( ) 
			{ 
				foreach ( member in members ) 
					member.message ( time.tostring ( ) ); 
				time--;  
			}, 
			1000, 
			time 
		);
		
		timer ( 
			function ( ) 
			{ 
				foreach ( member in members ) 
					member.message ( "Go!" );
			}, 
			( time + 1 ) * 1000, 
			1 
		);
	}
	
	function startrace ( )
	{
		if ( !map )
		
		else
			map.start ( );
			
		countdown ( );
	}
	
	function endrace ( )
	{
	
	}
	
	function playercheckpoint ( player, checkpoint )
	{
		
	}
	
	function addmember ( player )
	{
		members.push ( player );
		return true;
	}
	
	function playerfinish ( player )
	{
		finish.push ( player );
		return true;
	}
	
	function getfinishorder ( )
	{
		return finish;
	}
	
 };