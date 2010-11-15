package com.zombiequest 
{
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class StartLevelState extends FlxState 
	{
		private var _player:Player;
		private var enemy:Enemy;
		private var _healthBar:FlxSprite;
		private var level:MapTest;
		private var coin:Coin;
		private var bulletGroup:FlxGroup;
		override public function create():void
		{
			bgColor = 0xD3D3D3;
			_player = new Player();
			_player.x += 30;
			add(_player);
			level = new Level_LevelOne(true, onAddCoin);
			
			//Set up the camera
			FlxG.follow(_player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(level.mainLayer.left + 1, level.mainLayer.top + 1, level.mainLayer.right - 1, level.mainLayer.bottom - 1);
			FlxU.setWorldBounds(level.mainLayer.left, level.mainLayer.top, level.mainLayer.width, level.mainLayer.height);
			
			//Add Enemy
			bulletGroup = new FlxGroup();
			
			enemy = new Enemy(300, 300, _player);
			
			add(enemy);
			add(bulletGroup);
			
			createHud();
			FlxG.mouse.hide();
			super.create();
		}
		
		override public function update():void
		{
			_player.collide(enemy);
			level.mainLayer.collide(_player);
			level.mainLayer.collide(enemy);
			FlxU.overlap(_player, bulletGroup, playerGotShot);
			FlxU.overlap(bulletGroup, level.mainLayer, removeBullet);
			if (FlxG.keys.justPressed("SPACE") ){
				FlxU.overlap(_player.overlap, enemy, attackEnemy);
			}
			enemyShoot();
			super.update();
			if (FlxU.overlap(_player, coin, doNothing))
			{
				trace("you got the item!");
			}
		}
		private function createHud():void
		{
			_healthBar = new FlxSprite(5, 5);
			_healthBar.createGraphic(1, 8, 0xffff0000);
			_healthBar.scrollFactor.x = _healthBar.scrollFactor.y = 0;
			_healthBar.origin.x = _healthBar.origin.y = 0;
			_healthBar.scale.x = 100;
			
			add(_healthBar);
		}
		
		protected function onAddCoin(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Coin)
			{
				coin = sprite as Coin;
			}
		}
		
		protected function doNothing(... rest):Boolean
		{
			return true;
		}
		
		protected function attackEnemy(overlap:Object, e:Object):void
		{
			var enemy:Enemy = e as Enemy;
			enemy.health -= _player.damage;
			if (enemy.health <= 0) {
				enemy.kill();
			}
		}
		
		protected function playerGotShot(p:FlxObject, b:FlxObject):void
		{
			_healthBar.scale.x -= 30;
			if (_healthBar.scale.x <= 0)
			{
				_healthBar.scale.x = 0;
				_player.kill();
			}
			b.kill();
		}
		
		protected function removeBullet(b:FlxObject, layer:FlxObject):void
		{
			if (b is Bullet && level.masterLayer.collide(b) ){
				b.kill();
			}
		}
		
		protected function enemyShoot():void
		{
			//eventually should be done with all the enemies
			
			if (enemy.following) {
				enemy.lastShot += FlxG.elapsed;
				if(enemy.lastShot >= 1){
					bulletGroup.add(new Bullet(enemy.bulletSpawn(), enemy.angle));
					enemy.lastShot = 0;
				}
			}
		}
		
	}

}