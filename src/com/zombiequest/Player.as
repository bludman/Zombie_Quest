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
		private static var ImgPlayer:Class;
		public const origSpeed:Number = 120;
		private var speed:Number = origSpeed;
		private var attackDistance:Number = 10;
		private var attackRange:FlxSprite = new FlxSprite(0, 0);
		public var damage:Number = 50;
		
		[Embed(source="../../../assets/sound/zombie_attack1.mp3")]
		private static var attackSound1:Class;
		[Embed(source="../../../assets/sound/zombie_attack2.mp3")]
		private static var attackSound2:Class;
		[Embed(source="../../../assets/sound/zombie_attack3.mp3")]
		private static var attackSound3:Class;
		[Embed(source="../../../assets/sound/zombie_attack4.mp3")]
		private static var attackSound4:Class;
		[Embed(source="../../../assets/sound/zombie_attack5.mp3")]
		private static var attackSound5:Class;
		
		[Embed(source="../../../assets/sound/zombie_hurt1.mp3")]
		private static var hurtSound1:Class;
		[Embed(source="../../../assets/sound/zombie_hurt2.mp3")]
		private static var hurtSound2:Class;
		[Embed(source="../../../assets/sound/zombie_hurt3.mp3")]
		private static var hurtSound3:Class;
		[Embed(source="../../../assets/sound/zombie_hurt4.mp3")]
		private static var hurtSound4:Class;
		
		[Embed(source="../../../assets/sound/zombie_die1.mp3")]
		private static var dieSound1:Class;
		[Embed(source="../../../assets/sound/zombie_die2.mp3")]
		private static var dieSound2:Class;
		[Embed(source="../../../assets/sound/zombie_die3.mp3")]
		private static var dieSound3:Class;
		[Embed(source="../../../assets/sound/zombie_die4.mp3")]
		private static var dieSound4:Class;
		
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
		
		public override function kill():void
		{
			var dieSound:Class;
			var roll:Number = Math.random() * 4;
			if(roll > 3)
				dieSound = dieSound1;
			else if(roll > 2)
				dieSound = dieSound2;
			else if(roll > 1)
				dieSound = dieSound3;
			else
				dieSound = dieSound4;
			FlxG.play(dieSound,1,false);
			
			super.kill();
		}
		
		public function playAttackSound():void
		{
			var attackSound:Class;
			var roll:Number = Math.random() * 5;
			if(roll > 4)
				attackSound = attackSound1;
			else if(roll > 3)
				attackSound = attackSound2;
			else if(roll > 2)
				attackSound = attackSound3;
			else if(roll > 1)
				attackSound = attackSound4;
			else
				attackSound = attackSound5;
			FlxG.play(attackSound,1,false);
		}	
		
		public function playHurtSound():void
		{
			var hurtSound:Class;
			var roll:Number = Math.random() * 4;
			if(roll > 3)
				hurtSound = hurtSound1;
			else if(roll > 2)
				hurtSound = hurtSound2;
			else if(roll > 1)
				hurtSound = hurtSound3;
			else
				hurtSound = hurtSound4;
			FlxG.play(hurtSound,1,false);
		}
		
	}

}