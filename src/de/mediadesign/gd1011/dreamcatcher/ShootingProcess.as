package de.mediadesign.gd1011.dreamcatcher
{
	public class ShootingProcess
	{
<<<<<<< HEAD
		private var entityManager:EntityManager;

		public function ShootingProcess(entityManager:EntityManager)
		{
			this.entityManager = entityManager;
		}
=======
        private var manager:EntityManager;

        public function ShootingProcess(manager:EntityManager):void
        {
            this.manager = manager
        }
>>>>>>> feature/shooting

		public function update(deltaTime:Number):void
		{
            for each (var entity:Entity in manager.entities)
                entity.shoot(deltaTime);
		}
	}
}
