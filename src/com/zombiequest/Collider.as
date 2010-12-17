package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Collider extends FlxSprite 
	{		
		public function Collider(X:Number = 0, Y:Number = 0, Width:Number = 0, Height:Number = 0, Angle:Number = 0) 
		{
			super(X, Y);
			createGraphic(Width, Height, 0x88ffffff);
			angle = Angle;
		}
	}
}