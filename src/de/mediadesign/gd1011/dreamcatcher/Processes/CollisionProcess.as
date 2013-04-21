package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionUnidentical;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionIdentical;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.LifeBarHandling;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	public class CollisionProcess
	{
        private var manager:EntityManager;

		public function CollisionProcess()
		{
            manager = EntityManager.entityManager;
		}

		public function update():void
		{
            var i:int = 0, j:int, entityA:Entity, entityB:Entity;
            for(i ; i < manager.entities.length ; i++)
                for(j = i+1 ; j < manager.entities.length ; j++)
				{
                    entityA = manager.entities[i];
                    entityB = manager.entities[j];
					if ((!(entityA.movementSystem is MovementBoss) || !(entityA.movementSystem as MovementBoss).onInit) &&
                        (!(entityB.movementSystem is MovementBoss) || !(entityB.movementSystem as MovementBoss).onInit) &&
                        (!(entityA.movementSystem is MovementVictim) || !(entityA.movementSystem as MovementVictim).onInit) &&
                        (!(entityB.movementSystem is MovementVictim) || !(entityB.movementSystem as MovementVictim).onInit))
					{
						if(entityA.collisionMode == entityB.collisionMode)
						{
							if (!(entityA.name.search(entityB.name) >= 0) && !(entityB.name.search(entityA.name) >= 0))
							{
								if (CollisionIdentical.checkCollision(entityA, entityB))
								{
									meleeCombat(entityA, entityB);

									if ((entityA.isPowershot || entityB.isPowershot) && !(entityA.isBullet || entityB.isBullet))
									{
										powershot(entityA, entityB);
									}

									lifeBarUpdate();
								}
							}
						}
						else
						{
                            if(entityA.collisionMode != entityB.collisionMode && entityA.collisionMode != null && entityB.collisionMode != null)
                            {
                                if (!(entityA.name.search(entityB.name) >= 0) && !(entityB.name.search(entityA.name) >= 0))
                                {
                                    if (CollisionUnidentical.checkCollision(entityA, entityB))
                                    {
                                        meleeCombat(entityA, entityB);

                                        pickUpPowerUp(entityA, entityB);

	                                    if ((entityA.isPowershot || entityB.isPowershot))
	                                    {
		                                    powershot(entityA, entityB);
	                                    }

                                        lifeBarUpdate()
                                    }
                                }
                            }
						}
					}
				}
		}

		private static function powershot(entityA:Entity, entityB:Entity):void
		{
			var tempHealth:Number;

			if (!entityA.isPowershot && entityA.health > 0)
			{
				entityA.blink(GameConstants.blinkAmount(entityA.name));
				showAnimation([entityA], true);

				tempHealth = entityA.health;
				entityA.health = entityA.health - entityB.health;
				entityB.health = entityB.health - tempHealth;
			}
			else if (!entityB.isPowershot && entityB.health > 0)
			{
				entityB.blink(GameConstants.blinkAmount(entityB.name));
				showAnimation([entityB], true);

				tempHealth = entityB.health;
				entityB.health = entityB.health - entityA.health;
				entityA.health = entityA.health - tempHealth;
			}

			trace("hit with powershot EntityA: " + entityA.name + " HP: " + entityA.health + " EntityB: " + entityB.name + " HP: " + entityB.health);
		}

	    private static function pickUpPowerUp(entityA:Entity, entityB:Entity):void
	    {
		    if (entityA.isPlayer && entityB.isPowerUp && entityB.health > 0)
		    {
				PowerUpTrigger.addPowerUp(entityB, entityA);
			    entityB.health = 0;
		    }
		    else if (entityB.isPlayer && entityA.isPowerUp && entityA.health > 0)
		    {
			    PowerUpTrigger.addPowerUp(entityA, entityB);
			    entityA.health = 0;
		    }
	    }

		private function lifeBarUpdate():void
		{
			for each (var lifeBar:LifeBarHandling in manager.lifeBars)
			{
				lifeBar.updateHealthBar();
			}
		}

        private static function rangeCombat(entityA:Entity, entityB:Entity):void
        {
	        if (!(entityA.isPowerUp || entityB.isPowerUp || entityA.isPowershot || entityB.isPowershot))
	        {
		        if (entityA.isBullet && entityA.health > 0 && !entityB.isBullet && (entityA.name.search(entityB.name) == -1)  && entityB.canBeAttacked)
	            {
                    entityB.blink(GameConstants.blinkAmount(entityB.name));
                    showAnimation([entityB], true);
	                entityB.health = entityB.health - entityA.health;
	                entityA.health = 0;
	            }
	            else
                    if(entityB.isBullet && entityB.health > 0 && !entityA.isBullet && (entityB.name.search(entityA.name) == -1)  && entityA.canBeAttacked)
                    {
                        entityA.blink(GameConstants.blinkAmount(entityA.name));
                        showAnimation([entityA], true);
                        entityA.health = entityA.health - entityB.health;
                        entityB.health = 0;
                    }
	        }
        }

        private static function meleeCombat(entityA:Entity, entityB:Entity):void
        {
            if(entityA.isPlayer && entityB.isHostile && entityB.canBeAttacked)
            {
                if(entityB.canAttack && entityA.canBeAttacked)
                {
                    entityA.blink(GameConstants.blinkAmount(entityA.name));
                    entityA.health -= GameConstants.meleeDamage(entityB.name);
                }
                if(entityA.canAttack && (!entityB.isBoss1 || entityA.getAnimatedModel(0).ActualAnimation.name == AnimatedModel.CLOSE_COMBAT))
                {
                    entityB.blink(GameConstants.blinkAmount(entityB.name));
                    entityB.health -= GameConstants.meleeDamage(entityA.name);
                }
                showAnimation([entityA, entityB], false);
            }
            else
                if(entityB.isPlayer && entityA.isHostile  && entityA.canBeAttacked)
                {
                    if(entityB.canAttack && (!entityA.isBoss1 || entityB.getAnimatedModel(0).ActualAnimation.name == AnimatedModel.CLOSE_COMBAT))
                    {
                        entityA.blink(GameConstants.blinkAmount(entityA.name));
                        entityA.health -= GameConstants.meleeDamage(entityB.name);
                    }
                    if(entityA.canAttack && entityB.canBeAttacked)
                    {
                        entityB.blink(GameConstants.blinkAmount(entityB.name));
                        entityB.health -= GameConstants.meleeDamage(entityA.name);
                    }
                    showAnimation([entityB, entityA], false);
                }
                else
                    rangeCombat(entityA, entityB);
        }

        private static function showAnimation(entities:Array, distance:Boolean):void
        {
            for each (var entity:Entity in entities)
            {
                if(entity.isEnemy)
                    if(distance)
                        entity.playAnimation(AnimatedModel.HIT);
                    else
                        entity.playAnimation(AnimatedModel.DIE_CLOSE_COMBAT);

                if(entity.isBoss1)
                    if(!distance)
                        (entity.movementSystem as MovementBoss).switchTo(MovementBoss.MELEE_TO_RANGE);

                if(entity.isCharger)
                    if(!distance)
                        entity.playAnimation(AnimatedModel.DIE_CLOSE_COMBAT);

                if(entity.isVictim)
                    entity.playAnimation(AnimatedModel.DIE);

                if(entity.isPlayer)
                    if(distance)
                        entity.playAnimation(AnimatedModel.HIT);
                    else
                        entity.playAnimation(AnimatedModel.CLOSE_COMBAT);
            }
        }
	}
}
