package de.mediadesign.gd1011.dreamcatcher
{
	public class MoveProcess
	{
        private var manager:EntityManager;

        public function MoveProcess(manager:EntityManager):void
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
