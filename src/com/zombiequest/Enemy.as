package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Enemy extends FlxSprite 
	{
		private const speed:Number = 55;
		private const turnSpeed:Number = 3;
		private const shootRange:Number = 500;
		private const followRange:Number = 300;
		private var healthbar:FlxSprite;
		public var player:Player;
		public var lastShot:Number;
		public var shotTimeout:Number = 1.5;
		public var following:Boolean = false;
		public var shooting:Boolean = false;
		public var hasPowerup:Boolean = false;
		[Embed(source = "../../../assets/png/temp_person.png")]
		private var ImgEnemy:Class;
		public function Enemy(X:Number, Y:Number, player:Player = null, hasPowerup:Boolean = false) 
		{
			super(X, Y);
			this.player = player;
			health = 100;
			scale = new FlxPoint(20 / width, 20 / height);
			width = 20;
			height = 20;
			lastShot = (Math.random() * 2);
			this.hasPowerup = hasPowerup;
			createHealthbar();
			loadGraphic(ImgEnemy, true, true, 32, 32);
			scale.x = scale.x / 2;
			scale.y = scale.y / 2;
			if (this.hasPowerup == true) {
				addAnimation("walk", [0, 1, 2], 10);
			} else {
				addAnimation("walk", [3, 4, 5], 10);
			}
			
			play("walk");
			calcFrame();
		}
		public override function update():void
		{
			var distance:Number = Math.sqrt(Math.pow(this.x - player.x, 2) + Math.pow(this.y - player.y, 2));
			if (distance > followRange) {
				velocity.x = 0;
				velocity.y = 0;
				following = false;
				shooting = false;
			} else {
				this.angle = FlxU.getAngle(player.x - this.x, player.y - this.y);
				if (distance < followRange) { 
					velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
					velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
					shooting = true;
					following = true;
				}
				else {
					shooting = true;
					velocity.x = 0;
					velocity.y = 0;
				}
			}
			if (!following) {
				_curFrame = 1;
			}
			super.update();
			updateHealthbar();
		}
		
		public function bulletSpawn():FlxPoint
		{
			var ret:FlxPoint = new FlxPoint();
			ret.x = x + width / 2 + width * Math.cos(MathU.degToRad(angle)) / 2;
			ret.y = y + height / 2 + height * Math.sin(MathU.degToRad(angle)) / 2;
			return ret;
		}
		
		private function createHealthbar():void
		{
			healthbar = new FlxSprite(this.x, this.y);
			healthbar.createGraphic(2, 1, 0xffff0000);
			healthbar.origin.x = healthbar.origin.y = 0;
			healthbar.scale.x = this.health / 4;
			FlxG.state.add(healthbar);
		}
		
		public function updateHealthbar():void
		{
			if (this.health <= 0)
			{
				this.health = 0;
				this.kill();
			}
			healthbar.scale.x = this.health / 6;
			healthbar.x = this.x - 2;
			healthbar.y = this.y;
		}
	}

}