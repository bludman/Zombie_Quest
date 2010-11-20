package com.zombiequest.power 
{
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	import com.zombiequest.Player
	public interface PowerEffect
	{
		function affect(p:Player):void; //Start effects
		function update():void; //Update time
		function flavorText():String; //Text to be displayed
		function destroy():void;
		function isActive():Boolean;
	}
	
}