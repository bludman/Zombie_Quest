package com.zombiequest 
{
	import org.flixel.*;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class EnemyFactory 
	{
		private var minionGroup:FlxGroup;
		private var player:Player;
		public function EnemyFactory(minionGroup:FlxGroup, player:Player) 
		{
			this.minionGroup = minionGroup;
			this.player = player;
		}
		
		public function getEnemy(x:Number, y:Number, hasPowerup:Boolean = false):void
		{
			var enemy:Enemy = new Enemy(x, y, player, hasPowerup);
			StartLevelState.enemyGroup.add(enemy);
			FlxG.state.add(enemy);
		}
		
		//public function 
	}
	
}