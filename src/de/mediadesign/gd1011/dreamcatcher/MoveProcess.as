package de.mediadesign.gd1011.dreamcatcher
{
	public class MoveProcess
	{

        public function MoveProcess():void
		{
        }

        public function update(deltaTime:Number):void
        {
            for each (var entity:Entity in EntityManager.entityManager.entities)
                entity.move(deltaTime);
		}
	}
}
