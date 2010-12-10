package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.*;
	public class Minion extends FlxSprite
	{
		private var speed:Number = 50;	//made the minions kinda slow because they are not a super zombie like you
		private var attackRange:Number = 40;
		private var sentryFollowRange:Number = 200;
		private var attackFollowRange:Number = 800; //Diagonal distance of map
		private var playerFollowMin:Number = 200;
		private var damage:Number = 25;
		private const attackTimeout:Number = 1;
		private var attackTimer:Number = 0;
		private var player:Player;
		private var chasing:Boolean = false;
		private var chaseTarget:FlxSprite;
		private static var id:Number = 0;
		public var pid:Number;
		public const MAX_HEALTH:Number = 100;
		
		[Embed(source="../../../assets/png/minion.png")]
		private static var ImgMinion:Class;
		
		[Embed(source="../../../assets/sound/zombie_moan1.mp3")]
		private static var moanSound1:Class;		
		[Embed(source="../../../assets/sound/zombie_moan2.mp3")]
		private static var moanSound2:Class;		
		[Embed(source="../../../assets/sound/zombie_moan3.mp3")]
		private static var moanSound3:Class;
		
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
		
		/*
		 * State Enums
		 */
		public static const ATTACKING:Number = 1;
		public static const SENTRY:Number = 2;
		public static const DEFENDING:Number = 3;
		
		public var state:Number;
		/**
		 * Should only be called by the MinionFactory
		 */
		public function Minion(x:Number, y:Number, player:Player) 
		{
			super(x, y);
			loadGraphic(ImgMinion, true, true, 32, 32);
			this.player = player;
			id++;
			pid = id;
			state = DEFENDING;
			health = MAX_HEALTH;
			addAnimation("walk", [0, 1, 0, 2], 5);
			addAnimation("idle", [0]);
			
			var wakeSound:Class;
			var roll:Number = Math.random();
			if(roll>0.66)
				wakeSound = moanSound1;
			else if(roll > 0.33)
				wakeSound = moanSound2;
			else
				wakeSound = moanSound3;
			FlxG.play(wakeSound,1,false);
		}
		
		public override function update():void
		{
			var dist:Number;
			velocity.x = 0;
			velocity.y = 0;
			attackTimer += FlxG.elapsed;
			var pCenter:FlxPoint = player.center();
			if (state == DEFENDING) 
			{
				//Just follow the player
				if (MathU.dist(player.x - x, player.y - y) > playerFollowMin){
					angle = FlxU.getAngle(pCenter.x - x, pCenter.y - y);
					velocity.x = speed * Math.cos(MathU.degToRad(angle));
					velocity.y = speed * Math.sin(MathU.degToRad(angle));
					play("walk");
				}
				else
				{
					play("idle");
					findTarget(playerFollowMin);
				}
			}
			else if (state == SENTRY)
			{
				//Find something to attack
				findTarget(sentryFollowRange);
				play("idle");
			} 
			else if (state == ATTACKING)
			{
				angle = FlxU.getAngle(chaseTarget.x - x, chaseTarget.y - y);
				velocity.x = speed * Math.cos(MathU.degToRad(angle));
				velocity.y = speed * Math.sin(MathU.degToRad(angle));
				play("walk");
				if(MathU.dist(chaseTarget.x - x, chaseTarget.y - y) < attackRange){
					attack();
				}
				if (chaseTarget.dead)
				{
					findTarget();
				}
				
			}
			super.update();
		}
		private function attack():void
		{
			if (attackTimer >= attackTimeout)
			{
				chaseTarget.health -= damage;
				attackTimer = 0;
				if (chaseTarget.health <= 0)
				{
					chaseTarget.kill();
					if (chaseTarget is Innocent)
					{
						distributeHealth(Innocent.healthRegen);
					}
					else if (chaseTarget is Enemy)
					{
						distributeHealth(Enemy.healthRegen);
					}
				}
				
				StartLevelState.bloodSplat(chaseTarget.x, chaseTarget.y);
				playAttackSound();
			}
		}
		
		private function distributeHealth(health:Number):void
		{
			var minions:Array = StartLevelState.minionGroup.members;
			var dist:Number = health / (minions.length + 1);
			for (var i:Number = 0; i < minions.length; i++)
			{
				Minion(minions[i]).health += dist;
				if (health > MAX_HEALTH)
				{
					health = MAX_HEALTH;
				}
			}
			player.health += dist;
		}
		/**
		 * 
		 * @param	limit: minimum distance for an enemy to be to start following it.
		 * 			Call with negative number for no limit
		 */ 
		public function findTarget(limit:Number = -1):void
		{
			//Go attack the closest target
			state = ATTACKING;
			var targets:Array = StartLevelState.enemyGroup.members;
			var closest:Number = attackFollowRange;
			if (limit >= 0) {
				closest = limit;
			}
			chaseTarget = null;
			targets = targets.concat(StartLevelState.innocentGroup.members);
			for (var i:Number = 0; i < targets.length; i++)
			{
				var target:FlxSprite = FlxSprite(targets[i]);
				if (target.dead)
				{
					continue;
				}
				/* Find the cop nearest to the minion, but close to the player */
				var dist:Number = MathU.dist(x - target.x, y - target.y);
				if (dist < closest)
				{
					closest = dist;
					chaseTarget = target;
				}
			}
			if (chaseTarget == null)
			{
				state = DEFENDING;
			}
		}	
		
		public override function kill():void
		{
			if(Math.random() > 0.66)
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
				FlxG.play(dieSound,.5,false);
			}		
			
			super.kill();
		}
		
		public function playAttackSound():void
		{
			if(Math.random() > 0.66)
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
				FlxG.play(attackSound,.33,false);
			}
		}		
		
		public function playHurtSound():void
		{
			if(Math.random() > 0.66)
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
				FlxG.play(hurtSound,.33,false);
			}
		}
	}
}
