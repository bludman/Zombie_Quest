package com.zombiequest.power 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class PowerdownFactory 
	{
		private static var numPowerdowns:Number = 2;
		public function PowerdownFactory() 
		{
			
		}
		public static function getPowerdown():PowerEffect
		{
			var random:Number = Math.floor(Math.random() * numPowerdowns + 1);
			var powerup:PowerEffect;
			switch(random)
			{
				case 1:
				powerup = new HalfSpeed();
				break;
				case 2:
				powerup = new LimitedVision();
				default:
				powerup = new HalfSpeed();
				break;
			}
			return powerup;
		}
		
		
		
	}

}