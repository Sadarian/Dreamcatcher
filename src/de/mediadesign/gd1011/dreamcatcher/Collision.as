package de.mediadesign.gd1011.dreamcatcher {
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IdenticalCollision;

	public class Collision
	{
		private var entityManager:EntityManager;
		private var identicalCollision:IdenticalCollision;

		public function Collision(entityManager:EntityManager)
		{
			this.entityManager = entityManager;
			identicalCollision = new IdenticalCollision()
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
								trace("Hell Yeah!")
							}
						}
					}
				}
			}
		}
	}
}
