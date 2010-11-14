package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Enemy extends FlxSprite 
	{
		private const speed:Number = 75;
		private const turnSpeed:Number = 4;
		private const range:Number = 50;
		private var player:Player;
		public var lastShot:Number;
		private var bulletGroup:FlxGroup;
		[Embed(source = "../../../assets/png/Enemy.png")] 
		private var ImgEnemy:Class;
		public function Enemy(X:Number, Y:Number, player:Player, bulletGroup:FlxGroup) 
		{
			super(X, Y, ImgEnemy);
			this.player = player;
			this.health = 100;
			scale = new FlxPoint(20 / width, 20 / height);
			width = 20;
			height = 20;
			lastShot = FlxG.elapsed;
			this.bulletGroup = bulletGroup;
		}
		public override function update():void
		{
			var distance:Number = Math.sqrt(Math.pow(this.x - player.x, 2) + Math.pow(this.y - player.y, 2));
			if (distance > range) {
				velocity.x = 0;
				velocity.y = 0;
				super.update();
				return;
			}
			var turnAngle:Number = FlxU.getAngle(player.x - this.x, player.y - this.y);
			this.angle = turnAngle;
			velocity.x = speed * Math.cos(Main.degToRad(this.angle));
			velocity.y = speed * Math.sin(Main.degToRad(this.angle));
			super.update();
		}
	}

}