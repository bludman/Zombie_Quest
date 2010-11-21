//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	public class Map
	{
		public var masterLayer:FlxGroup = new FlxGroup;

		public var mainLayer:FlxTilemap;

		public var boundsMinX:int;
		public var boundsMinY:int;
		public var boundsMaxX:int;
		public var boundsMaxY:int;

		public function Map() { }

		public function addSpriteToLayer(type:Class, group:FlxGroup, x:Number, y:Number, angle:Number, flipped:Boolean, onAddCallback:Function = null):FlxSprite
		{
			var obj:FlxSprite = new type(x, y);
			obj.x += obj.offset.x;
			obj.y += obj.offset.y;
			obj.angle = angle;
			// Only override the facing value if the class didn't change it from the default.
			if( obj.facing == FlxSprite.RIGHT )
				obj.facing = flipped ? FlxSprite.LEFT : FlxSprite.RIGHT;
			group.add(obj,true);
			if(onAddCallback != null)
				onAddCallback(obj, group);
			return obj;
		}

		virtual public function addSpritesForLayerGroup1Layer1(onAddCallback:Function = null):void { }
	}
}
