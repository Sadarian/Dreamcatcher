package de.mediadesign.gd1011.dreamcatcher {
	public class Collision
	{
		private var entityManager:EntityManager;

		public function Collision(entityManager:EntityManager)
		{
			this.entityManager = entityManager;
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

						}
					}
				}
			}
		}
	}
}
