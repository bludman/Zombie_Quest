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
			layerGroup1bg.x = 0.000000;
			layerGroup1bg.y = 0.000000;
			layerGroup1bg.scrollFactor.x = 1.000000;
			layerGroup1bg.scrollFactor.y = 1.000000;
			layerGroup1bg.collideIndex = 1;
			layerGroup1bg.drawIndex = 1;
			layerGroup1Map1 = new FlxTilemap;
			layerGroup1Map1.loadMap( new CSV_Group1Map1, Img_Group1Map1, 64,64 );
			layerGroup1Map1.x = 0.000000;
			layerGroup1Map1.y = 0.000000;
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

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 1920;
			boundsMaxY = 4160;

		}

		override public function addSpritesForLayerGroup1Layer3(onAddCallback:Function = null):void
		{
			addSpriteToLayer(Player, Group1Layer3Group , 880.000, 4000.000, 268.980, false, onAddCallback );//"Player"
			addSpriteToLayer(Innocent, Group1Layer3Group , 881.500, 2561.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Enemy, Group1Layer3Group , 856.000, 3346.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 916.000, 3346.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(EnemyPowerup, Group1Layer3Group , 856.000, 1696.000, 0.000, false, onAddCallback );//"enemyPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 736.000, 1576.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 946.000, 1576.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(EnemyPowerup, Group1Layer3Group , 196.000, 676.000, 0.000, false, onAddCallback );//"enemyPowerup"
			addSpriteToLayer(EnemyPowerup, Group1Layer3Group , 346.000, 796.000, 0.000, false, onAddCallback );//"enemyPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 196.000, 436.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 346.000, 556.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Enemy, Group1Layer3Group , 466.000, 676.000, 0.000, false, onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(Innocent, Group1Layer3Group , 161.500, 761.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 521.500, 581.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 401.500, 281.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1001.500, 191.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Coin, Group1Layer3Group , 1448.000, 158.000, 0.000, false, onAddCallback );//"Coin"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1151.500, 551.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1121.500, 701.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1241.500, 761.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1391.500, 701.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1391.500, 551.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1271.500, 551.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1571.500, 611.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(Innocent, Group1Layer3Group , 1511.500, 731.500, 0.000, false, onAddCallback );//"Innocent"
			addSpriteToLayer(EnemyPowerup, Group1Layer3Group , 1366.000, 166.000, 92.078, false, onAddCallback );//"enemyPowerup"
		}


	}
}
