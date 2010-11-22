package com.zombiequest
{
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	
	public class HUDMaker
	{
		private var healthBar:FlxSprite;
		private var healthAnim:FlxSprite;
		private var statusText:FlxText;
		
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
			if(amount < 2.5)
				healthAnim.visible=false;
			else 
				healthAnim.visible=true;
			
			healthAnim.play(""+(20-Math.round(amount*0.2)));
		}
	}
}