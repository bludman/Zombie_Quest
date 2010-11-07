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
		override public function create():void
		{
			bgColor = 0xD3D3D3;
			_player = new Player();
			add(_player);
			FlxG.follow(_player);
			
			//Create the HUD
			createHud();
			FlxG.mouse.hide();
			super.create();
		}
		
		override public function update():void
		{
			super.update();
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
	}

}