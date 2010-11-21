//Code generated with DAME. http://www.dambots.com

package com.zombiequest
{
	import org.flixel.*;
	public class Level_LevelOne extends Map
	{
		//Embedded media...
		[Embed(source="../../../assets/maps/mapCSV_Group1_Map1.csv", mimeType="application/octet-stream")] public var CSV_Group1Map1:Class;
		[Embed(source="../../../assets/jpeg/temp_tiles.jpg")] public var Img_Group1Map1:Class;

		//Tilemaps
		public var layerGroup1Map1:FlxTilemap;

		//Sprites
		public var Group1Layer1Group:FlxGroup = new FlxGroup;


		public function Level_LevelOne(addToStage:Boolean = true, onAddSpritesCallback:Function = null)
		{
			// Generate maps.
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 64,64 );
			layerGroup1Map1.x = -192.000000;
			layerGroup1Map1.y = 192.000000;
			layerGroup1Map1.scrollFactor.x = 1.000000;
			layerGroup1Map1.scrollFactor.y = 1.000000;
			layerGroup1Map1.collideIndex = 1;
			layerGroup1Map1.drawIndex = 1;

			//Add layers to the master group in correct order.
			masterLayer.add(Group1Layer1Group);
			Group1Layer1Group.scrollFactor.x = 1.000000;
			Group1Layer1Group.scrollFactor.y = 1.000000;
			masterLayer.add(layerGroup1Map1);


			if ( addToStage )
			{
				addSpritesForLayerGroup1Layer1(onAddSpritesCallback);
				FlxG.state.add(masterLayer);
			}

			mainLayer = layerGroup1Map1;

			boundsMinX = -192;
			boundsMinY = 192;
			boundsMaxX = 4608;
			boundsMaxY = 19392;

		}

		override public function addSpritesForLayerGroup1Layer1(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Enemy, Group1Layer1Group , 735.500, 18376.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 585.500, 16906.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 975.500, 16786.500, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 615.500, 16366.500, 0.000, false, onAddCallback );//"enemyWithPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 285.500, 15616.500, 98.236, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 195.500, 15556.500, 64.925, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 135.500, 15316.500, 106.925, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 345.500, 15346.500, 310.255, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer1Group , 255.000, 15435.968, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1061.500, 15311.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1061.500, 15341.500, 178.834, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1181.500, 15881.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1241.500, 15941.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1271.500, 15941.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1331.500, 15881.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1301.500, 15851.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1241.500, 15791.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1151.500, 15791.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1061.500, 15821.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 971.500, 15791.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1001.500, 15791.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1121.500, 15851.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1181.500, 15851.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1241.500, 15851.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer1Group , 1271.500, 15881.500, 0.000, false, onAddCallback );//"Innocent"
		}


	}
}
