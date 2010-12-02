package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class DoubleSpeed extends PowerEffect
	{
		public function DoubleSpeed() 
		{
			duration = 30;
			active = true;
		}
		public override function affect(p:Player):void
		{
			this.player = p;
			player.setSpeed = player.origSpeed * 2;
		}
		
		public override function flavorText():String
		{
			return "You just ate Usain Bolt! You got double speed";
		}
		
		public override function destroy():void
		{
			player.setSpeed = player.origSpeed / 2;
			active = false;
		}
	}

}