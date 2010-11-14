package com.zombiequest 
{
	import flash.text.Font;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Player extends FlxSprite
	{
		[Embed(source="../../../assets/jpeg/PlayerTopDown.jpg")]
		private var ImgPlayer:Class;
		private var speed:Number = 100;
		private var strafeSpeed:Number = speed / 2 ;
		private var attackDistance:Number = 10;
		private var attackRange:FlxSprite = new FlxSprite(0, 0);
		public var damage:Number = 50;
		public function Player():void
		{
			super(50, 50, ImgPlayer);
			attackRange.height = this.height;
			attackRange.width = this.width;
		}		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			if (FlxG.keys.W) {
				velocity.x = speed * Math.cos(Main.degToRad(angle));
				velocity.y = speed * Math.sin(Main.degToRad(angle));
			}
			else if (FlxG.keys.S)
			{
				velocity.x = -1 * speed * Math.cos(Main.degToRad(angle));
				velocity.y = -1 * speed * Math.sin(Main.degToRad(angle));
			}
			if (FlxG.keys.Q)
			{
				var lAngle:Number = Main.degToRad(angle+90);
				velocity.x = -1 * strafeSpeed * Math.cos(lAngle);
				velocity.y = -1 * strafeSpeed * Math.sin(lAngle);
			}
			else if (FlxG.keys.E)
			{
				var rAngle:Number = Main.degToRad(angle+90);
				velocity.x = strafeSpeed * Math.cos(rAngle);
				velocity.y = strafeSpeed * Math.sin(rAngle);
			}
			if (FlxG.keys.A) {
				angle -= 6;
			}
			else if (FlxG.keys.D) {
				angle += 6;
			}
			super.update();
			updateOverlap();
		}
		public function get overlap():FlxSprite
		{
			return attackRange;
		}
		
		private function updateOverlap():void
		{
			attackRange.angle = this.angle;
			attackRange.x = x + 10 * Math.cos(Main.degToRad(angle));
			attackRange.y = y + 10 * Math.sin(Main.degToRad(angle));
		}
	}

}