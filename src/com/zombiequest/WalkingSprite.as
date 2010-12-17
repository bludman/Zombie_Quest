package com.zombiequest 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import org.flixel.*;
	public class WalkingSprite extends FlxSprite
	{
		private var hitTile:FlxTilemap = null;
		private var colliding:Boolean;
		private var angletime:Number = 1;
		
		public function WalkingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
		}	
		
		protected function goToLocation(X:Number, Y:Number, speed:Number):void
		{		
			//angletime -= FlxG.elapsed;
			//if (angletime<=0)
			//{
			//	angletime = 1;
				colliding = false;				
			//}
			//for each (var tile:FlxTilemap in StartLevelState.level.hitTilemaps.members)
			//{
				
			//}
			
			if (!colliding)
			{
				hitTile = null;
				angle = FlxU.getAngle(X - x, Y - y);
			}
			
			velocity.x = speed * Math.cos(MathU.degToRad(angle));
			velocity.y = speed * Math.sin(MathU.degToRad(angle));
		}
	}
}
