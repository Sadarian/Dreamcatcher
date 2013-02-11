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
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class IdenticalCollision implements ICollision
	{
		public function IdenticalCollision()
		{

		}

		public function checkCollision(entityA:Entity, entityB:Entity):Boolean
		{
			if (entityA.collisionMode == GameConstants.COLLISION_RECTANGLE)
			{

				return checkCollisionRectangle(entityA, entityB)
			}
			else
			{
				return checkCollisionCircle(entityA, entityB)
			}

		}

		private function checkCollisionRectangle(entityA:Entity, entityB:Entity):Boolean {
			var collisionRectangleA:Rectangle = createRectangle(entityA);
			var collisionRectangleB:Rectangle = createRectangle(entityB);
			return collisionRectangleA.intersects(collisionRectangleB);
		}

		private function createRectangle(entity:Entity):Rectangle {
			var rect:Rectangle;
			rect = new Rectangle((entity.position.x - entity.collisionPoint.x),
								 (entity.position.y - entity.collisionPoint.y),
								  entity.collisionValues.x * 2,
								  entity.collisionValues.y * 2)
			return rect;
		}

		private function checkCollisionCircle(entityA:Entity, entityB:Entity):Boolean {
			var distanceAB:Point = new Point(0, 0);
			var distance:Number;
			distanceAB.x = (entityA.position.x - entityB.position.x);
			distanceAB.y = (entityA.position.y - entityB.position.y);
			distance = Math.sqrt(((distanceAB.x*distanceAB.x)+(distanceAB.y*distanceAB.y)));
			if (distance <= (entityA.collisionValues.x + entityB.collisionValues.x))
			{
				return true;
			}
			return false;
		}
	}
}
