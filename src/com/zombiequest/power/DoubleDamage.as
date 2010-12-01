package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class DoubleDamage extends PowerEffect
	{

		public function DoubleDamage() 
		{
			duration = 30;
			active = true;
		}
		public override function affect(p:Player):void
		{
			this.player = p;
			player.damage = player.damage * 2;
		}
		
		public override function flavorText():String
		{
			return "You just ate Jean-Claude Van Damme! Your damage is doubled.";
		}
		
		public override function destroy():void
		{
			player.damage = player.damage / 2;
			active = false;
		}
	}

}