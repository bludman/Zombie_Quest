package com.zombiequest
{
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	public class HUDMaker
	{
		private var HEALTHBARSIZE:Number = 200;
		
		private var healthBar:FlxSprite;
		private var inside:FlxSprite;
		private var frame:FlxSprite;
		
		private var bigBrain:FlxSprite;
		private var bigBrainCount:FlxText;
		
		private var smallBrain:FlxSprite;
		private var smallBrainCount:FlxText;
		
		private var statusText:FlxText;
		private var statusBox:FlxSprite;
		private var timer:FlxText;
		private var timerOffset:Number = 25;
		
		[Embed(source="../../../assets/jpeg/brain_big.jpg")]
		private static var BigBrain:Class;
		
		[Embed(source="../../../assets/jpeg/brain_small.jpg")]
		private static var SmallBrain:Class;
		
		public function HUDMaker()
		{
			frame = new FlxSprite(4,4);
			frame.createGraphic(HEALTHBARSIZE+2,12); //White frame for the health bar
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			StartLevelState.overGroup.add(frame);
			 
			inside = new FlxSprite(5,5);
			inside.createGraphic(HEALTHBARSIZE,10,0xff000000); //Black interior, 48 pixels wide
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			StartLevelState.overGroup.add(inside);
			 
			healthBar = new FlxSprite(5,5);
			healthBar.createGraphic(1,10,0xff669933); //The red bar itself
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			healthBar.origin.x = healthBar.origin.y = 0; //Zero out the origin
			healthBar.scale.x = HEALTHBARSIZE; //Fill up the health bar all the way
			StartLevelState.overGroup.add(healthBar);
			
			bigBrain = new FlxSprite(450,4);
			bigBrain.loadGraphic(BigBrain, false, false, 64, 32);
			bigBrain.scrollFactor.x = bigBrain.scrollFactor.y = 0;
			bigBrain.origin.x = bigBrain.origin.y = 0;
			StartLevelState.overGroup.add(bigBrain);
			
			bigBrainCount = new FlxText(520, 12, 64);
			bigBrainCount.scrollFactor.x = bigBrainCount.scrollFactor.y = 0;
			bigBrainCount.size = 10;
			StartLevelState.overGroup.add(bigBrainCount);
			
			smallBrain = new FlxSprite(550,4);
			smallBrain.loadGraphic(SmallBrain, false, false, 48, 32);
			smallBrain.scrollFactor.x = smallBrain.scrollFactor.y = 0;
			smallBrain.origin.x = smallBrain.origin.y = 0;
			StartLevelState.overGroup.add(smallBrain);
			
			smallBrainCount = new FlxText(605, 12, 64);
			smallBrainCount.scrollFactor.x = smallBrainCount.scrollFactor.y = 0;
			smallBrainCount.size = 10;
			StartLevelState.overGroup.add(smallBrainCount);
			
			
			statusBox = new FlxSprite(0, 460);
			statusBox.scrollFactor.x = statusBox.scrollFactor.y = 0;
			StartLevelState.overGroup.add(statusBox);
			statusText = new FlxText(0, 460, 320);
			statusText.color = 0xff000000;
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			statusBox.createGraphic(statusText.width+timerOffset, statusText.height, 0x00ffffff);
			StartLevelState.overGroup.add(statusText);
			timer = new FlxText(325, 460, 20);
			timer.color = 0xff000000;
			timer.scrollFactor.x = timer.scrollFactor.y = 0;
			StartLevelState.overGroup.add(timer);
			
		}
		
		public function setHealth(amount:Number):void
		{
			
			healthBar.scale.x = amount/(Player.maxHealth/HEALTHBARSIZE);
		}
		
		
		
		public function update():void
		{
			//Just updating the brain counter for now
			bigBrainCount.text = "x " + StartLevelState.playerBrainCount;
			smallBrainCount.text = "x " + StartLevelState.minionBrainCount;
		}
	}
}