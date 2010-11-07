package 
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;

	public class Weapon extends MovieClip
	{
		private var _isArmed:Boolean;
		
		public function Weapon()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			_isArmed = false;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage)
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		private function onKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.SPACE)
			{
				shootBullet();
			}
		}
		private function shootBullet():void
		{
			if (_isArmed)
			{
				parent.addChild(new Bullet());
			}
		}
		private function onEnterFrame(event:Event):void
		{
			rotation += 2;
		}
		//Getters and setters
		public function get isArmed():Boolean
		{
			return _isArmed;
		}
		public function set isArmed(weaponState:Boolean)
		{
			_isArmed = weaponState;
		}
	}
}