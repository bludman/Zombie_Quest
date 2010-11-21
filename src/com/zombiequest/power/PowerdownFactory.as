package com.zombiequest.power 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class PowerdownFactory 
	{
		private var numPowerdowns:Number = 2;
		public function PowerdownFactory() 
		{
			
		}
		public static function getPowerdown():PowerEffect
		{
			var random:Number = Math.floor(Math.random() * numPowerdowns + 1);
			switch(random)
			{
				case 1:
				powerup = new HalfSpeed();
				break;
				default:
				powerup = new HalfSpeed();
				break;
			}
			return powerup;
		}
		
		
		
	}

}