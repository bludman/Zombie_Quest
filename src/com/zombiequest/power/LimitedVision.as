package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class LimitedVision implements PowerEffect 
 	{
		[Embed(source = "../../../../assets/png/fog.png")]
		private var img:Class;
		private const duration:Number = 30;
		private var time:Number = 0;
		private var player:Player;
		private var active:Boolean = false;
		private var overlay:FlxSprite;
		public function LimitedVision() 
		{
			overlay = new FlxSprite(0, 0, img);
		}
		
		public function affect(p:Player):void
		{
			FlxG.state.add(overlay);
			active = true;
		}
		
		public function updateTime():void
		{
			time += FlxG.elapsed;
			if (time >= duration) {
				this.destroy();
			}
		}
		public function flavorText():String
		{
			return "You just ate a grandma with caracts!";
		}
		public function destroy():void
		{
			overlay.kill();
			active = false;
		}
		public function isActive():Boolean
		{
			return active;
		}
		public function timeRemaining():Number
		{
			return duration - time;
		}
	}

}