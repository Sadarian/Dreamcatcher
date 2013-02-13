package de.mediadesign.gd1011.dreamcatcher {
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.DifferentialCollision;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IdenticalCollision;

	public class Collision
	{
		private var entityManager:EntityManager;
		private var identicalCollision:IdenticalCollision;
		private var differentailCollision:DifferentialCollision;

		public function Collision(entityManager:EntityManager)
		{
			this.entityManager = entityManager;
			identicalCollision = new IdenticalCollision();
			differentailCollision = new DifferentialCollision();
		}

		public function update():void
		{
			for each (var entityA:Entity in entityManager.entities)
			{
				for each (var entityB:Entity in entityManager.entities)
				{
					if (entityA != entityB)
					{
						if(entityA.collisionMode == entityB.collisionMode)
						{
							if (identicalCollision.checkCollision(entityA, entityB))
							{
								if (entityA.name.search(GameConstants.BULLET) >= 0)
								{
									entityB.health = entityB.health - entityA.health;
									entityA.health = 0;
								}
								else if(entityB.name.search(GameConstants.BULLET) >= 0)
								{
									entityA.health = entityA.health - entityB.health;
									entityB.health = 0;
								}
							}
						}
						else
						{
							if (!(entityA.name.search(entityB.name) >= 0) && !(entityB.name.search(entityA.name) >= 0))
							{
								if (differentailCollision.checkCollision(entityA, entityB))
								{
									if (entityA.name.search(GameConstants.BULLET) >= 0)
									{
										entityB.health = entityB.health - entityA.health;
										entityA.health = 0;
									}
									else if(entityB.name.search(GameConstants.BULLET) >= 0)
									{
										entityA.health = entityA.health - entityB.health;
										entityB.health = 0;
									}
									trace(entityA.name + " " + entityA.health + " " + entityB.name + " " + entityB.health);
								}
							}
						}
					}
				}
			}
		}
	}
}
