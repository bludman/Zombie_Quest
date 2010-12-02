package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class HalfSpeed extends PowerEffect
	{

		public function HalfSpeed() 
		{
			duration = 15;
			active = true;
		}
		public override function affect(p:Player):void
		{
			this.player = p;
			player.setSpeed = player.origSpeed / 2;
		}
		
		public override function flavorText():String
		{
			return "You just ate someone in a wheelchair! Your speed is halved.";
		}
		
		public override function destroy():void
		{
			player.setSpeed = player.origSpeed * 2;
			active = false;
		}
	}

}