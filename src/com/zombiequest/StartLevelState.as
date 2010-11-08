package com.zombiequest 
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class StartLevelState extends FlxState 
	{
		private var _player:Player;
		private var _healthBar:FlxSprite;
		private var level:MapTest;
		private var coin:Coin;
		override public function create():void
		{
			bgColor = 0xD3D3D3;
			_player = new Player();
			_player.x += 30;
			level = new Level_LevelOne(true, onAddCoin);
			
			//Set up the camera
			FlxG.follow(_player, 2.5);
			FlxG.followAdjust(.5, .2);
			FlxG.followBounds(level.mainLayer.left + 1, level.mainLayer.top + 1, level.mainLayer.right - 1, level.mainLayer.bottom - 1);
			FlxU.setWorldBounds(level.mainLayer.left, level.mainLayer.top, level.mainLayer.width, level.mainLayer.height);
			//Create the HUD
			add(_player);
			createHud();
			FlxG.mouse.hide();
			super.create();
		}
		
		override public function update():void
		{
			super.update();
			level.mainLayer.collide(_player);
			if (FlxU.overlap(_player, coin, doNothing))
			{
				trace("you got the item!");
			}
		}
		private function createHud():void
		{
			_healthBar = new FlxSprite(5, 5);
			_healthBar.createGraphic(1, 8, 0xffff0000);
			_healthBar.scrollFactor.x = _healthBar.scrollFactor.y = 0;
			_healthBar.origin.x = _healthBar.origin.y = 0;
			_healthBar.scale.x = 100;
			
			add(_healthBar);
		}
		
		protected function onAddCoin(sprite:FlxSprite, group:FlxGroup):void
		{
			if (sprite is Coin)
			{
				coin = sprite as Coin;
			}
		}
		
		protected function doNothing(... rest):Boolean
		{
			return true;
		}
	}

}