//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	public class Level_LevelOne extends Map
	{
		//Embedded media...
		[Embed(source="../../../assets/maps/mapCSV_Group1_bg.csv", mimeType="application/octet-stream")] public var CSV_Group1bg:Class;
		[Embed(source="../../../assets/jpeg/temp_tiles.jpg")] public var Img_Group1bg:Class;
		[Embed(source="../../../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		[Embed(source="../../../assets/jpeg/temp_tiles.jpg")] public var Img_Group1Map1:Class;

		//Tilemaps
		public var layerGroup1bg:FlxTilemap;
		public var layerGroup1Map1:FlxTilemap;

		//Sprites
		public var Group1Layer3Group:FlxGroup = new FlxGroup;


		public function Level_LevelOne(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1bg = new FlxTilemap;
			layerGroup1bg.loadMap( new CSV_Group1bg, Img_Group1bg, 64,64 );
			layerGroup1bg.x = -192.000000;
			layerGroup1bg.y = 192.000000;
			layerGroup1bg.scrollFactor.x = 1.000000;
			layerGroup1bg.scrollFactor.y = 1.000000;
			layerGroup1bg.collideIndex = 1;
			layerGroup1bg.drawIndex = 1;
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 64,64 );
			layerGroup1Map1.x = -192.000000;
			layerGroup1Map1.y = 192.000000;
			layerGroup1Map1.scrollFactor.x = 1.000000;
			layerGroup1Map1.scrollFactor.y = 1.000000;
			layerGroup1Map1.collideIndex = 1;
			layerGroup1Map1.drawIndex = 1;

			//Add layers to the master group in correct order.
			masterLayer.add(layerGroup1bg);
			masterLayer.add(Group1Layer3Group);
			Group1Layer3Group.scrollFactor.x = 1.000000;
			Group1Layer3Group.scrollFactor.y = 1.000000;
			masterLayer.add(layerGroup1Map1);


			if ( addToStage )
			{
				addSpritesForLayerGroup1Layer3(onAddSpritesCallback);
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Map1;

			boundsMinX = -192;
			boundsMinY = 192;
			boundsMaxX = 1728;
			boundsMaxY = 4352;

		}

		override public function addSpritesForLayerGroup1Layer3(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Player, Group1Layer3Group , 700.000, 4150.000, 268.980, false, onAddCallback );//"Player"
			addSpriteToLayer(Enemy, Group1Layer3Group , 675.520, 3345.520, 356.410, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 736.000, 3346.000, 357.180, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Innocent, Group1Layer3Group , 671.500, 2591.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Enemy, Group1Layer3Group , 676.000, 1756.000, 359.940, false, onAddCallback );//"enemyWithPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 466.000, 1906.000, 90.820, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 856.000, 1906.000, 91.300, false, onAddCallback );//"enemyNoPowerup"
		}


	}
}
