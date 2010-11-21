package com.zombiequest 
{
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
		private var healthBar:FlxSprite;
		private var level:Map;
		private var coin:Coin;
		private var currentPower:PowerEffect;
		private var statusText:FlxText;
		override public function create():void
		{
			//Instantiate objects
			player = new Player(80, 50);
			bulletGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			innocentGroup = new FlxGroup();
			level = new Level_LevelOne(true, onAddSprite);
			
			
			//add player etc.
			add(player);
			add(bulletGroup);
			
			//Set up the camera
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(level.mainLayer.left + 1, level.mainLayer.top + 1, level.mainLayer.right - 1, level.mainLayer.bottom - 1);
			FlxU.setWorldBounds(level.mainLayer.left, level.mainLayer.top, level.mainLayer.width, level.mainLayer.height);
			FlxG.mouse.hide();
			
			createHud();
			super.create();
		}
		
		override public function update():void
		{
			player.collide(enemyGroup);
			level.mainLayer.collide(player);
			level.mainLayer.collide(enemyGroup);
			FlxU.overlap(player, bulletGroup, playerGotShot);
			overlapBullets();
			if (FlxG.keys.justPressed("SPACE") ){
				FlxU.overlap(player.overlap, enemyGroup, attackEnemy);
				FlxU.overlap(player.overlap, innocentGroup, attackInnocent);
			}
			enemyShoot();
			updatePower();
			super.update();
			FlxU.overlap(player, coin, gotTheCoin);
		}
		private function createHud():void
		{
			healthBar = new FlxSprite(5, 5);
			healthBar.createGraphic(1, 8, 0xffff0000);
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			healthBar.origin.x = healthBar.origin.y = 0;
			healthBar.scale.x = 100;
			
			add(healthBar);
			statusText = new FlxText(0, 460, 320);
			statusText.color = 0xff000000;
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			add(statusText);
		}
		
		protected function onAddSprite(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Enemy)
			{
				var e:Enemy = sprite as Enemy;
				e.player = player;
				enemyGroup.add(e);
			}
			if (sprite is Innocent)
			{
				innocentGroup.add(sprite);
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
				//FIXME - Get rid of the !
				if (!enemy.hasPowerup) {
					if (currentPower != null) {
						currentPower.destroy();
					}
					currentPower = PowerupFactory.getPowerup();
					currentPower.affect(player);
					statusText.text = currentPower.flavorText();
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
			currentPower = new HalfSpeed();
			currentPower.affect(player);
			statusText.text = currentPower.flavorText();
		}
		
		protected function playerGotShot(p:FlxObject, b:FlxObject):void
		{
			player.health -= 30;
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
			currentPower.update();
			if (!currentPower.isActive()) {
				statusText.text = "";
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
			trace(player.health);
			if (player.health <= 0) {
				player.kill();
				healthBar.scale.x = 0;
				FlxG.state = new EndState("You Lost!");
			}
			healthBar.scale.x = player.health;
		}
		
	}

}