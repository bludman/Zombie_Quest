//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	public class Level_Group1 extends Map
	{
		//Embedded media...
		[Embed(source="../../../assets/maps/mapCSV_Group1_bg.csv", mimeType="application/octet-stream")] public var CSV_bg:Class;
		[Embed(source="../../../assets/jpeg/temp_tiles.jpg")] public var Img_bg:Class;
		[Embed(source="../../../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Map1:Class;
		[Embed(source="../../../assets/jpeg/temp_tiles.jpg")] public var Img_Map1:Class;

		//Tilemaps
		public var layerbg:FlxTilemap;
		public var layerMap1:FlxTilemap;

		//Properties


		public function Level_Group1(addToStage:Boolean = true, onAddCallback:Function = null)
		{
			// Generate maps.
			var properties:Array = [];

			generateProperties( null );
			layerbg = addTilemap( CSV_bg, Img_bg, 0.000, 0.000, 64, 64, 1.000, 1.000, false, 1, 1, properties, onAddCallback );
			generateProperties( null );
			layerMap1 = addTilemap( CSV_Map1, Img_Map1, 0.000, 0.000, 64, 64, 1.000, 1.000, true, 1, 1, properties, onAddCallback );

			//Add layers to the master group in correct order.
			masterLayer.add(layerbg);
			masterLayer.add(layerMap1);

			if ( addToStage )
				createObjects(onAddCallback);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 1280;
			boundsMaxY = 1024;
			bgColor = 0xff000000;
		}

		override public function createObjects(onAddCallback:Function = null):void
		{
			generateObjectLinks(onAddCallback);
			FlxG.state.add(masterLayer);
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
