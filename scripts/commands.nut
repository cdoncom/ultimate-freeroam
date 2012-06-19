/*
 * "TheGhost's Ultimate Freeroam"
 */
 
/*****************************************************************/
/**************************** Commands ***************************/

commands <- { };
commandCategories <- { };
usergroupCommands <- { };

/* addCommand
 *   name       - name of the command -OR- array with names of the commands (multiple commands for the same function)
 *   fn         - the function that is executed if the player has the given admin level
 *   category   - name of the category that command is to be put into
 *                -OR-
 *                array:
 *                  0: name of the category that command is to be put into
 *                  1: index of the command in the name-array that is to be used for help (e.g. name = ["a","b","c"], category = ["misc",2] -> /help shows /b under 'misc'
 *   adminlevel - required admin level to execute the function
 *   requiredFn - other requirements in a function, return false to ignore the command (not show it), 0 to show it as normal command, true to show it as highlighted command
 */

function addCommand( name, fn, category = false, adminlevel = 0, requiredFn = false )
{
	if( !category && typeof( name ) == "string" )
		log( "* WARNING: No category for command /" + name );
	
	if( typeof( name ) == "array" )
	{
		local shortest = "xxxxxxxxxxxxxxxxxxxxxxx";
		if( typeof( category ) == "array" )
		{
			shortest = name[category[1]-1];
			category = category[0];
		}
		else
		{
			foreach( n in name )
				if( n.len( ) < shortest.len( ) )
					shortest = n;
		}
		
		local value = true;
		foreach( k, n in name )
			if( !addCommand( n, fn, n == shortest ? category : "", adminlevel, requiredFn ) )
				value = false;
		return false;
	}
	else if( typeof( name ) == "string" )
	{
		name = name.tolower( );
		if( !commands.rawin( name ) )
		{
			commands[name] <- { func = fn, admin = adminlevel };
			if( requiredFn )
				commands[name].required <- requiredFn;
			
			if( category && category != "" )
			{
				if( !commandCategories.rawin( category ) )
					commandCategories[category] <- [ name ];
				else
					commandCategories[category].push( name );
			}
		}
		else
		{
			log( "* WARNING: Command /" + name + " does already exist" );
		}
	}
	return false;
}

function canExecuteCommand( player, command )
{
	if(commands[command].admin > 0)
	{
		return player.getAdmin( ) >= commands[command].admin;
	}
	else return true;
}

function executeCommand( player, params, overrideCommand = false )
{
	if( typeof( params ) == "string" )
		params = split( params, " " );
	
	local command = params[0];
	params.remove( 0 );
	
	if( commands.rawin( command ) )
	{
		if( canExecuteCommand( player, command ) )
		{
			commands[command].func( player, typeof( overrideCommand ) == "string" ? overrideCommand : command, params );
			return true;
		}
	}
	return false;
}

/*****************************************************************/
/**************************** Login ******************************/

addCommand( "login",
	function( player, command, params )
	{
		player.message( "Login feature not available at this time." );
	},
	"account"
);

/*****************************************************************/
/***************************** Help ******************************/

local function helpConcat( table, prefix )
{
	local strings = [ prefix ];
	for( local i = 0; i < table.len( ); ++ i )
	{
		local test = replace( replace( strings[strings.len( ) - 1] + " " + table[i], "[DDDDDDFF] [FFAAAAFF]", " " ), "[DDDDDEFF] [AAFFAAFF]", " " );
		if( test.len( ) < 128 )
			strings[strings.len( ) - 1] = test;
		else
		{
			strings.push( prefix + " " + table[i] );
		}
	}
	return strings;
}

addCommand( "help",
	function( player, command, params )
	{
		player.message( "__________ TheGhost's Ultimate Freeroam - Help __________" );
		
		local c = [];
		foreach( category, entries in commandCategories )
			c.push( category );
		c.sort( );
		
		foreach( category in c )
		{
			local e = [];
			foreach( cmd in commandCategories[category] )
			{
				if( canExecuteCommand( player, cmd ) )
				{
					if( commands[cmd].admin > 0 )
						e.push( "[FFAAAAFF]/" + cmd + "[DDDDDDFF]" );
					else if( commands[cmd].rawin( "required" ) )
					{
						local check = commands[cmd].required( player );
						if( check == true )
							e.push( "[AAFFAAFF]/" + cmd + "[DDDDDEFF]" );
						else if( check == 0 )
							e.push( "/" + cmd );
					}
					else
						e.push( "/" + cmd );
				}
			}
			
			if( e.len( ) > 0 )
				foreach( message in helpConcat( e, "[" + category + "]" ) )
					player.message( message );
		}
	},
	""
);

/*****************************************************************/
/************************* Check Health **************************/

addCommand( ["h", "health"],
	function( player, command, params )
	{
		local he = player.getHealth();		
		player.message( "Health: "+he+"%" );
	},
	"general"
);

/*****************************************************************/
/*************************** flip coin ***************************/

