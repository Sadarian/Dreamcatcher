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
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;

	import flash.geom.Point;

	public class DifferentialCollision implements ICollision
	{
		public function DifferentialCollision()
		{

		}

		public function checkCollision(entityA:Entity, entityB:Entity):Boolean
		{
			if (entityA.collisionMode == GameConstants.COLLISION_RECTANGLE)
			{
				return Collision(entityA, entityB)
			}
			else
			{
				return Collision(entityB, entityA)
			}

		}

		private function Collision(rect:Entity, circle:Entity):Boolean {
			var radius:Number = circle.collisionValues.x;
			var rectX:Number = rect.collisionValues.x / 2;
			var rectY:Number = rect.collisionValues.y / 2;
			var rectPosition:Point = rect.position;
			var circlePosition:Point = circle.position;
			var distanceAB:Point = new Point(0,0);
			var distance:Number;
			var recrad:Number;

			if (circlePosition.y == rectPosition.y)
			{
				recrad = rectX;
			}
			else if (circlePosition.y < (rectPosition.y + rectY +1) && circlePosition.y > (rectPosition.y - rectY - 1))
			{
				rectY = rectPosition.y - circlePosition.y;
				recrad = Math.sqrt((rectY*rectY) + (rectX*rectX));
			}
			else
			{
				recrad = Math.sqrt((rectX*rectX) + (rectY*rectY));
			}

			distanceAB.x = (rectPosition.x - circlePosition.x);
			distanceAB.y = (rectPosition.y - circlePosition.y);
			distance = Math.sqrt((distanceAB.x*distanceAB.x) + (distanceAB.y*distanceAB.y));

			if (distance <= radius+recrad)
			{
				return true;
			}
			return false;
		}
	}
}
