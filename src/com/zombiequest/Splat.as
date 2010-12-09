package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Splat extends FlxSprite 
	{
		
		private var timeLeft:Number = 7.5;
		
		[Embed(source="../../../assets/png/blood.png")]
		private var ImgBlood:Class;
		[Embed(source="../../../assets/png/blood2.png")]
		private var ImgBlood2:Class;
		
		public function Splat(X:Number, Y:Number) 
		{
			super(X, Y);
			
			var img:Class;
			var size:Number;
			if(Math.random() > 0.5)
			{
				img = ImgBlood;
				size = 64;
			}
			else
			{
				img = ImgBlood2;
				size = 32;
			}				
			
			loadGraphic(img, true, true, size, size);
			addAnimation("splat", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 2, false);
			play("splat");
		}		
		
		public override function update():void
		{
			super.update();
			
			timeLeft -= FlxG.elapsed;
			if(timeLeft <= 0)
				this.kill();
		}
	}
}