package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.*;
	public class CowardlyEnemy extends Enemy 
	{
		[Embed(source = "../../../assets/png/cop3.png")]
		protected static var ImgEnemy:Class;
		
		public function CowardlyEnemy(X:Number, Y:Number, player:Player, minions:FlxGroup, hasPowerup:Boolean = false) 
		{
			retreatRange = 150;
			super(X, Y, player, minions, hasPowerup);
		}
		
		protected override function loadGraphics(img:Class):void
		{			
			super.loadGraphics(ImgEnemy);
		}
	}

}