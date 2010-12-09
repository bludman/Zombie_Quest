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
		
		private var statusText:FlxText;
		private var statusBox:FlxSprite;
		private var timer:FlxText;
		private var timerOffset:Number = 25;
		
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
			
			statusBox = new FlxSprite(0, 460);
			statusBox.scrollFactor.x = statusBox.scrollFactor.y = 0;
			FlxG.state.add(statusBox);
			statusText = new FlxText(0, 460, 320);
			statusText.color = 0xff000000;
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			statusBox.createGraphic(statusText.width+timerOffset, statusText.height, 0x00ffffff);
			FlxG.state.add(statusText);
			timer = new FlxText(325, 460, 20);
			timer.color = 0xff000000;
			timer.scrollFactor.x = timer.scrollFactor.y = 0;
			FlxG.state.add(timer);
			
		}
		
		public function pushStatusText(text:String):void
		{
			/* In the future, make this function "push" a statusText to
			 * an array of status texts that scroll with time */
			statusText.text = text;
			//create a new graphic with 100 alpha
			statusBox.createGraphic(statusText.width+timerOffset, statusText.height, 0xffffffff);
		}
		
		public function clearStatusText():void
		{
			statusText.text = "";
			//create a new graphic with 0 alpha
			statusBox.createGraphic(statusText.width+timerOffset, statusText.height, 0x00ffffff);
			timer.text = "";
		}
		
		public function setHealth(amount:Number):void
		{
			
			healthBar.scale.x = amount/(100/HEALTHBARSIZE);
		}
		
		public function updatePowerTimer(amount:Number):void
		{
			if (statusText.text == "") {
				return;
			}
			timer.text = amount.toString();
		}
		
		public function get elements():Array
		{
			return new Array(frame, inside, healthBar);
		}
	}
}