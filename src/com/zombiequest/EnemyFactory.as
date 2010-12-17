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
		
		/* wave variables */
		private var waveAmount:Number = 20; //enemy spawn amount
		private var waveDuration:Number = 120;	//in seconds
		
		public function EnemyFactory(minionGroup:FlxGroup, player:Player) 
		{
			this.minionGroup = minionGroup;
			this.player = player;
			startWave();
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
					var amount:Number = Math.min(waveAmount, waveTimeElapsed/4);	//It's a wave
					/* Spawn enemies */
					if(StartLevelState.enemyGroup.countLiving() , amount)
						spawnAll(amount/100);
					
					/* Stop the wave if the sine wave has gone to negatives */
					if(waveTimeElapsed > waveDuration) 
					{
						waveOn = false;
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
			spawnAll(.5);
		}
		
		public function spawnAll(chance:Number, hasPowerup:Boolean = false):void
		{
			var roll:Number = Math.random();
			if(roll < chance)
			{
				spawnUp(hasPowerup);
			}
			roll = Math.random();
			if(roll < chance)
			{
				spawnDown(hasPowerup);
			}
			roll = Math.random();
			if(roll < chance)
			{
				spawnLeft(hasPowerup);
			}
			roll = Math.random();
			if(roll < chance)
			{
				spawnRight(hasPowerup);
			}
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