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
		private const FOLLOW_RANGE:Number = 50*ATTACK_RANGE;
		public static const healthRegen:Number = 10;
		
		private var healthbar:FlxSprite;
		public var player:Player;
		public var lastShot:Number;
		public var shotTimeout:Number = 1.5;
		private var moving:Boolean = false;
		public var shooting:Boolean = false;
		private var currentAnim:String = "";
		public var hasPowerup:Boolean = false;
		public var collideArea:FlxSprite = new FlxSprite(0, 0);
		private var collideOffset:FlxPoint = new FlxSprite(10, 10);
		private const newSize:Number = 42 / 96;
		[Embed(source = "../../../assets/png/cop.png")]
		private var ImgEnemy:Class;
		public function Enemy(X:Number, Y:Number, player:Player, hasPowerup:Boolean = false) 
		{
			super(X, Y);
			this.player = player;
			health = 100;
			
			lastShot = (Math.random() * 2);
			this.hasPowerup = hasPowerup;
			createHealthbar();
			loadGraphic(ImgEnemy, true, true, 42, 42);
			addAnimation("walk", [0, 1, 2, 1, 0, 3, 4], 10);
			addAnimation("shoot", [5], 1);
			play("walk");
			collideArea.width = 20;
			collideArea.height = 20;
			collideArea.x = x + collideOffset.x;
			collideArea.y = y + collideOffset.y;
			collideArea.visible = false;
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
			collideArea.velocity.x = 0;
			collideArea.velocity.y = 0;
			moving = false;
			shooting = attack;
		}
		
		/**
		 * Retreat from a target
		 */
		private function retreat(target:FlxSprite):void
		{
			this.angle = -1 * FlxU.getAngle(target.x - this.x, target.y - this.y);
			collideArea.angle = angle;
			collideArea.velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
			collideArea.velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
			shooting = false;
			moving = true;
		}
		
		/**
		 * Chase a target
		 */
		private function chase(target:FlxSprite,attack:Boolean = false):void
		{
			this.angle = FlxU.getAngle(target.x - this.x, target.y - this.y);
			collideArea.angle = angle;
			collideArea.velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
			collideArea.velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
			shooting = attack;
			moving = true;
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
			if (shooting)
			{
				play("shoot");
				angle = FlxU.getAngle(target.x - x, target.y - y);
			}
			else {
				if (currentAnim != "walk")
				{
					play("walk");
				}
				if (!moving) {
					_curFrame = 1;
				}
			}
			super.update();
			//collideArea.update();
			//boundEnemy();
			updateCollide();
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
			collideArea.kill();
		}
		
		private function updateCollide():void
		{
			x = collideArea.x - collideOffset.x;
			y = collideArea.y - collideOffset.y;
		}
		
		private function boundEnemy():void
		{
			if (x < 0) {
				x = 0;
			}
			else if (x > Map.boundsMaxX)
			{
				x = Map.boundsMaxX;
			}
			if (y < 0)
			{
				y = 0;
			}
			else if (y > Map.boundsMaxY)
			{
				y = Map.boundsMaxY;
			}
		}
		
		override public function play(name:String, force:Boolean = false):void
		{
			super.play(name, force);
			currentAnim = name;
		}
	}

}