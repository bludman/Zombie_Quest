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
			if (chasing) {
				var angle:Number = FlxU.getAngle(chaseTarget.x - x, chaseTarget.y - y);
				this.angle = angle;
				var dist:Number = MathU.dist(chaseTarget.x - x, chaseTarget.y - y);
				if (dist <= attackRange) {
					
				}
				
				
			}
			super.update();
		}
	}
}
