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
		//public const maxHealth:Number = 500;
		private var player:Player;
		private var selectedMinion:Minion = null;
		private var coin:Coin;
		public static var enemyGroup:FlxGroup;
		public static var enemyCollideGroup:FlxGroup;
		public static var bulletGroup:FlxGroup;
		public static var innocentGroup:FlxGroup;
		public static var minionGroup:FlxGroup;
		public static var collideGroup:FlxGroup;
		public static var minionFactory:MinionFactory;
		public static var enemyFactory:EnemyFactory;
		public static var mapMaker:MapGenerator;
		public static var playerBrainCount:Number = 0;
		public static var minionBrainCount:Number = 0;
		public static var playClock:Number = 0;
		public static var level:Map;
		public static var hudManager:HUDMaker;
		private var currentPower:PowerEffect;
		private const attackTimeout:Number = 0.5;
		
		/* Sprite layers */
		public static var mapGroup:FlxGroup;	//for the map
		public static var underGroup:FlxGroup;	//for blood splats
		public static var overGroup:FlxGroup;	//for HUD
		
		/**Number of seconds between release of enemies 
		 * Assumes constant time between waves
		 */
		private const WAVE_TIMEOUT:Number=20;
		
		private var decayRate:Number = .5;
		private var minionDecayRate:Number = .5;
		private var decayTimeout:Number = .1;
		private var decayClock:Number = 0;
		private var waveTimer:Number = WAVE_TIMEOUT;
		private var attackTimer:Number = attackTimeout;
		
		private var flashTimer:Number = 0;
		//private var whiteFlash:FlxSprite;
		
		
		override public function create():void
		{
			mapGroup = new FlxGroup();
			underGroup = new FlxGroup();
			overGroup = new FlxGroup();
			
			//Instantiate objects
			playerBrainCount = 0;
			minionBrainCount = 0;
			playClock = 0;
			player = new Player(640,480);
			bulletGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			enemyCollideGroup = new FlxGroup();
			innocentGroup = new FlxGroup();
			minionGroup = new FlxGroup();
			collideGroup = new FlxGroup();
			level = new Level_Group1(true, onAddSprite);
			minionFactory = new MinionFactory(player);
			enemyFactory = new EnemyFactory(minionGroup, player);
			mapMaker = new MapGenerator();
			
			add(bulletGroup);
			collideGroup.add(enemyCollideGroup);
			collideGroup.add(innocentGroup);
			collideGroup.add(minionGroup);
			
			//Set up the camera
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(Map.boundsMinX, Map.boundsMinY, Map.boundsMaxX, Map.boundsMaxY);
			FlxG.mouse.hide();
			hudManager = new HUDMaker();
			
			//whiteFlash = new FlxSprite(0,0);
			//whiteFlash.createGraphic(640, 480, 0x88ffffff); //White frame for the health bar
			//whiteFlash.scrollFactor.x = whiteFlash.scrollFactor.y = 0;
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
			aimedEnemy();
			//flashPlayer();
			super.update();
			
			/* Update Others */
			player.update();
			enemyFactory.update();
			underGroup.update();
			overGroup.update();
			enemyGroup.update();
			enemyCollideGroup.update();
			minionGroup.update();
			hudManager.update();
			mapGroup.update();
			playClock += FlxG.elapsed;
			
			selectedMinion = nextMinion();
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
			//hah - this never happens.  there is no winning.
			//just losing and losing.
			FlxG.state = new EndState("You Won, fuck yeah!!");
		}
		
		protected function attackEnemy(overlap:Object, e:Object):void
		{
			var enemy:Enemy = e as Enemy;
			enemy.health -= player.damage;
			enemy.updateHealthbar();
			if (enemy.dead) {
				playerBrainCount++;
				player.health += Enemy.healthRegen;
				minionFactory.getMinion(enemy.x, enemy.y);
			}
			else
			{
				enemy.playHitSound();
			}
			bloodSplat(enemy.x, enemy.y);
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
			{
				Minion(p).playHurtSound();
			}
			if(p is Player)
			{				
				hudManager.flicker();
				Player(p).playHurtSound();
			}
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
						var a:Number = /*FlxU.getAngle(player.x - p.x, player.y - p.y);*/enemy.angle;
						bulletGroup.add(new Bullet(p, a));
						enemy.lastShot = 0;
					}
				}
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
			if (player.health > Player.maxHealth) {
				player.health = Player.maxHealth;
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
					attackTimer = 0;
					
					player.playAttackSound();
				}
			}
		}
		
		protected function armyControl():void
		{
			if (FlxG.keys.justPressed("A")) 
			{
				if(selectedMinion!=null)
				{
					var nextEnemy:Enemy = aimedEnemy();
					selectedMinion.findTarget(-1, nextEnemy);
				}
					
				/*
				minions = minionGroup.members;
				for each (var m:Minion in minions)
				{
					m.findTarget();
				}
				*/
			}
			else if (FlxG.keys.justPressed("S"))
			{
				for each (var m1:Minion in minionGroup.members)
				{
					m1.findTarget();
				}
			}
			else if (FlxG.keys.justPressed("D"))
			{
				for each (var m2:Minion in minionGroup.members)
				{
					m2.state = Minion.DEFENDING;
				}
			}
		}
		
		/**
		 * Finds an enemy that is in the viewport at the lowest angle
		 */
		protected function aimedEnemy():Enemy
		{
			var selected:Enemy = null;
			if(minionGroup.countLiving() <= 0)
				return selected;
			
			var angle:Number = 361;
			for each (var e:Enemy in enemyGroup.members)
			{
				e.glowing = false
				var ePos:FlxPoint = e.getScreenXY(ePos);
				
				if (ePos.x >= 640 || ePos.y >= 480 || ePos.x <= 0 || ePos.y <= 0)
					continue;
				
				var newAngle:Number = Math.abs(FlxU.getAngle(e.x-player.x, e.y-player.y) - player.angle);
				if(newAngle < angle)
				{
					angle = newAngle;
					selected = e;
				}
			}
			if(selectedMinion != null && selected != null)
				selected.glowing = true;
			return selected;
		}		
		
		/**
		 * Finds the next minion with the DEFENDING state
		 */
		protected function nextMinion():Minion
		{
			var closest:Number = 2000; // greater than the length of the map
			var candidate:Minion = null;
			for each (var min:Minion in minionGroup.members)
			{
				if (min.state == Minion.DEFENDING && !min.dead)
				{
					var dist:Number = MathU.dist(player.x - min.x, player.y - min.y);
					if (dist < closest)
					{
						closest = dist;
						candidate = min;
					}
				}
			}
			return candidate;
		}
		
		public static function generateClock():String
		{	
			var displayClock:String = ":::";
			var sec:Number = playClock;
			var h:Number=Math.floor(sec/3600);
			var m:Number=Math.floor((sec%3600)/60);
			var s:Number=Math.floor((sec%3600)%60);
			displayClock = (h == 0?"":(h < 10?"0" + h.toString() + ":":h.toString() + ":")) + (m < 10?"0" + m.toString():m.toString()) + ":" + (s < 10?"0" + s.toString():s.toString());
			return displayClock;
		}
		
		public static function calculateScore():String
		{	
			var score:Number = (200 * playerBrainCount) + (minionBrainCount * 100) + (Math.floor(playClock) * 10);
			
			return score.toString(); 
		}
		
		/* This must be done to render the HUD above all else */
		override public function render():void
		{	
			mapGroup.render();
			
			super.render();	
			
			/* Render Under */
			underGroup.render();
			
			enemyGroup.render();
			enemyCollideGroup.render();
			minionGroup.render();
			player.render();
			
			//if(flashTimer > 0)
			//	whiteFlash.render();
			
			/* Render Over */	
			overGroup.render();
		}
	
	}

}