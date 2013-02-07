/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 04.02.13
 * Time: 13:11
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher
{
	public class MoveProcess
	{
		private var entityManager:EntityManager;
		public function MoveProcess(entityManager:EntityManager) {
			this.entityManager = entityManager;
		}
		public function update(deltaTime:Number):void
        {
			for each (var entity:Entity in entityManager.entities);
                entity.move(deltaTime);
		}
	}
}
