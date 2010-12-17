package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.FlxGroup;
	public class FearlessEnemy extends Enemy 
	{
		[Embed(source = "../../../assets/png/cop2.png")]
		protected static var ImgEnemy:Class;
		
		public function FearlessEnemy(X:Number, Y:Number, player:Player, minions:FlxGroup, hasPowerup:Boolean = false)  
		{
			super(X, Y, player, minions, hasPowerup);
			retreatRange = 0;
		}
		
		protected override function loadGraphics(img:Class):void
		{			
			super.loadGraphics(ImgEnemy);
		}
		
	}

}