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
		
		public function WalkingSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
		}	
		
		protected function goToLocation(X:Number, Y:Number, speed:Number):void
		{		
			colliding = false;
			for each (var tile:FlxTilemap in StartLevelState.level.hitTilemaps.members)
			{
				if(tile.collide(this))
				{
					colliding = true;
					hitTile = tile;
					//DO NOT BREAK; - MUST COLLIDE WITH ALL TILES
				}
			}
			
			if (!colliding)
			{
				angle = FlxU.getAngle(X - x, Y - y);
			}
			
			velocity.x = speed * Math.cos(MathU.degToRad(angle));
			velocity.y = speed * Math.sin(MathU.degToRad(angle));
		}
	}
}
