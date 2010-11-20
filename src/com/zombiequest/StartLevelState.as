package com.zombiequest 
{
	import com.zombiequest.power.DoubleDamage;
	import com.zombiequest.power.DoubleSpeed;
	import com.zombiequest.power.PowerEffect;
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class StartLevelState extends FlxState 
	{
		private var player:Player;
		private var enemyGroup:FlxGroup;
		private var bulletGroup:FlxGroup;
		private var healthBar:FlxSprite;
		private var level:Map;
		private var coin:Coin;
		private var currentPower:PowerEffect;
		private var statusText:FlxText;
		private var statusTimer:Number = 0;
		private var statusTimeout:Number = 10;
		override public function create():void
		{
			//Instantiate objects
			player = new Player(80, 50);
			bulletGroup = new FlxGroup();
			enemyGroup = new FlxGroup();
			level = new Level_LevelOne(true, onAddSprite);
			
			
			//add player etc.
			add(player);
			add(bulletGroup);
			add(enemyGroup);
			
			
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
			statusText = new FlxText(0, 230, 320);
			statusText.color = 0xff000000;
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			add(statusText);
		}
		
		protected function onAddSprite(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Coin)
			{
				coin = sprite as Coin;
			}
			if (sprite is Enemy)
			{
				var e:Enemy = sprite as Enemy;
				e.player = player;
				enemyGroup.add(sprite as Enemy);
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
			if (enemy.health <= 0) {
				enemy.kill();
				if (enemy.hasPowerup) {
					if (currentPower != null) {
						currentPower.destroy();
					}
					currentPower = new DoubleSpeed();
					currentPower.affect(player);
					statusText.text = currentPower.flavorText();
					statusTimer = 0;
				}
			}
		}
		
		protected function playerGotShot(p:FlxObject, b:FlxObject):void
		{
			player.health -= 30;
			healthBar.scale.x = player.health;
			if (player.health <= 0)
			{
				healthBar.scale.x = 0;
				player.kill();
				FlxG.state = new EndState("You lost!");
			}
			b.kill();
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
					if (enemy.lastShot >= 1) {
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
		}
		
	}

}