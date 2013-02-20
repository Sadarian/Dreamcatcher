/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 20.02.13
 * Time: 13:20
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.Gameplay.PowerUps
{
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;

	import flash.geom.Point;

	public class PowerUps
	{
		public function PowerUps()
		{

		}

		public static function checkDrop(entity:Entity):void {
			switch (entity.name) {
				case GameConstants.ENEMY:
				{
					var dropChance:Number = (Math.floor(Math.random()*((GameConstants.dropChanceFireRateEnemy - 1) +1) + 1));

					if (dropChance == GameConstants.dropChanceFireRateEnemy)
					{
						trace("drop fire rate");
						dropFireRate(entity);
						break;
					}

					dropChance = (Math.floor(Math.random()*((GameConstants.dropChanceFreezeEnemy - 1) +1) + 1));

					if (dropChance == GameConstants.dropChanceFreezeEnemy)
					{
						trace("drop freeze");
						dropFreeze();
						break;
					}
					break;
				}

				case GameConstants.VICTIM:
				{
					dropHealth();
					break;
				}
			}
		}
		private static function dropFireRate(entity:Entity):void
		{
			EntityManager.entityManager.createEntity(GameConstants.POWERUP_FIRE_RATE, entity.position.add(new Point(GameConstants.dropDistance, 0)));
		}

		private static function dropFreeze():void
		{

		}

		private static function dropHealth():void
		{

		}
	}
}
