package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class DoubleDamage implements PowerEffect
	{
		private const duration:Number = 30;
		private var time:Number = 0;
		private var player:Player;
		private var active:Boolean = false;
		public function isActive():Boolean 
		{
			return active;
		}
		public function DoubleDamage() 
		{
			active = true;
		}
		public function affect(p:Player):void
		{
			this.player = p;
			player.damage = player.damage * 2;
		}
		public function updateTime():void
		{
			time += FlxG.elapsed;
			if (time >= duration && active) {
				destroy();
			}
		}
		
		public function flavorText():String
		{
			return "You just ate Jean-Claude Van Damme! Your damage is doubled.";
		}
		
		public function destroy():void
		{
			player.damage = player.damage / 2;
			active = false;
		}
		
		public function timeRemaining():Number
		{
			return Math.floor(duration - time);
		}
	}

}