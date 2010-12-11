package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Enemy extends FlxSprite 
	{
		protected const speed:Number = 75;
		
		protected const RETREAT_RANGE:Number = 100;
		protected const HOLD_RANGE:Number = 50;
		protected const ATTACK_RANGE:Number = 2*RETREAT_RANGE;
		protected const FOLLOW_RANGE:Number = 50*ATTACK_RANGE;
		public static const healthRegen:Number = 20;
		
		protected var healthbar:FlxSprite;
		public var player:Player;
		protected var minionGroup:FlxGroup;
		public var lastShot:Number;
		public var shotTimeout:Number = 1.5;
		protected var moving:Boolean = false;
		public var shooting:Boolean = false;
		protected var currentAnim:String = "";
		public var hasPowerup:Boolean = false;
		public var collideArea:FlxSprite = new FlxSprite(0, 0);
		protected var collideOffset:FlxPoint = new FlxSprite(10, 10);
		protected const newSize:Number = 42 / 96;
		[Embed(source = "../../../assets/png/cop.png")]
		protected static var ImgEnemy:Class;
		
		[Embed(source = "../../../assets/sound/cop_hit1.mp3")]
		protected static var hitSound1:Class;
		[Embed(source = "../../../assets/sound/cop_hit2.mp3")]
		protected static var hitSound2:Class;
		
		[Embed(source = "../../../assets/sound/cop_die1.mp3")]
		protected static var dieSound1:Class;
		[Embed(source = "../../../assets/sound/cop_die2.mp3")]
		protected static var dieSound2:Class;
			
		
		public function Enemy(X:Number, Y:Number, player:Player, minions:FlxGroup, hasPowerup:Boolean = false) 
		{
			super(X, Y);
			this.player = player;
			minionGroup = minions;
			health = 100;
			lastShot = (Math.random() * 2);
			this.hasPowerup = hasPowerup;
			//createHealthbar();
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
		
		public function pickTarget():FlxObject
		{
			//Find closest minion or player
			var distance:Number = 100000;
			var returnMe:FlxObject;
			for each (var o:FlxObject in minionGroup.members)
			{
				var dist:Number = MathU.dist(o.x - x, o.y - y)
				if (dist < distance)
				{
					distance = dist;
					returnMe = o;
				}
			}
			
			if(MathU.dist(player.x - x, player.y - y) < distance)
				return player;
			
			return returnMe;
		}
		
		/**
		 * Hold position
		 */
		protected function holdPosition(attack:Boolean = false):void
		{
			collideArea.velocity.x = 0;
			collideArea.velocity.y = 0;
			moving = false;
			shooting = attack;
		}
		
		/**
		 * Retreat from a target
		 */
		protected function retreat(target:FlxObject):void
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
		protected function chase(target:FlxObject,attack:Boolean = false):void
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
			var target:FlxObject = this.pickTarget();
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
		
		protected function createHealthbar():void
		{
			healthbar = new FlxSprite(this.x, this.y);
			healthbar.createGraphic(2, 1, 0xffff0000);
			healthbar.origin.x = healthbar.origin.y = 0;
			healthbar.scale.x = this.health / 4;
			StartLevelState.overGroup.add(healthbar);
		}
		
		public function updateHealthbar():void
		{
			if (this.health <= 0)
			{
				this.health = 0;
				this.kill();
			}
			//healthbar.scale.x = this.health / 6;
			//healthbar.x = this.x - 2;
			//healthbar.y = this.y;
		}
		
		public override function kill():void
		{
			super.kill();
			//healthbar.kill();
			collideArea.kill();
			
			if(Math.random() > 0.5)
				FlxG.play(dieSound1,.6,false);
			else
				FlxG.play(dieSound2,.6,false);				
		}
		
		protected function updateCollide():void
		{
			x = collideArea.x - collideOffset.x;
			y = collideArea.y - collideOffset.y;
		}
		
		protected function boundEnemy():void
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
		
		public function playHitSound(probability:Number = 1):void
		{
			if(Math.random() < probability) 
			{
				var hitSound:Class;
				var roll:Number = Math.random();
				if(roll > .5)
					hitSound = hitSound1;
				else
					hitSound = hitSound2;
				FlxG.play(hitSound,.55,false);
			}
		}
	}

}
