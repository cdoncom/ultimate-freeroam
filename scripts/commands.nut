/*
 * "Ultimate Freeroam by TheGhost"
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

function addCommand ( name, fn, category = false, adminlevel = 0, requiredFn = false )
{
	if ( !category && typeof ( name ) == "string" )
		log ( "* WARNING: No category for command /" + name );
	
	if ( typeof ( name ) == "array" )
	{
		local shortest = "xxxxxxxxxxxxxxxxxxxxxxx";
		if ( typeof ( category ) == "array" )
		{
			shortest = name[category[1]-1];
			category = category[0];
		}
		else
		{
			foreach ( n in name )
				if ( n.len ( ) < shortest.len ( ) )
					shortest = n;
		}
		
		local value = true;
		foreach ( k, n in name )
			if ( !addCommand ( n, fn, n == shortest ? category : "", adminlevel, requiredFn ) )
				value = false;
		return false;
	}
	else if ( typeof ( name ) == "string" )
	{
		name = name.tolower ( );
		if ( !commands.rawin ( name ) )
		{
			commands[name] <- { func = fn, admin = adminlevel };
			if ( requiredFn )
				commands[name].required <- requiredFn;
			
			if ( category && category != "" )
			{
				if ( !commandCategories.rawin ( category ) )
					commandCategories[category] <- [ name ];
				else
					commandCategories[category].push ( name );
			}
		}
		else
		{
			log ( "* WARNING: Command /" + name + " does already exist" );
		}
	}
	return false;
}

function canExecuteCommand ( player, command )
{
	if ( commands[command].admin > 0 )
	{
		return player.getAdmin ( ) >= commands[command].admin;
	}
	else return true;
}

function executeCommand ( player, params, overrideCommand = false )
{
	if ( typeof ( params ) == "string" )
		params = split ( params, " " );
	
	local command = params[0];
	params.remove ( 0 );
	
	if ( commands.rawin ( command ) )
	{
		if ( canExecuteCommand ( player, command ) )
		{
			commands[command].func ( player, typeof ( overrideCommand ) == "string" ? overrideCommand : command, params );
			return true;
		}
	}
	return false;
}