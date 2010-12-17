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