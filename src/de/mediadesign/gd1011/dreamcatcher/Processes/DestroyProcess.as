package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import starling.core.Starling;

    public class DestroyProcess
    {
        private var manager:EntityManager;

        public function DestroyProcess():void
        {
            manager = EntityManager.entityManager;
        }

		public function update():void
		{
			for each (var entity:Entity in manager.entities)
			{
				if (entity.health <= 0 || entity.position.x >= Starling.current.viewPort.width+entity.movieClip.width/2 || entity.position.x <0)
				{
					GameStage.gameStage.removeActor(entity.movieClip);
					entity.removeMovieClip();
                    manager.addUnusedEntity(entity);
				}
			}
		}
	}
}
