package  {
	
	import flash.display.MovieClip;
	
	
	public class Dungeon_Manager extends MovieClip {
		
		
		public function Dungeon_Manager() {
			// constructor code
		}
		
		public static function checkCollisionWithPlayer(wall:Wall, player:Player):void{
			if (player != null)
			{
				Collision.block(player, wall);
			}
		}
	}
	
}
