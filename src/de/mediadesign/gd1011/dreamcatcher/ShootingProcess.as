package de.mediadesign.gd1011.dreamcatcher
{
	public class ShootingProcess
	{
        private var manager:EntityManager;

        public function ShootingProcess(manager:EntityManager):void
        {
            this.manager = manager
        }

		public function update(deltaTime:Number):void
		{
            for each (var entity:Entity in manager.entities)
                entity.shoot(deltaTime);
		}
	}
}
