package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

    import flash.events.Event;

    import starling.core.Starling;
    import starling.display.DisplayObjectContainer;
    import starling.display.MovieClip;

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
                if(entity.health <= 0 && (entity.isBullet || entity.isBoss1 || entity.isPowerUp || entity.isCharger))
                {
                    if(!(entity.name == GameConstants.PLAYER_BULLET) && !entity.isCharger)
                    {
                        GameStage.gameStage.removeActor(entity.movieClip);
                        entity.removeMovieClip();
                        manager.addUnusedEntity(entity);
                    }
                    else
                        entity.playAnimation(AnimatedModel.DIE);
                }
                else
                    if (entity.position.x >= (Starling.current.viewPort.width*1.1)+entity.movieClip.width/2 || entity.position.x <0-entity.movieClip.width/2)
                    {
                        GameStage.gameStage.removeActor(entity.movieClip);
                        entity.removeMovieClip();
                        manager.addUnusedEntity(entity);
                    }
			}
		}
	}
}
