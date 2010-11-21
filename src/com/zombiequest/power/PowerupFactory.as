package com.zombiequest.power 
{
	/**
	 * ...
	 * @author Team Zombie Quest
	 */
	public class PowerupFactory 
	{
		private static const numPowerups:Number = 2;
		public function PowerupFactory() 
		{
			
		}
		public static function getPowerup():PowerEffect
		{
			var random:Number = Math.floor(Math.random() * numPowerups + 1);
			var powerup:PowerEffect = new DoubleDamage();
			switch(random)
			{
				case 1:
				powerup = new DoubleDamage();
				break;
				case 2:
				powerup = new DoubleSpeed();
				break;
			}
			return powerup;
		}
	}

}