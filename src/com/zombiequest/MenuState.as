package com.zombiequest 
{
	import flash.text.Font;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MenuState extends FlxState 
	{
		private var _startButton:FlxButton;
		
		[Embed(source = "../../../assets/png/cop_frame.png")]
		private var REnemy:Class;
		private var enemy1:FlxSprite; 
		
		[Embed(source = "../../../assets/png/cop2_frame.png")]
		private var FEnemy:Class;
		private var enemy2:FlxSprite;
		
		[Embed(source = "../../../assets/png/cop3_frame.png")]
		private var CEnemy:Class;
		private var enemy3:FlxSprite;
		
		override public function create():void
		{
			bgColor = 0xFFD3D3D3;
			createButtons();
			createInstructions();
			createEnemyKey();
			FlxG.mouse.show();
			super.create();
		}
		
		override public function update():void 
		{
			super.update();
		}
		
		private function createButtons():void
		{
			_startButton = new FlxButton(50, 50, loadStartLevel);
			var startText:FlxText = new FlxText(0, 0, 100, "Start");
			startText.color = 0x000000;
			_startButton.loadText(startText);
			this.add(_startButton);
			
		}
		private function createInstructions():void
		{
			var inst:String = "Arrow Keys - Move\n"
			inst += "A - Send minions to attack\n";
			inst += "S - Call minions to follow you\n";
			inst += "Space - Attack";
			var instText:FlxText = new FlxText(200, 150, 400, inst);
			instText.color = 0xff000000;
			instText.size = 14;
			add(instText);
			
		}
		
		private function createEnemyKey():void
		{	
			enemy1 = new FlxSprite(190, 250);
			enemy1.loadGraphic(REnemy);
			add(enemy1);
			
			enemy2 = new FlxSprite(190, 280);
			enemy2.loadGraphic(FEnemy);
			add(enemy2);
			
			enemy3 = new FlxSprite(190, 310);
			enemy3.loadGraphic(CEnemy);
			add(enemy3);
			
			var key1:String = " - Regular Cop";
			var key2:String = " - Fearless Cop"
			var key3:String = " - Cautious Cop";
			
			var keyText1:FlxText = new FlxText(230, 261, 200, key1);
			keyText1.color = 0xff000000;
			keyText1.size = 14;
			add(keyText1);
			
			var keyText2:FlxText = new FlxText(230, 291, 200, key2);
			keyText2.color = 0xff000000;
			keyText2.size = 14;
			add(keyText2);
			
			var keyText3:FlxText = new FlxText(230, 321, 200, key3);
			keyText3.color = 0xff000000;
			keyText3.size = 14;
			add(keyText3);
			
			
		}
		
		private function loadStartLevel():void
		{
			FlxG.state = new StartLevelState();
		}
	}

}