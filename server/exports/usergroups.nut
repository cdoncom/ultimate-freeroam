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
 
 function countPlayersInUsergroup ( team )
 {
	if ( team )
	{
		return team.getmembers ( ).len ( );
	}
	return false;
 }
 
 function getPayersInUsergroup ( team )
 {
 	if ( team )
	{
		return team.getmembers ( );
	}
	return false;
 }
 
 function getPlayerUsergroup ( player )
 {
	if ( player )
	{
		return player.getusergroup ( );
	}
	return false;
 }
 
 function getUsergroupFromName ( groupname )
 {
	if ( groupname )
	{
		return SERVER.getusergroup ( groupname.tostring ( ) );
	}
	return false;
 }
 
 function getUsergroupName ( team )
 {
	if ( team )
	{
		return team.getname ( );
	}
	return false;
 }
 
 function setPlayerUsergroup ( player, team )
 {
	if ( player && team )
	{
		player.getusergroup ( ).removemember ( player );
		player.setusergroup ( team );
		team.addmember ( player );
		return true;
	}
	return false;
 }
 
 function setUsergroupName ( team, name )
 {
 
 }