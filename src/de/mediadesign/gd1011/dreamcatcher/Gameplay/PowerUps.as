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
			var dropChance:Number;

			if(entity.isEnemy)
			{
				dropChance = (Math.floor(Math.random() * ((GameConstants.dropChanceFireRateEnemy - 1) + 1) + 1));

				if (dropChance == GameConstants.dropChanceFireRateEnemy)
					dropFireRate(entity);

				if (Game.currentLvl >= 2) {
					dropChance = (Math.floor(Math.random() * ((GameConstants.dropChanceFreezeEnemy - 1) + 1) + 1));
					if (dropChance == GameConstants.dropChanceFreezeEnemy)
						dropFreeze(entity);
				}
			}
			else if (entity.isCharger)
			{
				dropChance = (Math.floor(Math.random() * ((GameConstants.dropChanceFireRateSpecial - 1) + 1) + 1));

				if (dropChance == GameConstants.dropChanceFireRateSpecial)
					dropFireRate(entity);

				dropChance = (Math.floor(Math.random() * ((GameConstants.dropChanceFreezeSpecial - 1) + 1) + 1));
				if (dropChance == GameConstants.dropChanceFreezeSpecial)
					dropFreeze(entity);
			}
			else if(entity.isVictim)
				dropHealth(entity);
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
