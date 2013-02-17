package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;

    public class RenderProcess
    {
        private var manager:EntityManager;

        public function RenderProcess():void
        {
            manager = EntityManager.entityManager;
        }

        public function update():void
        {
            for each (var entity:Entity in manager.entities)
				entity.render();
		}
	}
}
