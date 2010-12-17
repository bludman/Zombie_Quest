package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Collider extends FlxSprite 
	{		
		[Embed(source="../../../assets/png/roadblock.png")]
		private static var ImgBlock:Class;
		
		private var tX:Number = 0;
		private var tY:Number = 0;
		
		public function Collider(X:Number = 0, Y:Number = 0, Width:Number = 0, Height:Number = 0, Angle:Number = 0, rBlock:Boolean = false) 
		{
			tX = X;
			tY = Y;
			super(X, Y);
			if(rBlock)
				loadGraphic(ImgBlock);
			else
			{
				width = Width;
				height = Height;
				createGraphic(Width, Height, 0x00ffffff);
			}			
			angle = Angle;
		}
		
		public override function update():void
		{
			x = tX;
			y = tY;
			super.update();
		}

	}
}