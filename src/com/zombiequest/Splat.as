package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Splat extends FlxSprite 
	{
		
		private var timeLeft:Number = 3;
		
		[Embed(source="../../../assets/png/blood.png")]
		private static var ImgBlood:Class;
		[Embed(source="../../../assets/png/blood2.png")]
		private static var ImgBlood2:Class;
		
		[Embed(source="../../../assets/png/zombie_blood.png")]
		private static var ImgZombieBlood:Class;
		[Embed(source="../../../assets/png/zombie_blood2.png")]
		private static var ImgZombieBlood2:Class;
		
		public function Splat(X:Number, Y:Number, zombie:Boolean = false) 
		{
			super(X, Y);
			
			var img:Class;
			var size:Number;
			
			if(zombie) 
			{
				if(Math.random() > 0.5)
				{
					img = ImgZombieBlood;
					size = 64;
				}
				else
				{
					img = ImgZombieBlood2;
					size = 64;
				}
			}
			else 
			{				
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
			}				
			
			loadGraphic(img, true, true, size, size);
			addAnimation("splat", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 5, false);
			play("splat");
			facing = Math.round(Math.random() * 3);
		}		
		
		public override function update():void
		{
			super.update();
			
			timeLeft -= FlxG.elapsed;
			if(timeLeft <= 0) {
				this.kill();
			}
		}
		
		public override function kill():void
		{
			StartLevelState.underGroup.remove(this, true);
			super.kill();
		}
	}
}