package com.zombiequest 
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class Coin extends FlxSprite 
	{
		[Embed(source = '../../../assets/png/coin.png')] private var ImgCoin:Class;
		
		public function Coin(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(ImgCoin, true, true, 16, 16);
			addAnimation("spin", [0, 1, 2, 3, 4], 10);
			play("spin");
			calcFrame();
			
		}
		
	}

}