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

class AccountHandler
{

	mt_accounts = [ ];
	
	constructor ( )
	{
		local usertable = SERVER.getconfig ( ).usertable;
		local grouptable = SERVER.getconfig ( ).grouptable;
		local statstable = SERVER.getconfig ( ).statstable;
		
		if ( SERVER.getconfig ( ).acctype.tointeger ( ) == 0 )
		{
			if ( SERVER.getconfig ( ).dbtype.tointeger ( ) == 0 )
			{
				sql.create_table( usertable, [
					{ name = "id", type = "int(11) unsigned", primary_key = true, auto_increment = true },
					{ name = "username", type = "varchar(32)" },
					{ name = "password", type = "varchar(32)" },
					{ name = "serial", type = "varchar(32)" },
					{ name = "ip", type = "varchar(32)" },
					{ name = "salt", type = "varchar(32)" },
					{ name = "email", type = "varchar(32)" },
					{ name = "usergroup", type = "tinyint(3) unsigned", defaultv = 1 },
					{ name = "admin", type = "tinyint(3) unsigned", defaultv = 1 },
					{ name = "timeplayed", type = "tinyint(3) unsigned", defaultv = 0 }
				] );
						
				sql.create_table( grouptable, [
					{ name = "id", type = "int(11) unsigned", primary_key = true, auto_increment = true },
					{ name = "groupname", type = "varchar(32)" }
				] );
				
				sql.create_table( statstable, [
					{ name = "id", type = "int(11) unsigned", primary_key = true, auto_increment = true },
					{ name = "kills", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "deaths", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "killstreak", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "money", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "racewins", type = "tinyint(3) unsigned", defaultv = 0 },
					{ name = "exp", type = "tinyint(3) unsigned", defaultv = 0 }
				] );
			}
		}
	}
	
	function initaccounts ( )
	{
		local accounts = sql.query_assoc ( "SELECT * FROM " + SERVER.getconfig ( ).usertable );
		foreach ( account in accounts )
		{
			local stats = sql.query_assoc ( "SELECT * FROM " + SERVER.getconfig ( ).statstable + " WHERE id = " + account.id.tointeger ( ) + "" );
			if ( !stats )
			{
				stats = {
					kills = 0,
					deaths = 0,
					killstreak = 0,
					money = 0
				};
			}
			addaccount ( account, stats );
		}
		return true;
	}
	
	function getaccounts ( )
	{
		return mt_accounts;
	}
	
	function getaccount ( var )
	{
		if ( typeof ( var ) == "string" )
		{
			foreach ( account in mt_accounts )
			{
				if ( account.getusername ( ) == var )
					return account;
			}
		}
		else if ( typeof ( var ) == "integer" )	
			return mt_accounts [ var ];
	
		return false;
	}
	
	function addaccount ( accountdata, stats = false )
	{
		if ( getaccount ( accountdata.username ) != false )
			return false;
		
		local account = Account ( accountdata, stats );
		mt_accounts.push ( account );
		return account;
	}
	
	function insertaccount ( username, pass, serial, ip )
	{
	
		local hashed;
		if ( SERVER.getconfig ( ).acctype == 0 )
			hashed = SERVER.util.hashforpass ( pass );

		local t = {
			username = sql.escape ( username.tostring ( ) ), 
			password = hashed[0].tostring ( ),
			salt = hashed[1].tostring ( ),
			ivmpserial = sql.escape ( serial.tostring ( ) ), 
			ip = sql.escape ( ip.tostring ( ) ),
			id = false,
			ivmpusergroup = 1,
			admin = 0
		};
		
		t.id = sql.query_insertid ( "INSERT into " + SERVER.getconfig ( ).usertable + " ( username, password, serial, ip, salt ) VALUES ( '" + t.username + "', '" + t.password + "', '" + t.serial + "', '" + t.ip + "', '" + t.salt + "' )" );
		if ( !t.id )
			return false;
		local result_2 = sql.query_insertid ( "INSERT into " + SERVER.getconfig ( ).statstable + " ( exp ) VALUES ( 0 )" );
		local account = addaccount ( t );
		callEvent ( "accountCreate", account );
		return account;
	}
	
};

class Account extends Element
{

	ms_username = "";
	ms_password = "";
	ms_ip = false;
	ms_serial = false;
	player = false;
	usergroup = false;
	admin = 0;
	salt = false;
	timeplayed = 0;
	stats = { kills = 0, deaths = 0, killstreak = 0, money = 0, exp = 0, racewins = 0 };
	
	constructor ( account, stat )
	{
		this.id = account.id;
		ms_username = account.username;
		ms_password = account.password;
		ms_ip = account.ip;
		ms_serial = account.ivmpserial;
		this.admin = account.admin;
		this.usergroup = account.usergroup;
		this.salt = account.salt;
		this.timeplayed = account.timeplayed;
		this.type = "account";
		if ( stat != false )
		{
			local t = stat[0];
			this.stats.kills = t.kills;
			this.stats.deaths = t.deaths;
			this.stats.killstreak = t.killstreak;
			this.stats.exp = t.exp;
			this.stats.racewins = t.racewins;
		}
	}
	
	function getusername ( )
	{
		return ms_username;
	}

	function getpassword ( )
	{
		// Password is hashed
		return ms_password;
	}	
	
	function setpassword ( newpass )
	{
		local pass = SERVER.util.has ( newpass );
		local result = sql.query_assoc ( "UPDATE " + SERVER.getconfig ( ).usertable + " SET password = '" + pass[0] + "', salt = '" + pass[1] + "' WHERE `id` = " + this.id + "" );
		if ( result )
		{
			this.ms_password = pass;
			return true;
		}
		return false;
	}
	
	function updateaccount ( )
	{
		local result = sql.query_assoc ( "UPDATE " + SERVER.getconfig ( ).usertable + " SET timeplayed = " + this.timeplayed + " WHERE `id` = " + this.id + "" );
		if ( result )
		{
			result = sql.query_assoc ( "UPDATE " + SERVER.getconfig ( ).statstable + " SET kills = " + this.stats.kills + ", deaths = " + this.stats.deaths + ", killstreak = " + this.stats.killstreak + ", money = " + this.stats.money + ", exp = " + this.stats.exp + ", racewins = " + this.stats.racewins + " WHERE `id` = " + this.id + "" );
			if ( result )
				return true;
		}
		return false;
	}
	
	function assignplayer ( player )
	{
		this.player = player;
		return true;
	}
	
	function unassignplayer ( )
	{
		this.player = false;
		return true;
	}
	
	function updateminute ( )
	{
		this.timeplayed++;
		return true;
	}
	function inuse ( )
	{
		if ( this.player == false )
			return false;
		else
			return true;
	}
	
	function getusergroup ( )
	{
		return usergroup;
	}
	
	function getadminlevel ( )
	{
		return admin;
	}
	
	function getserial ( )
	{
		return mi_serial;
	}
	
	function getip ( )
	{
		return mi_ip;
	}
	
};