package com.zombiequest
{
	import org.flixel.FlxSprite;

	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MapGenerator 
	{		
		[Embed(source = "../../../assets/png/level10.png")]
		protected static var Background:Class;
		
		public function MapGenerator() 
		{
			var bG:FlxSprite = new FlxSprite(0, 0, Background);
			StartLevelState.mapGroup.add(bG);
		}		
	}
}