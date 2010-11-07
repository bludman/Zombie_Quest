package 
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Wall extends MovieClip
	{
		public function Wall()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		private function onAddedToStage(event:Event):void
		{
			//Add event listeners
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		private function onRemovedFromStage(event:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		//Each frame of the wall objects send references of themselves to the
		//DungeonOne_Manager (the "parent") to be checked for a collision
		//with the player
		private function onEnterFrame(event:Event):void
		{
			Dungeon_Manager.checkCollisionWithPlayer(this, MovieClip(parent).player);
		}
	}
}