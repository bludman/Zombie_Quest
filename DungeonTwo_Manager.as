package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class DungeonTwo_Manager extends MovieClip {
		
		
		public function DungeonTwo_Manager() {
			// constructor code
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
			//Remove the onEnterFrame event if
			//this object is removed from the stage
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		//Most of game logic is programmed into the
		//onEnterFrame event handler
		private function onEnterFrame(event:Event):void
		{
			//1. If the player is touching the key and
			//doesn't have it, pick it up
			if (player.hitTestObject(doorKey))
			{
				player.hasKey = true;
				player.addChild(doorKey);
				doorKey.x = 0;
				doorKey.y = 0;
				doorKey.rotation = 300;
			}
			
			//2. If the player is touching the door and has the
			//key, and the door is closed, then open the door. 
			//Otherwise, the door must block the player
			if (player.hitTestObject(door))
			{
				if (player.hasKey)
				{
					if(!door.isOpen)
					{
						door.isOpen = true;
						doorKey.visible = false;
					}
				}
				else
				{
					Collision.block(player, door);
				}
			}
			
			//3. If the enemies still exist on the stage,
			//check if the player is touching the 
			//enemies and reduce the player's health meter
			if(enemy != null)
			{
				if (player.hitTestObject(enemy.subObject.collisionArea))
				{
					enemy.subObject.stop();
					removeChild(enemy);
					enemy = null;
				}
			}
			
			
			//7.If the player reaches the exit, the game has been won
			//Display the Game Over screen
			if(player.hitTestPoint(exit.x, exit.y, true))
			{
				var gameOverWon:GameOver = new GameOver();
				gameOverWon.messageDisplay.text = "Game Over" + "\n" + "You Won!";
				if(enemy == null){
					gameOverWon.messageDisplay.appendText("\nTry not killing the human next time!");
				}
				parent.addChild(gameOverWon);
				parent.removeChild(this);

			}
		}
	}
	
}
