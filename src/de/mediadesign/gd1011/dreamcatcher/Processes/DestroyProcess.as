package de.mediadesign.gd1011.dreamcatcher.Processes
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EndlessMode;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.Score;

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
                if(entity.health <= 0 && (entity.isBullet || entity.isBoss1 || entity.isPowerUp || entity.isCharger || entity.isPowerShot || entity.isMiniBoss))
                {
                    if(!(entity.name == GameConstants.PLAYER_BULLET) && !entity.isCharger && !entity.isMiniBoss)
                    {
                        if(checkForWeb(entity, true)) return;
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
                        if(entity.isHostile && EndlessMode.hasInstance && entity.position.x < 0-entity.movieClip.width/2 && entity.health > 0)
                            Score.updateMultiplier();
                        checkForWeb(entity, false);
                        GameStage.gameStage.removeActor(entity.movieClip);
                        entity.removeMovieClip();
                        manager.addUnusedEntity(entity);
                    }
			}
		}

        private function checkForWeb(entity:Entity, died:Boolean):Boolean
        {
            if(entity.name == GameConstants.BOSS2_BULLET_WEB)
            {
                if(manager.getEntity(GameConstants.BOSS2) && manager.getEntity(GameConstants.BOSS2).movementSystem)
                    (manager.getEntity(GameConstants.BOSS2).movementSystem as MovementBoss).canMove = true;
                if(died && entity.movementSystem != null)
                {
                    entity.switchMovement(null);
                    manager.getEntity(GameConstants.PLAYER).increaseMovementSpeed(GameConstants.bossWebSlow);
                    Starling.juggler.delayCall(resetSlow, 2);
                    return false;
                    function resetSlow():void
                    {
                        manager.getEntity(GameConstants.PLAYER).setMovementSpeed();
                    }
                }
                return false;
            }
            else
                return false;
        }
	}
}
