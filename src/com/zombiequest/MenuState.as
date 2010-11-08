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
		override public function create():void
		{
			bgColor = 0xFFD3D3D3;
			createButtons();
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
		
		private function loadStartLevel():void
		{
			FlxG.state = new StartLevelState();
		}
	}

}