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
			createReport();
			FlxG.mouse.show();
		}
		private function loadStartLevel():void
		{
			FlxG.state = new StartLevelState();
		}

		private function createReport():void
		{
			var inst:String = "You ate " + StartLevelState.playerBrainCount; 
			if (StartLevelState.playerBrainCount == 1)
				inst += " brain.\n";
			else
				inst += " brains.\n"

			inst += "Your minions ate " +  StartLevelState.minionBrainCount;
			if (StartLevelState.minionBrainCount == 1)
				inst += " brain.\n";
			else
				inst += " brains.\n"
				
			inst += "Your total survival time was " + StartLevelState.generateClock() + "\n";
			inst += "Your score is " + StartLevelState.calculateScore();
			var instText:FlxText = new FlxText(200, 200, 200, inst);
			instText.color = 0xff000000;
			add(instText);
			
		}
		
	}

}