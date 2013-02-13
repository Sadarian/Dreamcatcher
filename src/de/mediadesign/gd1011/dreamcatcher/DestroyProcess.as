/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 11.02.13
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {
	import de.mediadesign.gd1011.dreamcatcher.GameStage;

	public class DestroyProcess {
		private var entityManager:EntityManager;
		public function DestroyProcess(entityManager:EntityManager)
		{
			this.entityManager = entityManager;
		}

		public function update():void
		{
			for each (var entity:Entity in entityManager.entities)
			{
				if (entity.health <= 0 || entity.position.x >= 1350 || entity.position.x <0)
				{
					GameStage.gameStage.removeActor(entity.movieClip);
					entity.removeMoviclip();
					entityManager.addUnusedEntity(entity);
				}
			}
		}
	}
}
