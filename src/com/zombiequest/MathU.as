package com.zombiequest 
{
	import org.flixel.FlxPoint;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MathU 
	{
		
		public function MathU() 
		{
			
		}
		
		public static function degToRad(degrees:Number):Number {
			return Math.PI * degrees / 180;
		}
		public static function dist(x:Number, y:Number):Number
		{
			return Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2));
		}
	}

}