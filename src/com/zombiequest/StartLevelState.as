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
		private var enemyGroup:FlxGroup;
		private var bulletGroup:FlxGroup;
		private var innocentGroup:FlxGroup;
		private var minionGroup:FlxGroup;
		private var collideGroup:FlxGroup;
		private var minionFactory:MinionFactory;
		private var enemyFactory:EnemyFactory;
		private var level:Map;
		private var currentPower:PowerEffect;
		public static var hudManager:HUDMaker;
		private const attackTimeout:Number = 0.5;
		private var decayRate:Number = 1;
		private var decayClock:Number = 0;
		private var attackTimer:Number = attackTimeout;
		
		override public function create():void
		{
			//Instantiate objects
			bulletGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			innocentGroup = new FlxGroup();
			minionGroup = new FlxGroup();
			collideGroup = new FlxGroup();
			level = new Level_Group1(true, onAddSprite);
			minionFactory = new MinionFactory(enemyGroup, innocentGroup, player);
			enemyFactory = new EnemyFactory(minionGroup, player);
			//give enemies reference to player
			updateEnemyPlayerRef();
			
			add(bulletGroup);
			collideGroup.add(enemyGroup);
			collideGroup.add(innocentGroup);
			collideGroup.add(minionGroup);
			
			var minion:Minion = minionFactory.getMinion(640, 480);
			minionGroup.add(minion);
			add(minion);
			var enemy:Enemy = enemyFactory.getEnemy(320, 240);
			add(enemy);
			enemyGroup.add(enemy);
			var innocent:Innocent = new Innocent(480, 400, 0);
			add(innocent);
			innocentGroup.add(innocent);
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
			player.collide(enemyGroup);
			player.collide(innocentGroup);
			FlxU.overlap(player, bulletGroup, playerGotShot);
			overlapBullets();
			playerAttack();
			enemyShoot();
			playerDecay();
			super.update();
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
				var minion:Minion = minionFactory.getMinion(enemy.x, enemy.y);
				add(minion);
				minionGroup.add(minion);
				/*if (enemy.hasPowerup) {
					if (currentPower != null) {
						currentPower.destroy();
					}
					//currentPower = PowerupFactory.getPowerup();
					currentPower = new DoubleSpeed();
					currentPower.affect(player);
					hudManager.pushStatusText(currentPower.flavorText());
				}*/
			}
		}
		protected function attackInnocent(overlap:Object, i:Object):void
		{
			var innocent:Innocent = i as Innocent;
			innocent.kill();
			player.health += 50;
			updateHealthBar();
			var minion:Minion = minionFactory.getMinion(innocent.x, innocent.y);
			add(minion);
			minionGroup.add(minion);
			/*
			if (currentPower != null) {
				currentPower.destroy();
			}
			currentPower = PowerdownFactory.getPowerdown();
			//currentPower = new LimitedVision();
			currentPower.affect(player);
			hudManager.pushStatusText(currentPower.flavorText());*/
		}
		
		protected function playerGotShot(p:FlxObject, b:FlxObject):void
		{
			player.health -= 10;
			b.kill();
			updateHealthBar();
		}
		
		protected function playerDecay():void
		{
			decayClock += FlxG.elapsed;
			if (decayClock > 1) 
			{
				player.health -= decayRate;
				decayClock = 0;
				updateHealthBar();
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
		
		public function updateEnemyPlayerRef():void
		{
			var enemyA:Array = enemyGroup.members;
			for (var i:Number = 0; i < enemyA.length; i++) {
				var enemy:Enemy = enemyA[i] as Enemy;
				enemy.player = player;
			}
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
				}
			}
		}
		
	}

}