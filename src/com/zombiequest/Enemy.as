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
		private const shootRange:Number = 500; //Ben: What is this for?
		
		private const RETREAT_RANGE:Number = 100;
		private const HOLD_RANGE:Number = 50;
		private const ATTACK_RANGE:Number = 2*RETREAT_RANGE;
		private const FOLLOW_RANGE:Number = 3*ATTACK_RANGE;
		
		
		private var healthbar:FlxSprite;
		public var player:Player;
		public var lastShot:Number;
		public var shotTimeout:Number = 1.5;
		public var following:Boolean = false;
		public var shooting:Boolean = false;
		public var hasPowerup:Boolean = false;
		[Embed(source = "../../../assets/png/temp_person.png")]
		private var ImgEnemy:Class;
		public function Enemy(X:Number, Y:Number, player:Player, hasPowerup:Boolean = false) 
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
		
		public function pickTarget():FlxSprite
		{
			//TODO: This should be overridden in the subclass to find 
			//closest not following minion or player 
			return player;
		}
		
		/**
		 * Hold position
		 */
		private function holdPosition(attack:Boolean = false):void
		{
			velocity.x = 0;
			velocity.y = 0;
			following = false;
			shooting = attack;
		}
		
		/**
		 * Retreat from a target
		 */
		private function retreat(target:FlxSprite):void
		{
			this.angle= -1* FlxU.getAngle(target.x - this.x, target.y - this.y);
			velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
			velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
			shooting = false;
			following = false;
		}
		
		/**
		 * Chase a target
		 */
		private function chase(target:FlxSprite,attack:Boolean = false):void
		{
			this.angle= FlxU.getAngle(target.x - this.x, target.y - this.y);
			velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
			velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
			shooting = attack;
			following = true;
		}
		
		
		public override function update():void
		{
			var target:FlxSprite = this.pickTarget();
			var distance:Number = MathU.dist(target.x - x, target.y - y);
			
			if(distance<=FOLLOW_RANGE)
			{
				if(distance <= ATTACK_RANGE)
				{
					if(distance <= ATTACK_RANGE - HOLD_RANGE)
					{
						if(distance<= RETREAT_RANGE)
						{
							retreat(target);
						}
						else
						{
							holdPosition(true);
						}
					}
					else
					{
						chase(target,true);	
					}
				}
				else{
					chase(target,false);
				}
			}
			else
			{
				holdPosition(false);
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
		
		public override function kill():void
		{
			super.kill();
			healthbar.kill();
		}
	}

}