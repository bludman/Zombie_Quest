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
			level = new Level_Group1(true, onAddSprite);			
			//give enemies reference to player
			updateEnemyPlayerRef();
			
			add(bulletGroup);
			collideGroup.add(enemyGroup);
			collideGroup.add(innocentGroup);
			collideGroup.add(player);
			
			//Set up the camera
			FlxG.follow(player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(Map.boundsMinX, Map.boundsMinY, Map.boundsMaxX, Map.boundsMaxY);
			FlxG.mouse.hide();
			hudManager = new HUDMaker();
		}
		
		override public function update():void
		{
			collideGroup.collide();
			FlxU.collide(level.hitTilemaps, collideGroup);
			FlxU.overlap(player, bulletGroup, playerGotShot);
			FlxU.overlap(player, coin, gotTheCoin);
			overlapBullets();
			if (FlxG.keys.justPressed("SPACE") ){
				FlxU.overlap(player.overlap, enemyGroup, attackEnemy);
				FlxU.overlap(player.overlap, innocentGroup, attackInnocent);
			}
			enemyShoot();
			updatePower();
			super.update();
		}
		
		protected function onAddSprite(obj:Object, layer:FlxGroup, level:Map, properties:Array):Object
		{
			if (obj is Enemy)
			{
				enemyGroup.add(obj as Enemy);
			}
			else if (obj is Innocent)
			{
				innocentGroup.add(obj as Innocent);
			}
			else if (obj is Player) {
				player = obj as Player;
			}
			else if (obj is Coin) {
				coin = obj as Coin;
			}
			else if ( obj is TextData )
			{
				var tData:TextData = obj as TextData;
				if ( tData.fontName != "" && tData.fontName != "system" )
				{
					tData.fontName += "Font";
				}
				return level.addTextToLayer(tData, layer, true, properties, onAddSprite );
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
			//currentPower = new LimitedVision();
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