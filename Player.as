package 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class Player extends MovieClip
	{
		private var _vx:int;
		private var _vy:int;
		private var _playerHalfWidth:uint;
		private var _playerHalfHeight:uint;
		private var _hasKey:Boolean;

		public function Player()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			_vx = 0;
			_vy = 0;
			_playerHalfWidth = width / 2;
			_playerHalfHeight = height / 2;
			_hasKey = false;
			
			//Add stage event listeners
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			trace("player removed");
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				_vx = -5;
			}
			else if (event.keyCode == Keyboard.RIGHT)
			{
				_vx = 5;
			}
			else if (event.keyCode == Keyboard.UP)
			{
				_vy = -5;
			}
			else if (event.keyCode == Keyboard.DOWN)
			{
				_vy = 5;
			}
		}
		private function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.LEFT || event.keyCode == Keyboard.RIGHT)
			{
				_vx = 0;
			}
			else if (event.keyCode == Keyboard.DOWN || event.keyCode == Keyboard.UP)
			{
				_vy = 0;
			}
		}
		public function onEnterFrame(event:Event):void
		{
			//Move the player
			x += _vx;
			y += _vy;

			//Stop player at the stage edges
			if (x + _playerHalfWidth > stage.stageWidth)
			{
				x = stage.stageWidth - _playerHalfWidth;
			}
			else if (x - _playerHalfWidth < 0)
			{
				x = 0 + _playerHalfWidth;
			}
			if (y - _playerHalfHeight < 0)
			{
				y = 0 + _playerHalfHeight;
			}
			else if (y + _playerHalfHeight > stage.stageHeight)
			{
				y = stage.stageHeight - _playerHalfHeight;
			}
		}
		//Getters and setters used for keeping
		//track of whether the player has the key
		public function get hasKey():Boolean
		{
			return _hasKey;
		}
		public function set hasKey(keyState:Boolean)
		{
			_hasKey = keyState;
		}
	}
}