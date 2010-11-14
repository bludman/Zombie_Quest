//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	public class Level_LevelOne extends MapTest
	{
		//Embedded media...
		[Embed(source="../../../assets/maps/mapCSV_Group1_Map2.csv", mimeType="application/octet-stream")] public var CSV_Group1Map2:Class;
		[Embed(source="C:/Program Files/DAME/samples/SimpleClaws/data/maintiles.png")] public var Img_Group1Map2:Class;

		//Tilemaps
		public var layerGroup1Map2:FlxTilemap;

		//Sprites
		public var Group1Layer1Group:FlxGroup = new FlxGroup;


		public function Level_LevelOne(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Map2 = new FlxTilemap;
			layerGroup1Map2.loadMap( new CSV_Group1Map2, Img_Group1Map2, 25,25 );
			layerGroup1Map2.x = 0.000000;
			layerGroup1Map2.y = 0.000000;
			layerGroup1Map2.scrollFactor.x = 1.000000;
			layerGroup1Map2.scrollFactor.y = 1.000000;
			layerGroup1Map2.collideIndex = 1;
			layerGroup1Map2.drawIndex = 1;

			//Add layers to the master group in correct order.
			masterLayer.add(Group1Layer1Group);
			Group1Layer1Group.scrollFactor.x = 1.000000;
			Group1Layer1Group.scrollFactor.y = 1.000000;
			masterLayer.add(layerGroup1Map2);


			if ( addToStage )
			{
				addSpritesForLayerGroup1Layer1(onAddSpritesCallback);
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Map2;

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 500;
			boundsMaxY = 500;

		}

		override public function addSpritesForLayerGroup1Layer1(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Coin, Group1Layer1Group , 441.500, 447.000, 0.000, false, onAddCallback );//"Coin"
		}


	}
}
