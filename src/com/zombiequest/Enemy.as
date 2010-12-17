package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Enemy extends WalkingSprite 
	{
		protected const speed:Number = 75;
		protected static var retreatRange:Number = 100;
		protected static var holdRange:Number = 200;//2*retreatRange+200;
		protected static var attackRange:Number = 250;//2*attackRange;
		protected static var followRange:Number = 30000;//2*followRange+200;
		
		public static const healthRegen:Number = 40;		
		
		/** Distance rings between target and enemy */
		protected static const DISTANCE_RETREAT:Number = 0;
		protected static const DISTANCE_HOLD:Number = 1;
		protected static const DISTANCE_ATTACK:Number = 2;
		protected static const DISTANCE_FOLLOW:Number = 3;
		protected static const DISTANCE_IGNORE:Number = 4;
		
		
		/* Enemy states */
		protected var following:Boolean = false;
		public var shooting:Boolean = false;
		protected var retreating:Boolean = false;
		public var glowing:Boolean = false;
		
		
		protected var healthbar:FlxSprite;
		public var player:Player;
		protected var minionGroup:FlxGroup;
		public var lastShot:Number;
		public var shotTimeout:Number = 1.5;
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
			loadGraphics(ImgEnemy)
			collideArea.width = 20;
			collideArea.height = 20;
			collideArea.x = x + collideOffset.x;
			collideArea.y = y + collideOffset.y;
			collideArea.visible = false;
			calcFrame();
		}
		
		protected function loadGraphics(img:Class):void
		{			
			loadGraphic(img, true, true, 42, 42);
			addAnimation("walk", [0, 1, 2, 1, 0, 3, 4], 10);
			addAnimation("shoot", [5], 1);
			addAnimation("walk-glow", [6, 7, 8, 7, 6, 9, 10], 10);
			addAnimation("shoot-glow", [11], 1);
			play("walk");
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
			following = false;
			shooting = attack;
		}
		
		/**
		 * Retreat from a target
		 */
		protected function retreat(target:FlxObject):void
		{
//			var secretAngle:Number = 180 + FlxU.getAngle(target.x - this.x, target.y - this.y);
//			this.angle = secretAngle;
//			collideArea.angle = this.angle;
			goToLocation(target.x, target.y, speed);
			collideArea.velocity.x = velocity.x;
			collideArea.velocity.y = velocity.y
			collideArea.angle = angle;
			shooting = false;
			following = true;
			retreating = true;
		}
		
		/**
		 * Chase a target
		 */
		protected function chase(target:FlxObject,attack:Boolean = false):void
		{	
			goToLocation(target.x, target.y, speed);
			collideArea.velocity.x = velocity.x;
			collideArea.velocity.y = velocity.y;
			collideArea.angle = angle;
			shooting = attack;
			following = true;
		}
		
		
		protected function getDistanceRing(distance:Number):Number
		{
			trace("distance ",distance);
			if(distance<=retreatRange)		//Retreat Ring
				return DISTANCE_RETREAT;
			if(distance<=holdRange)	//Holding Ring
				return DISTANCE_HOLD;
			if(distance<=attackRange)	//Attack Ring
				return DISTANCE_ATTACK;
			if (distance<=followRange)	//Follow Ring
				return DISTANCE_FOLLOW;
			else 							//No view of target
				return DISTANCE_IGNORE;
		}
		
		protected function setState(following:Boolean, attacking:Boolean, retreating:Boolean):void
		{
			this.following = following;
			this.shooting = attacking;
			this.retreating = retreating;
		}
		
		public override function update():void
		{
			var target:FlxObject = this.pickTarget();
			var distance:Number = MathU.dist(target.x - x, target.y - y);
//			var ring:Number;// = getDistanceRing(distance);
//			
//			if(distance<=retreatRange){		//Retreat Ring
//				ring= DISTANCE_RETREAT;
//			}else if(distance<=holdRange){	//Holding Ring
//				ring= DISTANCE_HOLD;
//			}else if(distance<=attackRange){	//Attack Ring
//				ring= DISTANCE_ATTACK;
//			}else if (distance<=followRange){	//Follow Ring
//				ring= DISTANCE_FOLLOW;
//			}else {							//No view of target
//				ring= DISTANCE_IGNORE;
//			}
//			trace("distance", distance, "ring: ",ring, "f",following,"a",shooting,"r",retreating);
//			
//			if(retreating)
//			{
//				switch(ring)
//				{
//					case DISTANCE_RETREAT:
//						setState(false,false,false);
//						break;
//					case DISTANCE_HOLD:
//						setState(false,true,false);
//						break;
//					case DISTANCE_ATTACK:
//						setState(true,true,false);
//						break;
//					case DISTANCE_FOLLOW:
//						setState(true,false,false);
//						break;
//					case DISTANCE_IGNORE:
//						setState(false,false,false);
//						break;
//				}
//			}
//			else
//			{
//				switch(ring)
//				{
//					case DISTANCE_RETREAT:
//						setState(false,false,true);
//						break;
//					case DISTANCE_HOLD:
//						setState(false,false,true);
//						break;
//					case DISTANCE_ATTACK:
//						setState(false,false,true);
//						break;
//					case DISTANCE_FOLLOW:
//						setState(true,false,false);
//						break;
//					case DISTANCE_IGNORE:
//						setState(false,false,false);
//						break;
//				}
//			}
//			
//			
//			//Set the angle
//			if(following || shooting)
//			{
//				this.angle = FlxU.getAngle(target.x - this.x, target.y - this.y);
//			}else if(retreating)
//			{
//				this.angle = -1* FlxU.getAngle(target.x - this.x, target.y - this.y);
//			}
//			collideArea.angle = angle;
//			
//			//Set the speed
//			if(following || retreating)
//			{
//				
//				collideArea.velocity.x = speed * Math.cos(MathU.degToRad(this.angle));
//				collideArea.velocity.y = speed * Math.sin(MathU.degToRad(this.angle));
//			}
//			else
//			{
//				collideArea.velocity.x = 0;
//				collideArea.velocity.y = 0;
//			}
//			
//			//Set animation
//			
//			if(shooting)
//			{
//				play("shoot");
//			}
//			else {
////				if (currentAnim != "walk")
////				{
////					play("walk");
////				}
////				
////				if (!(following || retreating)) 
////				{
////					_curFrame = 1;
////				}
////				
//			}
//			
			
			
			//OLD IMPL
			
			if(distance<=followRange)
			{
				if(distance <= attackRange)
				{
					if(distance <= holdRange)
					{
						if(distance<= retreatRange) //within retreat
						{
							retreat(target);
						}
						else //within hold
						{
							if(!retreating)
								holdPosition(true);
							else retreat(target);
						}
					}
					else //within attack
					{
						if(!retreating)
							chase(target,true);	
						else retreat(target);
					}
				}
				else{ //within follow
					retreating = false;
					chase(target,false);
				}
			}
			else //in ignore ring
			{
				holdPosition(false);
				retreating = false;
			}
			
			
			
			if (shooting)
			{
				play("shoot");
				angle = FlxU.getAngle(target.x - x, target.y - y);
			}
			else {
				play("walk");
				if (!following) {
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
			ret.x = x + collideArea.width / 2 + collideArea.width * Math.cos(MathU.degToRad(angle)) / 4;
			ret.y = y + collideArea.height / 2 + collideArea.height * Math.sin(MathU.degToRad(angle)) / 4;
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
				FlxG.play(dieSound1,.5,false);
			else
				FlxG.play(dieSound2,.5,false);				
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
				FlxG.play(hitSound,.4,false);
			}
		}
		
		override public function play(AnimName:String, Force:Boolean = false):void 
		{
			currentAnim = AnimName;
			if (glowing) 
			{
				AnimName = AnimName + "-glow";
			}
			super.play(AnimName, Force);
		}
	}

}
