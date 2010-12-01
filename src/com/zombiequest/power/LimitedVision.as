package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class LimitedVision extends PowerEffect 
 	{
		[Embed(source = "../../../../assets/png/fog.png")]
		private var img:Class;
		private var overlay:FlxSprite
		public function LimitedVision() 
		{
			overlay = new FlxSprite(0, 0, img);
			active = true;
			duration = 30;
		}
		
		public override function affect(p:Player):void
		{
			FlxG.state.add(overlay);
		}
		
		public override function flavorText():String
		{
			return "You just ate a grandma with caracts!";
		}
		public override function destroy():void
		{
			overlay.kill();
			active = false;
		}
	}

}