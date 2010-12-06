package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.*;
	public class Minion extends FlxSprite
	{
		private var speed:Number = 90;
		private var attackRange:Number = 20;
		private var sentryFollowRange:Number = 100;
		private var attackFollowRange:Number = 200;
		private var playerFollowMin:Number = 64;
		private var damage:Number = 25;
		private const attackTimeout:Number = 1;
		private var attackTimer:Number = 0;
		private var player:Player;
		private var chasing:Boolean = false;
		private var chaseTarget:FlxSprite;
		private static var id:Number = 0;
		public var pid:Number;
		public const MAX_HEALTH:Number = 100;
		
		
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
			this.player = player;
			id++;
			pid = id;
			state = DEFENDING;
			health = MAX_HEALTH;
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
				}
			}
			else if (state == SENTRY)
			{
				//Find something to attack
				findTarget(sentryFollowRange);
			} 
			else if (state == ATTACKING)
			{
				angle = FlxU.getAngle(chaseTarget.x - x, chaseTarget.y - y);
				velocity.x = speed * Math.cos(MathU.degToRad(angle));
				velocity.y = speed * Math.sin(MathU.degToRad(angle));
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
				var dist:Number = MathU.dist(x - target.x, y - target.y);
				if (dist < closest)
				{
					closest = dist;
					chaseTarget = target;
				}
			}
			if (chaseTarget == null)
			{
				state = SENTRY;
			}
		}
	}
}
