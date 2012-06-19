/*
 * "TheGhost's Ultimate Freeroam"
 */
 
/*************************************************************/
/************************** Utility **************************/
function concat( table, start = 0 )
{
	local str = "";
	for( local i = start; i < table.len( ); i ++ )
	{
		str += ( i == start ? "" : " " ) + table[ i ];
	}
	return str;
}

function nodec(number)
{
	number = number.tofloat();
	if(number < 1 && number > 0)
		return 1;
	return number.tointeger();
}


function isInteger( string )
{
	try
	{
		string.tointeger( );
		return true;
	}
	catch( error )
	{
	}
	return false;
}

isNumeric <- isInteger;

function round( number, decimal = 0 )
{
	local exp = pow( 10, decimal );
	return ( ( number * exp + 0.5 ).tointeger( ) ) / exp;
}
 
function formatMoney( amount )
{
	local negative = amount < 0;
	if( negative )
		amount *= -1;
	
	local string = "";
	while( amount >= 1000 )
	{
		local rest = amount % 1000;
		amount = ( amount / 1000 ).tointeger( );
		string = format( "%03d", rest ) + "," + string;
	}
	string = ( negative ? "-" : "" ) + "$" + amount + "," + string;
	return string.slice( 0, string.len( ) - 1 );
}

// converts $1,234 or -$5,000 to a number (1234, -5000 respectively).
// values such as $1,2345 etc. are also valid, but it's aimed to provide visual help to whoever enters the number to easier distinguish between 10000 and 100000 ($10,000 and $100,000), not to make it fool-proof.
function moneyFromString( string )
{
	if( isNumeric( string ) )
		return string.tointeger( );
	
	local negative = false;
	if( string[0] == '-' )
	{
		negative = true;
		string = string.slice( 1 );
	}
	
	if( string[0] == '$' )
		string = string.slice( 1 );
	
	local amount = 0;
	local seperatorposition = false;
	for( local i = 0; i < string.len( ); i ++ )
	{
		if( string[i] >= '0' && string[i] <= '9' )
		{
			amount = amount * 10 + ( string[i] - '0' );
		}
		else if( string[i] != ',' )
			return 0;
	}
	return ( negative ? -1 : 1 ) * amount;
}

// formats numbers (1 => 1st, etc.)
function formatOrdinal( number )
{
	if( number <= 0 )
		return "[Error]";
	
	local temp = number;
	temp %= 100;
	if( temp >= 20 )
		temp %= 10;
	if( temp == 1 )
		return number + "st";
	else if( temp == 2 )
		return number + "nd";
	else if( temp == 3 )
		return number + "rd";
	else
		return number + "th";
}

// Debugger Function
function debug(var)
{
	local msg = {}
	
	msg[0] <- "[DEBUG] Variable has the value "+var+" and is "+typeof(var);
	if(typeof(var) == "table")
	{
		local i = 1;
		foreach(i, j in var)
		{
			msg[i] <- "[DEBUG] Content "+i+" is "+j+" and type is "+typeof(j);
		}
	}
	return msg;
	
	
}

// random value between two numbers, remember too seed the random (srand(getTickCount);)
function random(min,max) {
	return (rand() % ((max + 1) - min)) + min;
}

// generates a string with 'length' characters. if onlyDigits is true it will only use digits
function generateRandomString(length, onlyDigits = false)
{
	local str = "";
	local rnd;
	if(onlyDigits == false)
		for(local i = 0; i < length; ++i)
		{
			rnd = random(0, 35);
			if(rnd < 10)
			{	
				rnd += 48;
			}
			else	
				rnd += 55;
			str += rnd.tochar();
		}
	else
		for(local i = 0; i < length; ++i)
		{
			rnd = random(0, 9);
			rnd += 48;
			str += rnd.tochar();
		}
	return str;
}

// replaces all occurences of A with B
function replace( string, A, B )
{
	local pos = null;
	while( ( pos = string.find( A ) ) != null )
	{
		string = string.slice( 0, pos ) + B + string.slice( pos + A.len( ) );
	}
	return string;
}

function getTableAsString(content)
{
	local string = "";
	foreach(i, key in content)
	{
		string += i + "\n" + key +"\n";
	}
	return string;
}

function getStringAsTable(string)
{
	content.clear();
	local sp = split(string, "\n");
	foreach(i, key in sp)
	{
		content[i] = key;
	}
	return content;
}
	
function tableCleanUp(table)
{
	local i = 0;
	local table2 = {}
	foreach(key in table)
	{
		table2[i] <- key;
		++i;
	}
	table.clear();
	return table2;
}

function shuffle(table)
{
	local ntable = { };
	foreach(s in table)
	{
		local q = false;
		while(q == false)
		{
			local r = random(0, table.len()-1);
			if(!ntable.rawin(r))
			{
				ntable[r] <- s;
				q = true;
			}
		}	
	}
	return ntable;
}

function dsin(n)
{
	return sin(n*PI/180);
}

function dcos(n)
{
	return cos(n*PI/180);
}