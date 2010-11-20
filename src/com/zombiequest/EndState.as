package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class EndState extends FlxState 
	{
		private var button:FlxButton;
		private var text:FlxText
		public function EndState(text:String)
		{
			this.text = new FlxText(50, 25, 100, text);
		}
		public override function create():void
		{
			button = new FlxButton(50, 50, loadStartLevel);
			var buttonText:FlxText = new FlxText(0, 0, 100, "Start Over");
			text.color = buttonText.color = 0x00000000;
			button.loadText(buttonText);
			add(button);
			add(text);
			FlxG.mouse.show();
		}
		private function loadStartLevel():void
		{
			FlxG.state = new StartLevelState();
		}
		
	}

}