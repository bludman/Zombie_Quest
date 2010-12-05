package com.zombiequest 
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MinionFactory 
	{
		private var enemyGroup:FlxGroup;
		private var innocentGroup:FlxGroup;
		private var player:Player;
		public function MinionFactory(enemyGroup:FlxGroup, innocentGroup:FlxGroup, player:Player) 
		{
			this.enemyGroup = enemyGroup;
			this.innocentGroup = innocentGroup;
			this.player = player;
		}
		
		public function getMinion(x:Number, y:Number):Minion
		{
			return new Minion(x, y, enemyGroup, innocentGroup, player);
		}
	}

}