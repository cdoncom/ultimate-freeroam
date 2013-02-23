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
 
registerCommand ( "register",
	function ( player, params )
	{
		if ( params.len ( ) < 2 )
			return false;
			
		local username = params[0];
		local password = params[1];
		local serial = player.getserial ( );
		local ip = player.getip ( );
		
		if ( SERVER.getaccounthandler ( ).getaccount ( username ) )
		{
			player.message ( "An account with the username, " + username + ", already exists. Please register under a different name.", Gray );
			return false;
		}
		
		local account = SERVER.getaccounthandler ( ).insertaccount ( username, password, serial, ip );
		if ( !account )
			return false;
		else
		{
			player.message ( "You have registered the account, " + username + ". Please use /login username password to login to your account.", Gray );
			return account;
		}
	},
	0
);

registerCommand ( "login",
	function ( player, params )
	{
		local username = false;
		local password = false;
		
		if ( player.isloggedin ( ) )
			player.message ( "You are already logged in!", Gray );
		
		if ( params.len ( ) < 2 )
		{
			if ( params.len ( ) == 1 )
			{
				username = player.getname ( );
				password = params[0];
			}
			else
				return;
		}
		else
		{		
			username = params[0];
			password = params[1];
		}
		
		local account = SERVER.getaccounthandler ( ).getaccount ( username );
		if ( !account )
			player.message ( "An account with the username, " + username + ", does not exist!", Gray );
		
		if ( account.inuse ( ) )
			player.message ( "Another player is logged into this account!", Gray );
		
		local hashed = SERVER.util.hashforpass ( password, account.salt );
		if ( hashed[0] == account.getpassword ( ) )
			loginPlayer ( player, account );	
		else
			player.message ( "Invalid password!", Gray );
			
	},
	0
);

registerCommand ( "logout",
	function ( player, params )
	{
		if ( !player.isloggedin ( ) )
		{
			player.message ( "You are not logged into any account!", Gray );
			return;
		}
		
		local account = player.getaccount ( );
		if ( account )
			logoutPlayer ( player, account );
		else
			return;
	},
	0
);