package com.zombiequest 
{
	import org.flixel.*;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MinionFactory 
	{
		private var player:Player;
		public function MinionFactory(player:Player) 
		{
			this.player = player;
		}
		
		public function getMinion(x:Number, y:Number):void
		{
			var minion:Minion = new Minion(x, y, player);
			StartLevelState.minionGroup.add(minion);
			//FlxG.state.add(minion);
		}
	}

}