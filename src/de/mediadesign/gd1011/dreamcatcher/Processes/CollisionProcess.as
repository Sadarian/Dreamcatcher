package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionUnidentical;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionIdentical;
    import de.mediadesign.gd1011.dreamcatcher.View.LifeBarHandling;

    public class CollisionProcess
	{
        private var manager:EntityManager;

		private var _collisionIdentical:CollisionIdentical;
		private var _collisionUnidentical:CollisionUnidentical;

		public function CollisionProcess()
		{
            manager = EntityManager.entityManager;
			_collisionIdentical = new CollisionIdentical();
			_collisionUnidentical = new CollisionUnidentical();
		}

		public function update():void
		{
			for each (var entityA:Entity in manager.entities)
			{
				for each (var entityB:Entity in manager.entities)
				{
					if (entityA != entityB && entityA.name != entityB.name)
					{
						if(entityA.collisionMode == entityB.collisionMode)
						{
							if (_collisionIdentical.checkCollision(entityA, entityB))
							{
                                MeleeCombat(entityA, entityB);

								rangeCombat(entityA, entityB);

								lifeBarUpdate();
							}
						}
						else
						{
							if (!(entityA.name.search(entityB.name) >= 0) && !(entityB.name.search(entityA.name) >= 0))
							{
								if (_collisionUnidentical.checkCollision(entityA, entityB))
								{
                                    MeleeCombat(entityA, entityB);

									rangeCombat(entityA, entityB);

									lifeBarUpdate()
								}
							}
						}
					}
				}
			}
		}

		private function lifeBarUpdate():void {
			for each (var lifeBar:LifeBarHandling in manager.lifeBars)
			{
				lifeBar.updateHealthBar();
			}
		}

	    private function rangeCombat(entityA:Entity, entityB:Entity):void
	    {
		    if (entityA.name.search(GameConstants.BULLET) >= 0 && !(entityB.name.search(GameConstants.BULLET) >= 0))
		    {
			    entityB.health = entityB.health - entityA.health;
			    entityA.health = 0;
		    }
		    else if(entityB.name.search(GameConstants.BULLET) >= 0 && !(entityA.name.search(GameConstants.BULLET) >= 0))
		    {
			    entityA.health = entityA.health - entityB.health;
			    entityB.health = 0;
		    }
	    }

        private function MeleeCombat(entityA:Entity, entityB:Entity):void
        {
            if(entityA.name == GameConstants.PLAYER && ((entityB.name == GameConstants.ENEMY) || (entityB.name == GameConstants.BOSS)))
            {
                entityA.health -= GameConstants.meleeDamage(entityB.name);
                entityB.health -= GameConstants.meleeDamage(entityA.name);
            }
            else if(entityB.name == GameConstants.PLAYER && ((entityA.name == GameConstants.ENEMY) || (entityA.name == GameConstants.BOSS)))
            {
                entityA.health -= GameConstants.meleeDamage(entityB.name);
                entityB.health -= GameConstants.meleeDamage(entityA.name);
            }
        }
	}
}
