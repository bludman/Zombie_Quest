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

		//Sprites
		public var Layer3Group:FlxGroup = new FlxGroup;

		//Shapes
		public var textGroup:FlxGroup = new FlxGroup;

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
			masterLayer.add(Layer3Group);
			Layer3Group.scrollFactor.x = 1.000000;
			Layer3Group.scrollFactor.y = 1.000000;
			masterLayer.add(textGroup);
			textGroup.scrollFactor.x = 1.000000;
			textGroup.scrollFactor.y = 1.000000;
			masterLayer.add(layerMap1);

			if ( addToStage )
				createObjects(onAddCallback);

			boundsMinX = 0;
			boundsMinY = 0;
			boundsMaxX = 1920;
			boundsMaxY = 4160;
			bgColor = 0xff000000;
		}

		override public function createObjects(onAddCallback:Function = null):void
		{
			addShapesForLayertext(onAddCallback);
			addSpritesForLayerLayer3(onAddCallback);
			generateObjectLinks(onAddCallback);
			FlxG.state.add(masterLayer);
		}

		public function addShapesForLayertext(onAddCallback:Function = null):void
		{
			var obj:Object;

			callbackNewData(new TextData(840.000, 3900.000, 100.000, 50.000, 0.900, "Zombie Killers closing in!  Beware!  (press space to attack)","system", 8, 0x0, "center"), onAddCallback, textGroup, generateProperties( null ) ) ;
			callbackNewData(new TextData(828.000, 2429.000, 100.000, 58.820, 0.000, "This is an innocent bystander. You can eat him to regain health, but beware the consequences.","system", 8, 0x0, "center"), onAddCallback, textGroup, generateProperties( null ) ) ;
			callbackNewData(new TextData(830.000, 1793.000, 100.000, 50.000, 0.000, "The enemy in red will give you a powerup once you defeat him.","system", 8, 0x0, "center"), onAddCallback, textGroup, generateProperties( null ) ) ;
			callbackNewData(new TextData(1398.000, 212.000, 100.000, 50.000, 0.000, "Grab the coin to finish the level.","system", 8, 0x0, "center"), onAddCallback, textGroup, generateProperties( null ) ) ;
		}

		public function addSpritesForLayerLayer3(onAddCallback:Function = null):void
		{
			addSpriteToLayer(new Player(870.000, 3990.000), Player, Layer3Group , 870.000, 3990.000, 268.980, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Player"
			addSpriteToLayer(null, Innocent, Layer3Group , 870.000, 2550.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(new Enemy(840.000, 3330.000, false), Enemy, Layer3Group , 840.000, 3330.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(new Enemy(900.000, 3330.000, false), Enemy, Layer3Group , 900.000, 3330.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(new Enemy(840.000, 1680.000, true), Enemy, Layer3Group , 840.000, 1680.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyPowerup"
			addSpriteToLayer(new Enemy(720.000, 1560.000, false), Enemy, Layer3Group , 720.000, 1560.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(new Enemy(930.000, 1560.000, false), Enemy, Layer3Group , 930.000, 1560.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(new Enemy(180.000, 660.000, true), Enemy, Layer3Group , 180.000, 660.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyPowerup"
			addSpriteToLayer(new Enemy(330.000, 780.000, true), Enemy, Layer3Group , 330.000, 780.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyPowerup"
			addSpriteToLayer(new Enemy(180.000, 420.000, false), Enemy, Layer3Group , 180.000, 420.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(new Enemy(330.000, 540.000, false), Enemy, Layer3Group , 330.000, 540.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(new Enemy(450.000, 660.000, false), Enemy, Layer3Group , 450.000, 660.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyNoPowerup"
			addSpriteToLayer(null, Innocent, Layer3Group , 150.000, 750.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 510.000, 570.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 390.000, 270.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 990.000, 180.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Coin, Layer3Group , 1440.000, 150.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Coin"
			addSpriteToLayer(null, Innocent, Layer3Group , 1140.000, 540.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1110.000, 690.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1230.000, 750.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1380.000, 690.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1380.000, 540.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1260.000, 540.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1560.000, 600.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(null, Innocent, Layer3Group , 1500.000, 720.000, 0.000, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"Innocent"
			addSpriteToLayer(new Enemy(1350.000, 150.000, true), Enemy, Layer3Group , 1350.000, 150.000, 92.080, false, 1.000, 1.000, generateProperties( null ), onAddCallback );//"enemyPowerup"
		}

		public function generateObjectLinks(onAddCallback:Function = null):void
		{
		}

	}
}
