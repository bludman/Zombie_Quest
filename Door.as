package 
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;

	public class Door extends MovieClip
	{
		private var _isOpen:Boolean;
		private var _chimes:Chimes;
		private var _soundChannel:SoundChannel

		public function Door()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			_isOpen = false;
			_chimes = new Chimes();
			_soundChannel = new SoundChannel();
			visible = true;
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		//Getters and setters
		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		public function set isOpen(doorState:Boolean)
		{
			_isOpen = doorState;
			if(_isOpen)
			{
				_soundChannel = _chimes.play();
				visible = false;
			}
			else
			{
				visible = true;
			}
		}
	}
}