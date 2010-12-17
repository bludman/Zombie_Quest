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
		[Embed(source="../../../assets/png/roadblock2.png")]
		private static var ImgBlock2:Class;
		
		private var tX:Number = 0;
		private var tY:Number = 0;
		
		public function Collider(X:Number = 0, Y:Number = 0, Width:Number = 0, Height:Number = 0, Angle:Number = 0, rBlock:Number = 0) 
		{
			tX = X;
			tY = Y;
			super(X, Y);
			if(rBlock == 1)
			{
				loadGraphic(ImgBlock);
			}
			else if (rBlock == 2)
			{
				loadGraphic(ImgBlock2);
			}
			else
			{
				width = Width;
				height = Height;
				createGraphic(Width, Height, 0x00ffffff);
			}
			fixed = true;
			angle = Angle;
		}

	}
}