package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Enemy extends FlxSprite 
	{
		private const speed:Number = 50;
		private const turnSpeed:Number = 4;
		private const shootRange:Number = 100;
		private const followRange:Number = 150;
		public var player:Player;
		public var lastShot:Number;
		public var shotTimeout:Number = 2;
		public var following:Boolean = false;
		public var shooting:Boolean = false;
		public var hasPowerup:Boolean = true;
		[Embed(source = "../../../assets/png/Enemy.png")] 
		private var ImgEnemy:Class;
		public function Enemy(X:Number, Y:Number, player:Player = null, hasPowerup:Boolean = false) 
		{
			super(X, Y, ImgEnemy);
			this.player = player;
			this.health = 100;
			scale = new FlxPoint(20 / width, 20 / height);
			width = 20;
			height = 20;
			lastShot = 0;
			this.hasPowerup = hasPowerup;
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
				if (distance < followRange && distance > shootRange) { 
					trace("Enemy speed [", speed, "]");
					velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
					velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
					shooting = false;
					following = true;
				}
				else {
					shooting = true;
					velocity.x = 0;
					velocity.y = 0;
				}
			}
			super.update();
		}
		
		public function bulletSpawn():FlxPoint
		{
			var ret:FlxPoint = new FlxPoint();
			ret.x = x + width / 2 + width * Math.cos(MathU.degToRad(angle)) / 2;
			ret.y = y + height / 2 + height * Math.sin(MathU.degToRad(angle)) / 2;
			return ret;
		}
		
	}

}