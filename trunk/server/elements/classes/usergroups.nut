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

class Usergroup extends Element
{
	name = " ";
	color = false;
	members = [ ];
	leader = false;
	ranks = { };
	score = 0;
	
	constructor ( data )
	{
		this.id = data.id;
		this.name = data.groupname;
		this.type = "usergroup";
	}
	
	function getcolor ( )
	{
		return color;
	}
	
	function getmembers ( )
	{
		return members;
	}
	
	function addmember( player )
	{
		members.push ( player );
		return true;
	}
	
	function removemember ( player )
	{
		local id = members.find ( player )
		if ( id )
			return members.remove ( id );
		return false;
	}
	
	function getname ( )
	{
		return name;
	}
	
	function setname ( name )
	{
		if ( typeof ( name ) == "string" )
		{
			this.name = name;
			return true;
		}
		return false;
	}
	
	function getscore ( )
	{
		return score;
	}
	
	function setscore ( var )
	{
		if ( typeof ( var ) != "integer" )
			return false;
		
		this.score = var;
	}	
	
};