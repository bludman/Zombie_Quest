package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Splat extends FlxSprite 
	{
		
		private var timeLeft = 5;
		
		[Embed(source="../../../assets/png/blood.png")]
		private var ImgBlood:Class;
		
		public function Splat(X:Number, Y:Number) 
		{
			super(X, Y, ImgBlood);
		}		
		
		public override function update():void
		{
			timeLeft -= FlxG.elapsed;
			if(timeLeft <= 0)
				this.kill();
		}
	}
}