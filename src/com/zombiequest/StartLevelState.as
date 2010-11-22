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
		private var enemyGroup:FlxGroup;
		private var bulletGroup:FlxGroup;
		private var innocentGroup:FlxGroup;
		private var collideGroup:FlxGroup;
		private var level:Map;
		private var currentPower:PowerEffect;
		private var hudManager:HUDMaker;
		
		override public function create():void
		{
			//Instantiate objects
			player = new Player(10, 280);
			bulletGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			innocentGroup = new FlxGroup();
			collideGroup = new FlxGroup();
			level = new Level_LevelOne(true, onAddSprite);
			
			//give enemies reference to player
			updateEnemyPlayerRef();
			
			add(bulletGroup);
			collideGroup.add(enemyGroup);
			collideGroup.add(innocentGroup);
			collideGroup.add(player);
			
			//Set up the camera
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(level.boundsMinX, level.boundsMinY, level.boundsMaxX, level.boundsMaxY);
			FlxG.showBounds = true;
			FlxG.mouse.hide();
			player.x += 192;
			player.y -= 192;
			hudManager = new HUDMaker();
		}
		
		override public function update():void
		{
			collideGroup.collide();
			FlxU.collide(level.mainLayer, collideGroup);
			FlxU.overlap(player, bulletGroup, playerGotShot);
			overlapBullets();
			if (FlxG.keys.justPressed("SPACE") ){
				FlxU.overlap(player.overlap, enemyGroup, attackEnemy);
				FlxU.overlap(player.overlap, innocentGroup, attackInnocent);
			}
			enemyShoot();
			updatePower();
			super.update();
		}
		
		protected function onAddSprite(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Enemy)
			{
				enemyGroup.add(sprite as Enemy);
			}
			if (sprite is Innocent)
			{
				innocentGroup.add(sprite);
			}
			if (sprite is Player) {
				player = sprite as Player;
			}
			
		}
		
		protected function gotTheCoin(...rest):void
		{
			FlxG.state = new EndState("You Won!");
		}
		
		protected function attackEnemy(overlap:Object, e:Object):void
		{
			var enemy:Enemy = e as Enemy;
			enemy.health -= player.damage;
			enemy.updateHealthbar();
			if (enemy.dead) {
				if (enemy.hasPowerup) {
					if (currentPower != null) {
						currentPower.destroy();
					}
					currentPower = PowerupFactory.getPowerup();
					currentPower.affect(player);
					hudManager.pushStatusText(currentPower.flavorText());
				}
			}
		}
		protected function attackInnocent(overlap:Object, i:Object):void
		{
			var innocent:Innocent = i as Innocent;
			innocent.kill();
			player.health += 50;
			updateHealthBar();
			if (currentPower != null) {
				currentPower.destroy();
			}
			currentPower = PowerdownFactory.getPowerdown();
			currentPower.affect(player);
			hudManager.pushStatusText(currentPower.flavorText());
		}
		
		protected function playerGotShot(p:FlxObject, b:FlxObject):void
		{
			player.health -= 10;
			b.kill();
			updateHealthBar();
		}
		
		protected function overlapBullets():void
		{
			var bullets:Array = bulletGroup.members;
			for (var i:Number = 0; i < bullets.length; i++)
			{
				var bullet:Bullet = bullets[i] as Bullet;
				if (level.mainLayer.collide(bullet)) {
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
		}
		/**
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
		
	}

}