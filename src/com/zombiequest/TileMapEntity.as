package com.zombiequest
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	public class TileMapEntity extends Entity
	{
		public var map:Tilemap;
		public var myGrid:Grid;
		public var widthInTiles:uint;
		public var heightInTiles:uint;

		public function TileMapEntity( tilemapDataClass:Class, tilesetClass:Class, X:Number, Y:Number, tileWidth:uint, tileHeight:uint, hits:Boolean, collideIdx:uint = 1)
		{
			x = X;
			y = Y;
			var tilemapData:String = new tilemapDataClass;
			getSizeFromString(tilemapData);
			map = new Tilemap(tilesetClass, widthInTiles * tileWidth, heightInTiles * tileHeight, tileWidth, tileHeight);
			map.loadFromString( tilemapData );
			graphic = map;
			if ( hits )
			{
				type = "solid";
				myGrid = new Grid(map.width, map.height, tileWidth, tileHeight, 0, 0);
				var wid:uint = map.width / map.tileWidth;
				var ht:uint = map.height / map.tileHeight;
				for ( var y:uint = 0; y < ht;  y++ )
				{
					for ( var x: uint = 0; x < wid; x++ )
					{
						if ( map.getTile(x, y) >= collideIdx )
						{
							myGrid.setTile(x, y, true);
						}
					}
				}
				mask  = myGrid;
			}
		}

		private function getSizeFromString(str:String, columnSep:String = ",", rowSep:String = "\n"):void
		{
			var row:Array = str.split(rowSep);
			heightInTiles = row.length;
			for (var y:uint = 0; y < heightInTiles; y ++)
			{
				if (row[y] == '')
					continue;
				var col:Array = row[y].split(columnSep);
				widthInTiles = Math.max(widthInTiles, col.length + 1);
			}
		}
	}
}
