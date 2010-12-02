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
		[Embed(source="../../../assets/png/ZombieTILES_WALK.png")]
		private var ImgPlayer:Class;
		public const origSpeed:Number = 120;
		private var speed:Number = origSpeed;
		private var strafeSpeed:Number = speed / 2 ;
		private var attackDistance:Number = 10;
		private var attackRange:FlxSprite = new FlxSprite(0, 0);
		public var damage:Number = 50;
		public function Player(x:Number, y:Number):void
		{
			super(x, y, ImgPlayer);
			health = 100;
			loadGraphic(ImgPlayer, true, true, 64, 64);
			scale.x = scale.x * (2/3);
			scale.y = scale.y * (2 / 3);
			width = width  * (2 / 3);
			height = height  * (2/3);
			addAnimation("walk", [1, 2, 3, 4, 0], 5);
			addAnimation("idle", [0]);
			attackRange.height = this.height;
			attackRange.width = this.width;
			//play("walk");
			calcFrame();
		}		
		override public function update():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if (FlxG.keys.W || FlxG.keys.UP) {
				velocity.x = speed * Math.cos(MathU.degToRad(angle));
				velocity.y = speed * Math.sin(MathU.degToRad(angle));
			}
			else if (FlxG.keys.S || FlxG.keys.DOWN)
			{
				velocity.x = -1 * speed * Math.cos(MathU.degToRad(angle));
				velocity.y = -1 * speed * Math.sin(MathU.degToRad(angle));
			}
			if (FlxG.keys.Q)
			{
				var lAngle:Number = MathU.degToRad(angle+90);
				velocity.x = -1 * strafeSpeed * Math.cos(lAngle);
				velocity.y = -1 * strafeSpeed * Math.sin(lAngle);
			}
			else if (FlxG.keys.E)
			{
				var rAngle:Number = MathU.degToRad(angle+90);
				velocity.x = strafeSpeed * Math.cos(rAngle);
				velocity.y = strafeSpeed * Math.sin(rAngle);
			}
			if (FlxG.keys.A || FlxG.keys.LEFT) {
				angle -= 6;
			}
			else if (FlxG.keys.D || FlxG.keys.RIGHT) {
				angle += 6;
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
			this.strafeSpeed = this.speed / 2;
		}
		public function get getSpeed():Number {
			return this.speed;
		}
	}

}