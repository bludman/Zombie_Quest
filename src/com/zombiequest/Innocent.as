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
		public function Innocent(x:Number, y:Number) 
		{
			super(x, y, ImgInnocent);
		}
		public override function update():void
		{
			super.update();
		}
	}

}