package com.zombiequest
{
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	public class HUDMaker
	{
		private var healthBar:FlxSprite;
		private var healthAnim:FlxSprite;
		private var statusText:FlxText;
		private var statusBox:FlxSprite;
		private var timer:FlxText;
		private var timerOffset:Number = 25;
		
		[Embed(source="../../../assets/png/healthempty.png")]
		private var ImgHealth:Class;

		[Embed(source="../../../assets/png/healthanim.png")]
		private var ImgHealthAnim:Class;
		
		public function HUDMaker()
		{
			healthBar = new FlxSprite(0, 0, ImgHealth);
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			FlxG.state.add(healthBar);
			
			healthAnim = new FlxSprite(10, 0);
			healthAnim.scrollFactor.x = healthAnim.scrollFactor.y = 0;
			FlxG.state.add(healthAnim);
			
			healthAnim.loadGraphic(ImgHealthAnim, true, true, 200, 10);
			for (var i:int=0; i<20; i++) {
				healthAnim.addAnimation(""+i, [i], 0);				
			}
			
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
			if(amount < 2.5)
				healthAnim.visible=false;
			else 
				healthAnim.visible=true;
			
			healthAnim.play("" + (20 - Math.round(amount * 0.2)));
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
			return new Array(healthBar, healthAnim);
		}
	}
}