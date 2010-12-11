package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MinionCorpse extends FlxSprite 
	{
		
		private var timeLeft:Number = 7.5;
		
		[Embed(source="../../../assets/png/deadZombie.png")]
		private static var ImgCorpse:Class;
		
		public function MinionCorpse(X:Number, Y:Number) 
		{
			super(X, Y, ImgCorpse);				
			
			//loadGraphic(img, true, true, size, size);
			//addAnimation("splat", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], 2, false);
			//play("splat");
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