package com.zombiequest 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Innocent extends FlxSprite
	{
		[Embed(source = "../../../assets/png/oldinnocent.png")]
		private var ImgInnocent:Class;
		private var speed:Number = 20;
		
		public function Innocent(x:Number, y:Number) 
		{
			super(x, y, ImgInnocent);
			loadGraphic(ImgInnocent, true, true, 24, 24);
			calcFrame();
		}
		public override function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			super.update();
		}
	}

	}