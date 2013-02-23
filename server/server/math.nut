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

class Math
{

	constructor ( )
	{
	
	}
	
	function random ( min = 0, max = RAND_MAX )
	{
	   srand ( getTickCount ( ) * rand ( ) );
	   return ( rand ( ) % ( ( max + 1 ) - min ) ) + min;
	}
	
	function isnumeric ( string )
	{
	   try
	   {
		  string.tointeger ( )
	   }
	   catch ( string )
	   {
		  return 0;
	   }
	   return 1;
	}
	
	function distance ( pos1, pos2 )
	{
		return getDistanceBetweenPoints3D ( 
			pos1[0].tofloat ( ), 
			pos1[1].tofloat ( ), 
			pos1[2].tofloat ( ), 
			pos2[0].tofloat ( ), 
			pos2[1].tofloat ( ), 
			pos2[2].tofloat ( )
		);
	}
	
	function hypotnuse ( a, b )
	{
		if ( !isnumeric ( a ) || !isnumeric ( b) )
			return false;
		
		return sqrt ( pow ( a, 2 ) + pow ( b, 2 ) );
	}
	
	function area ( a, b )
	{
		if ( !isnumeric ( a ) || !isnumeric ( b) )
			return false;
			
		return ( a * b );
	}
	
	function perimeter ( a, b )
	{
		if ( !isnumeric ( a ) || !isnumeric ( b ) )
			return false;
		
		return ( 2 * ( a + b ) );
	}
	
	function mean ( table )
	{
		local sum = 0;
		local n = 0;
		foreach ( integer in table )
		{
			if ( isnumeric ( integer ) )
			{
				sum = sum + integer;
				n++;
			}
		}
		return ( sum / n );
	}
	
	function mode ( table )
	{
		local t = { };
		foreach ( key, value in table )
		{
			if ( !t.rawin ( value ) )
				t[value] <- 1;
			else
				t[value]++;
		}
		
		local n = { f = 0, val = false };
		foreach ( value, num in t )
		{
			if ( num > n.f )
			{
				n.f = num;
				n.val = value;
			}
		}
		
		return n.value;
	}
	
	function median ( table )
	{
		table.sort ( @( a, b ) a <=> b );
		local n = table.len ( );
		if ( n % 2 == 0 )
		{
			local i = ( n / 2 );
			return ( ( table[ i - 1 ] + table[ i ] ) / 2 );
		}
		else
		{
			local i = ( ( n - 1 ) / 2 );
			return table [ i ];
		}
	}
	
	function double ( val )
	{
		if ( !isnumeric ( val ) )
			return false;
		return ( val * 2 );
	}
	
	function half ( val )
	{
		if ( !isnumeric ( val ) )
			return false;
		return ( val / 2 );
	}
	
	function range ( table )
	{
		local min = false;
		local max = false;
		foreach ( key, value in table )
		{
			if ( !min && ! max )
			{
				min = value;
				max = value;
			}
			else
			{
				if ( value < min )
					min = value;
				
				if ( value > max )
					max = value;
			}
		}
		if ( !min || !max )
			return false;
			
		return ( max - min );
	}
	
	function minimum ( table )
	{
		local min = false;
		foreach ( key, value in table )
		{
			if ( !min )
				min = value;
			else
			{
				if ( value < min )
					min = value;
			}
		}
		
		if ( !min )
			return false;
		return min;
	}
	
	function maxinum ( table )
	{
		local max = false;
		foreach ( key, value in table )
		{
			if ( !max )
				max = value;
			else
			{
				if ( value > max )
					max = value;
			}
		}
		
		if ( !max )
			return false;
		return max;
	}
	
	function standard_deviation ( table )
	{
		local n = table.len ( );
		local sum = 0;
		local num = 0;
		local div = ( n * ( n - 1 ) );
		local result = false;
		
		foreach ( key, value in table )
		{
			value = pow ( value, 2 );
			sum = sum + value;
		}
		sum = sum * n;
		
		foreach ( key, value in table )
		{
			num = num + value;
		}
		num = pow ( num, 2 );

		sum = ( sum - num );
		sum = ( sum / div );
		result = ( sqrt ( sum ) );
		
		if ( !result )
			return false;
		return result;
	}
	
	function predict_y ( table, x )
	{
	
		local result = false;
		local sumx = 0;
		local sumy = 0;
		local sumxy = 0;
		local sumx2 = 0;
		
		foreach ( id, arr in table )
		{
			local x = arr[0];
			local y = arr[1];
			sumx = sumx + x;
			sumy = sumy + y;
			sumxy = ( sumxy + ( x * y ) );
			sumx2 = ( sumx2 + ( pow ( x, 2 ) ) );
		}
		
		local a = ( ( sumy * sumx2 ) - ( sumx * sumxy ) );
		local b = ( ( table.len ( ) * sumx2 ) - ( pow ( sumx, 2 ) ) );
		local c = ( ( table.len ( ) * sumxy ) - ( sumx * sumy ) );
		local d = ( ( table.len ( ) * sumx2 ) - ( pow ( sumx, 2 ) ) );
		
		local intercept = ( a / b );
		local slope = ( c / d );
		
		result = ( intercept + ( slope * x ) );
		return result;
	}

};