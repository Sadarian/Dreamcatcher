/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 06.02.13
 * Time: 15:40
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
	import de.mediadesign.gd1011.dreamcatcher.Entity;
	import de.mediadesign.gd1011.dreamcatcher.EntityManager;

	public class IdenticalCollision implements ICollision
	{
		public function IdenticalCollision()
		{

		}

		public function checkCollision(entityA:Entity, entityB:Entity):Boolean
		{
			if (entityA.collisionMode == "Rectangle")
			{
				return checkCollisioRectangle(entityA, entityB)
			}
			return false;
		}

		private function checkCollisioRectangle(entityA:Entity, entityB:Entity):Boolean {
			return false;
		}
	}
}