addCommand( "flipcoin",
	function(player, command, params)
	{
		local rnd = random(1, 2);
		if(rnd == 1)
			player.message( "You flipped a coin and it landed on heads." );
		else
			player.message( "You flipped a coin and it landed on tails." );
	},
	"general"
);

/*****************************************************************/
/**************************** Suicide ****************************/

addCommand( "die",
	function( player, command, params )
	{
		player.kill();
	},
	"misc"
);

/*****************************************************************/
/************************** Send Message *************************/

addCommand( [ "pm", "msg" ],
	function( player, command, params )
	{
		if( params.len( ) >= 2 )
		{
			local other = all.find( player, params[0] );
			if( other )
			{
				if( other != player )
				{
					if ( other.arePMsEnabled() || player.getAdmin() > 0 )
					{
						local text = concat( params, 1 );
						player.message( "PM sent to (" + other.getID( ) + ") " + other.getName( ) + ": " + text );
						other.message( "PM from (" + player.getID( ) + ") " + player.getName( ) + ": " + text );
						if ( other.isAFK() )
							player.message("Warning: "+other.getName()+" is set as AFK. Reason: "+other.getAFKMsg() );
					}
					else
						player.message( "This player has disabled their PMs." );
				}
				else
					player.message( "You can't PM yourself.", color.red );
			}
		}
		else
			player.message ( "Syntax: /" + command + " [player] [message text]" );
	},
	"chat"
);

/*****************************************************************/
/*************************** Toggle AFK **************************/

addCommand( "afk",
	function( player, command, params )
	{
		if( player.isAFK() )
		{
			player.setAFK( false );
			player.message( "You are no longer away." );
		}
		else
		{
			if(params.len() >= 1)
			{
				local reason = concat(params);
				player.setAFK(true);
				player.setAFKMsg(reason);
				player.message("You are now AFK!");
			}
			else
				player.message( "Syntax: /afk [message/reason]", color.syntax );
		}
	},
	"misc"
);

/*****************************************************************/
/************************* Request Admin *************************/

addCommand( "assist",
	function( player, command, params )
	{
		if( params.len() >= 1 )
		{
			if( all.admins().len() > 0 )
			{
				player.message("The administration team has been notified of your request.", color.white);
				foreach( admin in all.admins( ) )
				{
					admin.message( "[Assist] " + player.getName() + " (ID: " + player.getID() + ") (Account: " + player.getUserName() + ") requests assistance for:" );
					admin.message( "[Assist] " + concat(params) );
				}
			}
			else
				player.message( "Unfortunately there are no administrators online to assist you at this time." );
		}
		else
			player.message( "Syntax: /" + command + " [reason/question/situation]" );
	},
	"misc"
);

/*****************************************************************/
/************************* Report Player *************************/

addCommand( "report",
	function( player, command, params )
	{
		if(params.len() >= 2)
		{
			local other = all.find(player, params[0]);
			if(other)
			{
				if(all.admins().len() > 0)
				{
					player.message( "The administration team has been notified of your report." );
					foreach( admin in all.admins( ) )
					{
						admin.message( "[Player Report] " + player.getName() + " (ID: " + player.getID() + ") (Account: " + player.getUserName() + ") has reported:" );
						admin.message( "[Player Report] " + other.getName() + " (ID: " + other.getID() + ") (Account: " + other.getUserName() + ") for:" );
						admin.message( "[Player Report] " + concat(params, 1) );
					}
				}
				else
					player.message( "Unfortunately there are no administrators online at this time." );
			}
			else
				player.message( "Player not found." );
		}
		else
			player.message( "Syntax: /" + command + " [player] [reason]", color.syntax );
	},
	"misc"
);

/*****************************************************************/
/************************** Clear Chat ***************************/

addCommand( "clearchat",
	function( player, command, params )
	{
		player.clearChat( );
	},
	"chat"
);

/*****************************************************************/
/************************* Pay A Player **************************/

addCommand( "pay",
	function( player, command, params )
	{
		if ( params.len( ) >= 2 )
		{
			local other = all.find( player, params[0] );
			if ( other )
			{
				if ( player != other )
				{
					local amount = moneyFromString( params[1] );
					if ( amount > 0 && player.getMoney( ) >= amount )
					{
							if ( player.takeMoney( amount ) && other.giveMoney( amount ) )
								return true;
							return false;
					}
					else
						player.message( "You can't give away " + formatMoney( amount ) + " as you only have " + formatMoney( player.getMoney( ) ) + " with you.", color.red );
				}
				else
					player.message( "You can't give money to yourself.", color.red );
			}
			else
				player.message( "Cannot find player with ID (" + params[0].tostring() + ")." );
		}
		else
			player.message( "Syntax: /" + command + " [player] [amount] - gives another player the given amount of money.", color.syntax );
	},
	"misc",
	0,
	function( player ) { return player.getMoney( ) > 0 ? 0 : false; }
);

/*****************************************************************/