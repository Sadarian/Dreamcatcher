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
                var animated:AnimatedModel = ((entity.movieClip as DisplayObjectContainer).getChildAt(0) as AnimatedModel);
                if(entity.health <= 0 && entity.name.search("Bullet") == -1 && animated.getActualAnimation().name.search("Die") == -1 && animated.getActualAnimation().name.search("Dead") == -1)
                {
                    animated.playAnimation(selectDieAnimation(animated.getActualAnimation(), entity.name));
                    //animated.getActualAnimation().addEventListener(Event.COMPLETE, test);
                    //function test():void
                   // {
                    //    GameStage.gameStage.removeActor(entity.movieClip);
                    //    entity.removeMovieClip();
                    //    manager.addUnusedEntity(entity);
                   // }
                }

				if (entity.position.x >= Starling.current.viewPort.width+entity.movieClip.width/2 || entity.position.x <0)
				{
					GameStage.gameStage.removeActor(entity.movieClip);
					entity.removeMovieClip();
                    manager.addUnusedEntity(entity);
				}
			}
		}

        private function selectDieAnimation(actualAnimation:MovieClip, type:String):String
        {
            switch (actualAnimation.name)
            {
                case(AnimatedModel.CLOSE_COMBAT):
                    return AnimatedModel.DIE_CLOSE_COMBAT;
                case(AnimatedModel.WALK):
                    if(type == GameConstants.ENEMY)
                        return AnimatedModel.DEAD_WALK;
                    else
                        return AnimatedModel.DIE;
                case(AnimatedModel.SHOOT):
                    if(type == GameConstants.ENEMY)
                        return AnimatedModel.DIE_SHOOT;
                    else
                        return AnimatedModel.DIE;
            }
            return null;
        }
	}
}
