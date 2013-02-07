/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 04.02.13
 * Time: 13:11
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {
	public class RenderProcess
	{
		private var entityManager:EntityManager;

		public function RenderProcess(entityManager:EntityManager)
		{
			this.entityManager = entityManager;
		}

		public function update():void
		{
			var entities:Vector.<Entity> = entityManager.entities

			for each (var entity:Entity in entities)
			{
				entity.render();
			}
		}
	}
}
