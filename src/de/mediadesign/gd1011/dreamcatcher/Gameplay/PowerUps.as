/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 20.02.13
 * Time: 13:20
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;

	import flash.geom.Point;

	public class PowerUps
	{
		public function PowerUps()
		{

		}

		public static function checkDrop(entity:Entity):void
		{
			if (entity.health <= 0)
			{
				switch (entity.name)
				{
					case GameConstants.ENEMY:
					{
						var dropChance:Number = (Math.floor(Math.random() * ((GameConstants.dropChanceFireRateEnemy - 1) + 1) + 1));

						if (dropChance == GameConstants.dropChanceFireRateEnemy)
						{
							dropFireRate(entity);
							break;
						}

						if (Game.currentLvl >= 2) {
							dropChance = (Math.floor(Math.random() * ((GameConstants.dropChanceFreezeEnemy - 1) + 1) + 1));

							if (dropChance == GameConstants.dropChanceFreezeEnemy) {
								dropFreeze(entity);
								break;
							}
						}
						break;
					}

					case GameConstants.VICTIM:
					{
						dropHealth(entity);
						break;
					}
				}
			}
		}
		private static function dropFireRate(entity:Entity):void
		{
			EntityManager.entityManager.createEntity(GameConstants.POWERUP_FIRE_RATE, (new Point(entity.position.x + GameConstants.dropDistance, entity.position.y)));
		}

		private static function dropFreeze(entity:Entity):void
		{
			EntityManager.entityManager.createEntity(GameConstants.POWERUP_FREEZE, (new Point(entity.position.x + GameConstants.dropDistance, entity.position.y)));
		}

		private static function dropHealth(entity:Entity):void
		{
			EntityManager.entityManager.createEntity(GameConstants.POWERUP_HEALTH, (new Point(entity.position.x + GameConstants.dropDistance, entity.position.y)))
		}
	}
}
