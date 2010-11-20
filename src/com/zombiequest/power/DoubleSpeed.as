package com.zombiequest.power 
{
	import com.zombiequest.Player;
	import org.flixel.*;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class DoubleSpeed implements PowerEffect
	{
		private const duration:Number = 30;
		private var time:Number = 0;
		private var player:Player;
		private var active:Boolean = false;
		public function isActive():Boolean 
		{
			return active;
		}
		public function DoubleSpeed() 
		{
			active = true;
		}
		public function affect(p:Player):void
		{
			this.player = p;
			player.setSpeed = player.getSpeed * 2;
		}
		public function update():void
		{
			time += FlxG.elapsed;
			if (time >= duration && active) {
				destroy();
			}
		}
		
		public function flavorText():String
		{
			return "You just ate Usain Bolt! You got double speed";
		}
		
		public function destroy():void
		{
			player.setSpeed = player.getSpeed / 2;
			active = false;
		}
	}

}