package com.zombiequest 
{
	import adobe.utils.CustomActions;
	
	import com.zombiequest.power.*;
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class StartLevelState extends FlxState 
	{		
		private const maxHealth:Number = 100;
		private var player:Player;
		private var coin:Coin;
		public static var enemyGroup:FlxGroup;
		public static var enemyCollideGroup:FlxGroup;
		public static var bulletGroup:FlxGroup;
		public static var innocentGroup:FlxGroup;
		public static var minionGroup:FlxGroup;
		public static var collideGroup:FlxGroup;
		public static var mapLayer:FlxGroup;
		private var minionFactory:MinionFactory;
		private var enemyFactory:EnemyFactory;
		private var level:Map;
		public static var hudManager:HUDMaker;
		private var currentPower:PowerEffect;
		private const attackTimeout:Number = 0.5;
		
		/* Sprite layers */
		public static var underGroup:FlxGroup;	//for blood splats
		public static var overGroup:FlxGroup;	//for HUD
		
		/**Number of seconds between release of enemies 
		 * Assumes constant time between waves
		 */
		private const WAVE_TIMEOUT:Number=20;
		
		
		private var decayRate:Number = .1;
		private var minionDecayRate:Number = 1;
		private var decayTimeout:Number = .1;
		private var decayClock:Number = 0;
		private var waveTimer:Number = WAVE_TIMEOUT;
		private var attackTimer:Number = attackTimeout;
		
		override public function create():void
		{
			underGroup = new FlxGroup();
			overGroup = new FlxGroup();
			
			//Instantiate objects
			bulletGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			enemyCollideGroup = new FlxGroup();
			innocentGroup = new FlxGroup();
			minionGroup = new FlxGroup();
			collideGroup = new FlxGroup();
			level = new Level_Group1(true, onAddSprite);
			minionFactory = new MinionFactory(player);
			enemyFactory = new EnemyFactory(minionGroup, player);
			
			add(bulletGroup);
			collideGroup.add(enemyCollideGroup);
			collideGroup.add(innocentGroup);
			collideGroup.add(minionGroup);
			
			enemyFactory.startWave();
			
			//Set up the camera
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(Map.boundsMinX, Map.boundsMinY, Map.boundsMaxX, Map.boundsMaxY);
			FlxG.mouse.hide();
			hudManager = new HUDMaker();
		}
		
		override public function update():void
		{
			FlxU.collide(level.hitTilemaps, collideGroup);
			FlxU.collide(level.hitTilemaps, player);
			collideGroup.collide();
			player.collide(enemyCollideGroup);
			player.collide(innocentGroup);
			FlxU.overlap(player, bulletGroup, zombieGotShot);
			FlxU.overlap(minionGroup, bulletGroup, zombieGotShot);
			overlapBullets();
			playerAttack();
			enemyShoot();
			armyControl();
			zombieDecay();
			updateHealthBar();
			updateWaveStatus();
			super.update();
			
			/* Update Others */
			mapLayer.update();
			enemyFactory.update();
			underGroup.update();
			overGroup.update();
		}
		
		protected function onAddSprite(obj:Object, layer:FlxGroup, level:Map, properties:Array):Object
		{
			if (obj is Player) {
				player = obj as Player;
			}
			return obj;
		}
		
		protected function gotTheCoin(...rest):void
		{
			FlxG.state = new EndState("You Won, fuck yeah!!");
		}
		
		protected function attackEnemy(overlap:Object, e:Object):void
		{
			var enemy:Enemy = e as Enemy;
			enemy.health -= player.damage;
			enemy.updateHealthbar();
			if (enemy.dead) {
				player.health += Enemy.healthRegen;
				minionFactory.getMinion(enemy.x, enemy.y);
			}
			
			bloodSplat(enemy.x, enemy.y);
		}
		protected function attackInnocent(overlap:Object, i:Object):void
		{
			var innocent:Innocent = i as Innocent;
			innocent.kill();
			player.health += Innocent.healthRegen;
			minionFactory.getMinion(innocent.x, innocent.y);
			
			bloodSplat(innocent.x, innocent.y);
		}
		
		public static function bloodSplat(x:Number, y:Number, zombie:Boolean = false):void
		{
			var splat:Splat = new Splat(x, y, zombie);
			underGroup.add(splat);
		}
		
		protected function zombieGotShot(p:FlxObject, b:FlxObject):void
		{
			if (p is Minion || p is Player) {
				p.health -= 10;
				if (p.health <= 0) {
					p.kill();
				}
			}
			b.kill();
			bloodSplat(p.x, p.y, true); //true because it is a zombie splat
			
			if(p is Minion)
				Minion(p).playHurtSound();
			if(p is Player)
				Player(p).playHurtSound();
		}
		
		protected function zombieDecay():void
		{
			decayClock += FlxG.elapsed;
			if (decayClock > decayTimeout) 
			{
				player.health -= decayRate;
				var minions:Array = minionGroup.members;
				for (var i:Number = 0; i < minions.length; i++)
				{
					var minion:Minion = minions[i] as Minion;
					minion.health -= minionDecayRate;
					if (minion.health <= 0)
					{
						minion.kill();
						minionGroup.remove(minion, true);
					}
				}
				decayClock = 0;
			}
		}

		/** 
		 * Keep track of when the next wave should come and trigger it
		 */
		protected function updateWaveStatus():void
		{
			//I like how some timers go from TIMEOUT to 0, others go from 0 to TIMEOUT
			waveTimer -= FlxG.elapsed;
			if (waveTimer <=0) 
			{
				waveTimer = WAVE_TIMEOUT;
				//triggerWave();
				//enemyFactory.startHorde();
			}
		}
		
		
		protected function overlapBullets():void
		{
			var bullets:Array = bulletGroup.members;
			for (var i:Number = 0; i < bullets.length; i++)
			{
				var bullet:Bullet = bullets[i] as Bullet;
				if (level.hitTilemaps.collide(bullet)) {
					bullet.kill();
				}
			}
		}
		
		protected function enemyShoot():void
		{
			var enemyA:Array = enemyGroup.members;
			for each (var enemy:Enemy in enemyA) {
				if (enemy.shooting && !enemy.dead && !player.dead) {
					enemy.lastShot += FlxG.elapsed;
					if (enemy.lastShot >= enemy.shotTimeout) {
						var p:FlxPoint = enemy.bulletSpawn();
						var a:Number = FlxU.getAngle(player.x - p.x, player.y - p.y);
						bulletGroup.add(new Bullet(p, a));
						enemy.lastShot = 0;
					}
				}
			}
		}
		
		protected function updatePower():void
		{
			if (currentPower == null)
			{
				return;
			}
			currentPower.updateTime();
			if (!currentPower.isActive()) {
				hudManager.clearStatusText();
			}
			else
			{
				hudManager.updatePowerTimer(currentPower.timeRemaining());
			}
		}
		/**
		 * 
		 *
		 * Call whenever the player's health is changed
		 * CHANGE: Now called from update, doesn't need to be called elsewhere
		 */
		protected function updateHealthBar():void
		{
			if (player.health > maxHealth) {
				player.health = maxHealth;
			}
			if (player.health <= 0) {
				player.kill();
				hudManager.setHealth(0);
				FlxG.state = new EndState("You Lost!");
			}
			hudManager.setHealth(player.health);
		}
		
		protected function playerAttack():void
		{
			attackTimer += FlxG.elapsed;
			if (FlxG.keys.justPressed("SPACE"))
			{
				if (attackTimer >= attackTimeout) 
				{
					FlxU.overlap(player.overlap, enemyGroup, attackEnemy);
					FlxU.overlap(player.overlap, innocentGroup, attackInnocent);
					attackTimer = 0;
					
					player.playAttackSound();
				}
			}
		}
		
		protected function armyControl():void
		{
			var minion:Minion = null;
			if (FlxG.keys.justPressed("A")) 
			{
				minion = nextMinion();
				if (minion != null)
				{
					minion.state == Minion.ATTACKING;
					minion.findTarget();
				}
			}
			else if (FlxG.keys.justPressed("S"))
			{
				minion = nextMinion();
				if (minion != null)
				{
					minion.state = Minion.SENTRY;
				}
			}
			else if (FlxG.keys.justPressed("D"))
			{
				var minions:Array = minionGroup.members;
				for (var i:Number = 0; i < minions.length; i++)
				{
					Minion(minions[i]).state = Minion.DEFENDING;
				}
			}
		}
		/**
		 * Finds the next minion with the DEFENDING state
		 */
		protected function nextMinion():Minion
		{
			var minions:Array = minionGroup.members;
			var closest:Number = 2000; // greater than the length of the map
			var candidate:Minion = null;
			for (var i:Number = 0; i < minions.length; i++)
			{
				var minion:Minion = minions[i] as Minion;
				if (minion.state == Minion.DEFENDING && !minion.dead)
				{
					var dist:Number = MathU.dist(player.x - minion.x, player.y - minion.y);
					if (dist < closest)
					{
						closest = dist;
						candidate = minion;
					}
				}
			}
			return candidate;
		}
		
		/* This must be done to render the HUD above all else */
		override public function render():void
		{			
			mapLayer.render();
			
			/* Render Under */
			underGroup.render();
			
			super.render();	
			
			/* Render Over */	
			overGroup.render();
		}
	}

}