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
								trace("Hell Yeah!");
							}
						}
						else
						{
							if (differentailCollision.checkCollision(entityA, entityB))
							{
								trace("Yeeeeeeeha!!");
							}
						}
					}
				}
			}
		}
	}
}
