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
		private var followRange:Number = 50;
		private var playerFollowMin:Number = 20;
		private var damage:Number = 25;
		private var enemyGroup:FlxGroup;
		private var innocentGroup:FlxGroup;
		private var player:Player;
		private var chasing:Boolean = false;
		private var chaseTarget:FlxSprite;
		/**
		 * Should only be called by the MinionFactory
		 */
		public function Minion(x:Number, y:Number, enemyGroup:FlxGroup, innocentGroup:FlxGroup, player:Player) 
		{
			this.enemyGroup = enemyGroup;
			this.innocentGroup = innocentGroup;
			this.player = player;
			super(x, y);
		}
		
		public override function update():void
		{
			var angle:Number;
			var dist:Number;
			velocity.x = 0;
			velocity.y = 0;
			if (!chasing || chaseTarget.dead) {
				var targets:Array = enemyGroup.members;
				targets = targets.concat(innocentGroup.members);
				for (var i:Number = 0; i < targets.length; i++ && !chasing) {
					if (MathU.dist(x - FlxSprite(targets[i]).x, y - FlxSprite(targets[i]).y) < followRange)
					{
						if(!FlxSprite(targets[i]).dead){
							chasing = true;
							chaseTarget = targets[i] as FlxSprite;
						}
					}
				}
				if (!chasing) {
					angle = FlxU.getAngle(player.x - x, player.y - y);
					dist = MathU.dist(player.x - x, player.y - y);
					if (dist > playerFollowMin) 
					{
						velocity.x = speed * Math.cos(MathU.degToRad(angle));
						velocity.y = speed * Math.sin(MathU.degToRad(angle));
					}
				}
			}
			if (chasing && !chaseTarget.dead) {
				angle = FlxU.getAngle(chaseTarget.x - x, chaseTarget.y - y);
				this.angle = angle;
				dist = MathU.dist(chaseTarget.x - x, chaseTarget.y - y);
				if (dist <= attackRange) {
					attack(chaseTarget);
				}
				velocity.x = speed * Math.cos(MathU.degToRad(angle));
				velocity.y = speed * Math.sin(MathU.degToRad(angle));
			}
			super.update();
		}
		
		private function attack(target:FlxSprite):void
		{
			
		}
	}
}
