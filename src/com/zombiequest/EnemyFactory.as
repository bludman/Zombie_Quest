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
		
		public function startHorde():void
		{
			spawnUp();
			spawnDown();
			spawnLeft();
			spawnRight();
		}
		
		public function spawnUp(hasPowerup:Boolean = false):void
		{
			getEnemy(640, 0, hasPowerup);
		}
		
		public function spawnDown(hasPowerup:Boolean = false):void
		{
			getEnemy(640, 1024, hasPowerup);
		}
		
		public function spawnLeft(hasPowerup:Boolean = false):void
		{
			getEnemy(0, 512, hasPowerup);
		}
		
		public function spawnRight(hasPowerup:Boolean = false):void
		{
			getEnemy(1280, 512, hasPowerup);
		}
	}
	
}