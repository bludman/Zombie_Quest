package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class LimitedVision extends FlxSprite implements PowerEffect 
 	{
		[Embed(source = "../../../assets/png/fog.png")]
		private var img:Class;
		public function LimitedVision() 
		{
			super(0, 0, img);
		}
		
		public override function affect(p:Player)
		{
			FlxG.state.add(this);
		}
		
		function update():void
		{
			//Update time
		}
		function flavorText():String; //Text to be displayed
		function destroy():void;
		function isActive():Boolean;
		function timeRemaining():Number; //time remaining

	}

}