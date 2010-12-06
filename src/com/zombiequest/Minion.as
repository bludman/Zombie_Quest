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
		private var followRange:Number = 100;
		private var playerFollowMin:Number = 64;
		private var damage:Number = 25;
		private const attackTimeout:Number = 1;
		private var attackTimer:Number = 0;
		private var player:Player;
		private var chasing:Boolean = false;
		private var chaseTarget:FlxSprite;
		private static var id:Number = 0;
		
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
			this.player = player;
			id++;
			state = DEFENDING;
			super(x, y);
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
				findTarget(followRange);
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
				}
			}
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
			var closest:Number = 2000; //more than 2x the distance of the level
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
