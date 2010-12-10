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
		
		[Embed(source="../../../assets/png/zombie.png")]
		private var ImgPlayer:Class;
		public const origSpeed:Number = 120;
		private var speed:Number = origSpeed;
		private var attackDistance:Number = 10;
		private var attackRange:FlxSprite = new FlxSprite(0, 0);
		public var damage:Number = 50;
		public function Player(x:Number, y:Number):void
		{
			super(x, y, ImgPlayer);
			health = 100;
			loadGraphic(ImgPlayer, true, true, 42, 42);
			addAnimation("walk", [0, 1, 0, 2], 5);
			addAnimation("idle", [0]);
			attackRange.height = this.height;
			attackRange.width = this.width;
			calcFrame();
		}		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			//walking up-left, up-right, etc.
			if (FlxG.keys.UP)
			{
				if(FlxG.keys.LEFT){
					angle = -135;
					velocity.x = speed * Math.cos(MathU.degToRad(angle));
					velocity.y = speed * Math.sin(MathU.degToRad(angle));
				}
				else if(FlxG.keys.RIGHT){
					angle = -45;
					velocity.x = speed * Math.cos(MathU.degToRad(angle));
					velocity.y = speed * Math.sin(MathU.degToRad(angle));
				}
				else
				{
					velocity.y = -speed;
					angle = -90
				}
			}
			else if (FlxG.keys.DOWN)
			{
				if(FlxG.keys.LEFT){
					angle = 135;
					velocity.x = speed * Math.cos(MathU.degToRad(angle));
					velocity.y = speed * Math.sin(MathU.degToRad(angle));
				}
				else if (FlxG.keys.RIGHT)
				{
					angle = 45;
					velocity.x = speed * Math.cos(MathU.degToRad(angle));
					velocity.y = speed * Math.sin(MathU.degToRad(angle));
				}
				else
				{
					velocity.y = speed;
					angle = 90;
				}
			}
			else if (FlxG.keys.LEFT) {
				angle = -180;
				velocity.x = -speed;
			}
			else if (FlxG.keys.RIGHT) {
				angle = 0;
				velocity.x = speed;
			}
			
			if(velocity.x == 0 && velocity.y == 0) {
				play("idle");
			}
			else {
				play("walk");
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
			attackRange.x = x + 10 * Math.cos(MathU.degToRad(angle));
			attackRange.y = y + 10 * Math.sin(MathU.degToRad(angle));
		}
		
		public function set setSpeed(s:Number):void {
			this.speed = s;
		}
		public function get getSpeed():Number {
			return this.speed;
		}
		public function center():FlxPoint
		{
				return new FlxPoint(x + width / 2, y + height / 2);
		}
		
	}

}