package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.*;
	public class CowardlyEnemy extends Enemy 
	{
		
		public function CowardlyEnemy(X:Number, Y:Number, player:Player, minions:FlxGroup, hasPowerup:Boolean = false) 
		{
			super(X, Y, player, minions, hasPowerup);
			retreatRange = 150;
		}
		
	}

}