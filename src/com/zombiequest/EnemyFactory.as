package com.zombiequest 
{
	import org.flixel.*;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class EnemyFactory extends FlxObject
	{
		private var minionGroup:FlxGroup;
		private var player:Player;
		
		private var hordeOn:Boolean = false;
		private var timeElapsed:Number = 0;
		
		public function EnemyFactory(minionGroup:FlxGroup, player:Player) 
		{
			this.minionGroup = minionGroup;
			this.player = player;
		}
		
		public override function update():void
		{
			//THIS DOES NOT WORK!!!!
			//Maybe because update is only called for objects added to the stage
			if(hordeOn)
			{
				timeElapsed += FlxG.elapsed;
				if(timeElapsed > .1) {
					if(Math.random() > 0.7) {
						spawnUp();
					}
					if(Math.random() > 0.7) {
						spawnDown();
					}
					if(Math.random() > 0.7) {
						spawnLeft();
					}
					if(Math.random() > 0.7) {
						spawnRight();
					}
				}
			}
		}
		
		public function getEnemy(x:Number, y:Number, hasPowerup:Boolean = false):void
		{
			var enemy:Enemy = new Enemy(x, y, player, hasPowerup);
			StartLevelState.enemyGroup.add(enemy);
			StartLevelState.enemyCollideGroup.add(enemy.collideArea);
			FlxG.state.add(enemy);
			FlxG.state.add(enemy.collideArea);
		}
		
		
		public function startHorde():void
		{
			hordeOn = true;
			
			spawnUp();
			spawnDown();
			spawnRight();
			spawnLeft();
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