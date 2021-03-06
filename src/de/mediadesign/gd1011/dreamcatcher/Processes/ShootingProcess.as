package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;

    public class ShootingProcess
	{
        private var manager:EntityManager;

        public function ShootingProcess():void
        {
            manager = EntityManager.entityManager;
        }

		public function update(deltaTime:Number):void
		{
            for each (var entity:Entity in manager.entities)
                entity.shoot(deltaTime);
		}
	}
}
