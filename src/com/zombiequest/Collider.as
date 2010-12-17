package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Collider extends FlxSprite 
	{		
		var tX:Number = 0;
		var tY:Number = 0;
		
		public function Collider(X:Number = 0, Y:Number = 0, Width:Number = 0, Height:Number = 0, Angle:Number = 0) 
		{
			tX = X;
			tY = Y;
			super(X, Y);
			createGraphic(Width, Height, 0x88ffffff);
			angle = Angle;
		}
		
		public override function update():void
		{
			super.update();
			x = tX;
			y = tY;
		}

	}
}