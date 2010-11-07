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
		
		public function Player():void
		{
			super(50, 50, ImgPlayer);
		}
		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			if (FlxG.keys.W) {
				velocity.x = speed * Math.cos(degToRad(angle));
				velocity.y = speed * Math.sin(degToRad(angle));
			}
			else if (FlxG.keys.S)
			{
				velocity.x = -1 * speed * Math.cos(degToRad(angle));
				velocity.y = -1 * speed * Math.sin(degToRad(angle));
			}
			if (FlxG.keys.A)
			{
				var lAngle:Number = degToRad(angle+90);
				velocity.x = -1 * strafeSpeed * Math.cos(lAngle);
				velocity.y = -1 * strafeSpeed * Math.sin(lAngle);
			}
			else if (FlxG.keys.D)
			{
				var rAngle:Number = degToRad(angle+90);
				velocity.x = strafeSpeed * Math.cos(rAngle);
				velocity.y = strafeSpeed * Math.sin(rAngle);
			}
			if (FlxG.keys.Q) {
				angle -= 6;
			}
			else if (FlxG.keys.E) {
				angle += 6;
			}
			
			super.update();
		}
		
		private function getAngle():void
		{
			this.angle = FlxU.getAngle(FlxG.mouse.x - (x + width / 2), FlxG.mouse.y - (y + height / 2));
		}
		
		private function degToRad(degree:Number):Number
		{
			return degree * Math.PI / 180;
		}
	}

}