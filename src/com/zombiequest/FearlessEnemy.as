package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.FlxGroup;
	public class FearlessEnemy extends Enemy 
	{
		public function FearlessEnemy(X:Number, Y:Number, player:Player, minions:FlxGroup, hasPowerup:Boolean = false)  
		{
			super(X, Y, player, minions, hasPowerup);
			retreatRange = 0;
		}
		
	}

}