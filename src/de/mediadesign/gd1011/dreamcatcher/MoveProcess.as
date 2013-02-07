package de.mediadesign.gd1011.dreamcatcher
{
	public class MoveProcess
	{
<<<<<<< HEAD
		private var entityManager:EntityManager;
		public function MoveProcess(entityManager:EntityManager) {
			this.entityManager = entityManager;
		}
		public function update(deltaTime:Number):void
=======
        private var manager:EntityManager;

        public function MoveProcess(manager:EntityManager):void
>>>>>>> feature/shooting
        {
            this.manager = manager
        }

        public function update(deltaTime:Number):void
        {
            for each (var entity:Entity in manager.entities)
                entity.move(deltaTime);
		}
	}
}
