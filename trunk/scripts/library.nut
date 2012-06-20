/*
 * "Ultimate Freeroam by TheGhost"
 */
 
/*****************************************************************/
/**************************** Library ****************************/

function double ( integer )
{
	if ( !integer )
		return false;
	
	if ( typeof ( integer ) != "integer" || typeof ( integer ) != "float" )
		return false;
		
	return integer * 2;
}

function square ( integer )
{
	if ( !integer )
		return false;
	
	if ( typeof ( integer ) != "integer" || typeof ( integer ) != "float" )
		return false;
	
	return integer * integer;
}

function half ( integer )
{
	if ( !integer )
		return false;
	
	if ( typeof ( integer ) != "integer" || typeof ( integer ) != "float" )
		return false;
		
	return integer / 2;
}

function circumfrance ( integer )
{
	if ( !integer )
		return false;
	
	if ( typeof ( integer ) != "integer" || typeof ( integer ) != "float" )
		return false;
		
	return 2 * 3.14 * integer;
}

function area ( length, width )
{
	return length * width;
}

function volume ( length, width, height )
{	
	return length * width * height;
}

function distance ( aX, aY, bX, bY )
{
	cX = bX - aX;
	cY = bY - aY;
	return cY/cX;
}

/*****************************************************************/