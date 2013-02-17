package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;

    public class MoveProcess
	{
        private var manager:EntityManager;

        public function MoveProcess():void
		{
            manager = EntityManager.entityManager;
        }

        public function update(deltaTime:Number):void
        {
            for each (var entity:Entity in manager.entities)
                entity.move(deltaTime);
		}
	}
}
