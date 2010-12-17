package com.zombiequest
{
	import org.flixel.FlxSprite;

	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class MapGenerator 
	{		
		[Embed(source = "../../../assets/png/level12.png")]
		protected static var Background:Class;
		
		public function MapGenerator() 
		{
			var bG:FlxSprite = new FlxSprite(0, 0, Background);
			StartLevelState.mapGroup.add(bG);
			makeColliders();
		}
		
	    private function makeColliders():void
		{
			var topCollider:Collider = new Collider(0, -10, 1280, 11);
			StartLevelState.mapCollider.add(topCollider);
			
			var bottomCollider:Collider = new Collider(0, 1023, 1280, 11);
			StartLevelState.mapCollider.add(bottomCollider);
			
			var leftCollider:Collider = new Collider(-10, 0, 11, 1024);
			StartLevelState.mapCollider.add(leftCollider);
			
			var rightCollider:Collider = new Collider(1279, 0, 11, 1024);
			StartLevelState.mapCollider.add(rightCollider);
			
			var leftUpCollider:Collider = new Collider(0, 0, 313, 189);
			StartLevelState.mapCollider.add(leftUpCollider);
			
			var rightUpCollider:Collider = new Collider(958, 0, 322, 195);
			StartLevelState.mapCollider.add(rightUpCollider);
			
			var leftDownCollider:Collider = new Collider(0, 833, 313, 189);
			StartLevelState.mapCollider.add(leftDownCollider);
			
			var rightDownCollider:Collider = new Collider(958, 833, 322, 195);
			StartLevelState.mapCollider.add(rightDownCollider);
			
			var car1Collider:Collider = new Collider(829, 50, 137, 48);
			StartLevelState.mapCollider.add(car1Collider);
			
			var car2Collider:Collider = new Collider(373, 210, 69, 144);
			StartLevelState.mapCollider.add(car2Collider);
			
			var busCollider:Collider = new Collider(570, 300, 400, 100);
			StartLevelState.mapCollider.add(busCollider);
			
			var car3Collider:Collider = new Collider(780, 484, 70, 130);
			StartLevelState.mapCollider.add(car3Collider);
			
			var car4Collider:Collider = new Collider(33, 180, 70, 138);
			StartLevelState.mapCollider.add(car4Collider);
			
			var car5Collider:Collider = new Collider(0, 586, 100, 87);
			StartLevelState.mapCollider.add(car5Collider);
			
			var car6Collider:Collider = new Collider(334, 691, 136, 83);
			StartLevelState.mapCollider.add(car6Collider);
			
			var car7Collider:Collider = new Collider(405, 932, 147, 91);
			StartLevelState.mapCollider.add(car7Collider);
			
			var car8Collider:Collider = new Collider(1187, 182, 75, 122);
			StartLevelState.mapCollider.add(car8Collider);
			
			var car9Collider:Collider = new Collider(1165, 727, 95, 118);
			StartLevelState.mapCollider.add(car9Collider);
			
			var roadBlock1:Collider = new Collider(530, 520, 1, 1, 0, true);
			StartLevelState.mapCollider.add(roadBlock1);
			roadBlock1.facing = FlxSprite.LEFT;
		}
	}
}