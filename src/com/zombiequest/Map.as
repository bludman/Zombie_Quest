//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	import flash.utils.Dictionary;
	public class Map
	{
		// The masterLayer contains every single object in this group making it easy to empty the level.
		public var masterLayer:FlxGroup = new FlxGroup;

		// This group contains all the tilemaps specified to use collisions.
		public var hitTilemaps:FlxGroup = new FlxGroup;

		public static var boundsMinX:int;
		public static var boundsMinY:int;
		public static var boundsMaxX:int;
		public static var boundsMaxY:int;

		public var bgColor:uint = 0;
		public var paths:Array = [];	// Array of PathData
		public var shapes:Array = [];	//Array of ShapeData.
		public static var linkedObjectDictionary:Dictionary = new Dictionary;

		public function Map() { }

		// Expects callback function to be callback(newobj:Object,layer:FlxGroup,level:BaseLevel,properties:Array)
		public function createObjects(onAddCallback:Function = null):void { }

		public function addTilemap( mapClass:Class, imageClass:Class, x:Number, y:Number, tileWidth:uint, tileHeight:uint, scrollX:Number, scrollY:Number, hits:Boolean, collideIdx:uint, drawIdx:uint, properties:Array, onAddCallback:Function = null ):FlxTilemap
		{
			var map:FlxTilemap = new FlxTilemap;
			map.collideIndex = collideIdx;
			map.drawIndex = drawIdx;
			map.loadMap( new mapClass, imageClass, tileWidth, tileHeight );
			map.x = x;
			map.y = y;
			map.scrollFactor.x = scrollX;
			map.scrollFactor.y = scrollY;
			if ( hits )
				hitTilemaps.add(map);
			if(onAddCallback != null)
				onAddCallback(map, null, this, properties);
			return map;
		}

		public function addSpriteToLayer(obj:FlxSprite, type:Class, layer:FlxGroup, x:Number, y:Number, angle:Number, flipped:Boolean = false, scaleX:Number = 1, scaleY:Number = 1, properties:Array = null, onAddCallback:Function = null):FlxSprite
		{
			if( obj == null )
				obj = new type(x, y);
			obj.x += obj.offset.x;
			obj.y += obj.offset.y;
			obj.angle = angle;
			// Only override the facing value if the class didn't change it from the default.
			if( obj.facing == FlxSprite.RIGHT )
				obj.facing = flipped ? FlxSprite.LEFT : FlxSprite.RIGHT;
			if ( scaleX != 1 || scaleY != 1 )
			{
				obj.scale.x = scaleX;
				obj.scale.y = scaleY;
				obj.width *= scaleX;
				obj.height *= scaleY;
				// Adjust the offset, in case it was already set.
				var newFrameWidth:Number = obj.frameWidth * scaleX;
				var newFrameHeight:Number = obj.frameHeight * scaleY;
				var hullOffsetX:Number = obj.offset.x * scaleX;
				var hullOffsetY:Number = obj.offset.y * scaleY;
				obj.offset.x -= (newFrameWidth- obj.frameWidth) / 2;
				obj.offset.y -= (newFrameHeight - obj.frameHeight) / 2;
				// Refresh the collision hulls. If your object moves and you have an offset you should override refreshHulls so that hullOffset is always added.
				obj.colHullX.x = obj.colHullY.x = obj.x + hullOffsetX;
				obj.colHullX.y = obj.colHullY.y = obj.y + hullOffsetY;
				obj.colHullX.width = obj.colHullY.width = obj.width;
				obj.colHullX.height = obj.colHullY.height = obj.height;
			}
			layer.add(obj,true);
			callbackNewData(obj, onAddCallback, layer, properties, false);
			return obj;
		}

		public function addTextToLayer(textdata:TextData, layer:FlxGroup, embed:Boolean, properties:Array, onAddCallback:Function ):FlxText
		{
			var textobj:FlxText = new FlxText(textdata.x, textdata.y, textdata.width, textdata.text, embed);
			textobj.setFormat(textdata.fontName, textdata.size, textdata.color, textdata.alignment);
			addSpriteToLayer(textobj, FlxText, layer , 0, 0, textdata.angle, false, 1, 1, properties, onAddCallback );
			textobj.height = textdata.height;
			textobj.origin.x = textobj.width * 0.5;
			textobj.origin.y = textobj.height * 0.5;
			return textobj;
		}

		protected function callbackNewData(data:Object, onAddCallback:Function, layer:FlxGroup, properties:Array, needsReturnData:Boolean = false):Object
		{
			if(onAddCallback != null)
			{
				var newData:Object = onAddCallback(data, layer, this, properties);
				if( newData != null )
					data = newData;
				else if ( needsReturnData )
					trace("Error: callback needs to return either the object passed in or a new object to set up links correctly.");
			}
			return data;
		}

		protected function generateProperties( ... arguments ):Array
		{
			var properties:Array = [];
			if ( arguments.length )
			{
				var i:uint = arguments.length - 1;
				while(i--)
				{
					properties.push( arguments[i] );
				}
			}
			return properties;
		}

		public function createLink( objectFrom:Object, target:Object, onAddCallback:Function, properties:Array ):void
		{
			var link:ObjectLink = new ObjectLink( objectFrom, target );
			callbackNewData(link, onAddCallback, null, properties);
		}

	}
}
