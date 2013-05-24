package de.mediadesign.gd1011.dreamcatcher.Processes
{
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	public class ActivePowerUpProcess
	{
		public static function update(deltaTime:Number):void
		{
			if (PowerUpTrigger.powerUpActive)
			{
				PowerUpTrigger.updateDuration(deltaTime);
			}

			if (PowerUpTrigger.healthIncreased)
			{
				PowerUpTrigger.updateHealthIncrease();
			}
		}
	}
}
