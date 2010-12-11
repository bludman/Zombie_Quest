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
		
		private var waveOn:Boolean = false;
		private var waveTimeElapsed:Number = 0;
		private var updateTimeElapsed:Number = 0;
		
		public function EnemyFactory(minionGroup:FlxGroup, player:Player) 
		{
			this.minionGroup = minionGroup;
			this.player = player;
		}
		
		public function update():void
		{
			/* One run if wave is active */
			if(waveOn)
			{
				waveTimeElapsed += FlxG.elapsed;	//total time elapsed during wave
				updateTimeElapsed += FlxG.elapsed;	//time since the last spawn
				
				if(updateTimeElapsed > 1) 	//it's time to spawn more
				{
					/* amount is the max number of enemies on screen at a time. */
					var amount:Number = (1-Math.cos(waveTimeElapsed/30)) * 10;	//It's a wave, literally, a sine wave :P
					trace('max enemies on screen: ' + amount);
					
					/* Spawn enemies if there arent enough */
					if(StartLevelState.enemyGroup.countLiving() < amount)
					{
						spawnAll();
					}
					
					/* Stop the wave if the sine wave has gone to negatives */
					if(amount > 11) 
					{
						waveOn = false
						trace('wave ended');
					}
					
					updateTimeElapsed=0;
				}
			}
		}
		
		public function getEnemy(x:Number, y:Number, hasPowerup:Boolean = false):void
		{
			var enemy:Enemy;
			var rand:Number = Math.random();
			
			if (rand > .33 && rand < .66)
			{
				enemy = new Enemy(x, y, player, minionGroup, hasPowerup);
			}
			else if (rand >= .66)
			{
				enemy = new FearlessEnemy(x, y, player, minionGroup, hasPowerup);
			}
			else 
			{
				enemy = new CowardlyEnemy(x, y, player, minionGroup, hasPowerup);
			}
			StartLevelState.enemyGroup.add(enemy);
			StartLevelState.enemyCollideGroup.add(enemy.collideArea);
			//FlxG.state.add(enemy);
			//FlxG.state.add(enemy.collideArea);
		}
		
		
		public function startWave():void
		{
			waveOn = true;
			waveTimeElapsed = 0;
			updateTimeElapsed = 0;
			trace('wave started!');
		}
		
		public function spawnAll(hasPowerup:Boolean = false):void
		{
			spawnUp(hasPowerup);
			spawnDown(hasPowerup);
			spawnLeft(hasPowerup);
			spawnRight(hasPowerup);
		}
		
		public function spawnUp(hasPowerup:Boolean = false):void
		{
			getEnemy(640, 70, hasPowerup);
		}
		
		public function spawnDown(hasPowerup:Boolean = false):void
		{
			getEnemy(640, 920, hasPowerup);
		}
		
		public function spawnLeft(hasPowerup:Boolean = false):void
		{
			getEnemy(64, 512, hasPowerup);
		}
		
		public function spawnRight(hasPowerup:Boolean = false):void
		{
			getEnemy(1170, 512, hasPowerup);
		}
	}
	
}