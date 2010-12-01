package com.zombiequest.power 
{
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import com.zombiequest.Player
	import org.flixel.*;
	public class PowerEffect
	{
		protected var duration:Number;
		protected var time:Number = 0;
		protected var player:Player;
		protected var active:Boolean = false;
		public function PowerEffect() {
			Error("Should not instantiate PowerEffect");
		}
		public function affect(p:Player):void {
			Error("Calling affect from PowerEffect, should be called by subclass");
		}
		public function updateTime():void
		{
			time += FlxG.elapsed;
			if (time >= duration && active) {
				destroy();
			}
			try {
				
			}
		}
		public function flavorText():String
		{
			return "Should not call flavorText from PowerEffect";
		}
		public function destroy():void {
			Error("Should not call destroy from PowerEffect");
		}
		public function isActive():Boolean
		{
			return active;
		}
		public function timeRemaining():Number
		{
			return Math.floor(duration - time);
		}
	}
	
}