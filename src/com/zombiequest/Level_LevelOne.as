//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	public class Level_LevelOne extends Map
	{
		//Embedded media...
		[Embed(source="../../../assets/maps/mapCSV_Group1_Map2.csv", mimeType="application/octet-stream")] public var CSV_Group1Map2:Class;
		[Embed(source="../../../assets/png/maintiles.png")] public var Img_Group1Map2:Class;

		//Tilemaps
		public var layerGroup1Map2:FlxTilemap;

		//Sprites
		public var Group1Layer1Group:FlxGroup = new FlxGroup;


		public function Level_LevelOne(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Map2 = new FlxTilemap;
			layerGroup1Map2.loadMap( new CSV_Group1Map2, Img_Group1Map2, 32,32 );
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
			boundsMaxX = 640;
			boundsMaxY = 3200;

		}

		override public function addSpritesForLayerGroup1Layer1(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Enemy, Group1Layer1Group , 118.500, 2785.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 445.500, 2527.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 138.500, 2157.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 430.500, 1808.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 117.500, 1409.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 440.500, 998.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 112.500, 512.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 473.500, 205.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Innocent, Group1Layer1Group , 128.500, 162.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 365.500, 396.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 169.500, 430.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 189.500, 723.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 469.500, 641.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 98.500, 996.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 347.500, 1202.500, 0.000, false, onAddCallback );//"Innocent"
		}


	}
}
