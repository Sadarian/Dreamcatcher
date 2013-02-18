package de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision
{
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import flash.geom.Point;

	public class CollisionUnidentical implements ICollision
	{
		public function checkCollision(entityA:Entity, entityB:Entity):Boolean
		{
			if (entityA.collisionMode == GameConstants.COLLISION_RECTANGLE)
				return Collision(entityA, entityB);
			else
				return Collision(entityB, entityA);
		}

		private static function Collision(rect:Entity, circle:Entity):Boolean {
			var radius:Number = circle.collisionValues.x;
			var rectX:Number = rect.collisionValues.x / 2;
			var rectY:Number = rect.collisionValues.y / 2;
			var rectPosition:Point = new Point(rect.position.x + rect.collisionPoint.x, rect.position.y + rect.collisionPoint.y);
			var circlePosition:Point = new Point(circle.position.x + circle.collisionPoint.x, circle.position.y + circle.collisionPoint.y);
			var distanceAB:Point = new Point(0,0);
			var distance:Number;
			var rectRad:Number;

			if (circlePosition.y == rectPosition.y)
				rectRad = rectX;
			else if (circlePosition.y < (rectPosition.y + rectY +1) && circlePosition.y > (rectPosition.y - rectY - 1))
			{
				rectY = rectPosition.y - circlePosition.y;
				rectRad = Math.sqrt((rectY*rectY) + (rectX*rectX));
			}
			else
				rectRad = Math.sqrt((rectX*rectX) + (rectY*rectY));

			distanceAB.x = (rectPosition.x - circlePosition.x);
			distanceAB.y = (rectPosition.y - circlePosition.y);
			distance = Math.sqrt((distanceAB.x*distanceAB.x) + (distanceAB.y*distanceAB.y));
            return (distance <= radius+rectRad);
		}
	}
}
