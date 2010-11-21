package com.zombiequest
{
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	public class HUDMaker
	{
		private var healthBar:FlxSprite;
		private var statusText:FlxText;
		
		public function HUDMaker()
		{
			healthBar = new FlxSprite(5, 5);
			healthBar.createGraphic(1, 8, 0xffff0000);
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			healthBar.origin.x = healthBar.origin.y = 0;
			healthBar.scale.x = 100;
			FlxG.state.add(healthBar);
			
			statusText = new FlxText(0, 460, 320);
			statusText.color = 0xff000000;
			statusText.scrollFactor.x = statusText.scrollFactor.y = 0;
			FlxG.state.add(statusText);
		}
		
		public function pushStatusText(text:String):void
		{
			/* In the future, make this function "push" a statusText to
			 * an array of status texts that scroll with time */
			statusText.text = text;
		}
		
		public function clearStatusText():void
		{
			statusText.text = "";
		}
		
		public function setHealth(amount:Number):void
		{
			healthBar.scale.x = amount;
		}
	}
}