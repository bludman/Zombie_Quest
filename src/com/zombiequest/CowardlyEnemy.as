package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.*;
	public class CowardlyEnemy extends Enemy 
	{
		[Embed(source = "../../../assets/png/cop2.png")]
		protected static var ImgEnemy:Class;
		
		public function CowardlyEnemy(X:Number, Y:Number, player:Player, minions:FlxGroup, hasPowerup:Boolean = false) 
		{
			retreatRange = 150;
			super(X, Y, player, minions, hasPowerup);
		}
		
		protected override function loadGraphics():void
		{			
			loadGraphic(ImgEnemy, true, true, 42, 42);
			addAnimation("walk", [0, 1, 2, 1, 0, 3, 4], 10);
			addAnimation("shoot", [5], 1);
			addAnimation("walk-glow", [6, 7, 8, 7, 6, 9, 10], 10);
			addAnimation("shoot-glow", [11], 1);
			play("walk");
		}
	}

}