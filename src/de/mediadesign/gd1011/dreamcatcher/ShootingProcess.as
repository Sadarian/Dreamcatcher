package de.mediadesign.gd1011.dreamcatcher
{

	public class ShootingProcess
	{

        public function ShootingProcess():void
        {
        }

		public function update(deltaTime:Number):void
		{
            for each (var entity:Entity in EntityManager.entityManager.entities)
                entity.shoot(deltaTime);
		}
	}
}
