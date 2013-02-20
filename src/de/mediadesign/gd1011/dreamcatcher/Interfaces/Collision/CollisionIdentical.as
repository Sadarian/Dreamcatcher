package de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision
{
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class CollisionIdentical
	{
		public static function checkCollision(entityA:Entity, entityB:Entity):Boolean
		{
			if (entityA.collisionMode == GameConstants.COLLISION_RECTANGLE)
				return checkCollisionRectangle(entityA, entityB);
			else
				return checkCollisionCircle(entityA, entityB);
		}

		private static function checkCollisionRectangle(entityA:Entity, entityB:Entity):Boolean
        {
			var collisionRectangleA:Rectangle = createRectangle(entityA);
			var collisionRectangleB:Rectangle = createRectangle(entityB);
			return collisionRectangleA.intersects(collisionRectangleB);
		}

		private static function createRectangle(entity:Entity):Rectangle
        {
			return (new Rectangle((entity.position.x + entity.collisionPoint.x - entity.collisionValues.x),
								  (entity.position.y + entity.collisionPoint.y - entity.collisionValues.y),
                                   entity.collisionValues.x * 2,
                                   entity.collisionValues.y * 2));
		}

		private static function checkCollisionCircle(entityA:Entity, entityB:Entity):Boolean
        {
			var distanceAB:Point = new Point(0, 0);
			var distance:Number;
	        distanceAB.x = ((entityA.position.x + entityA.collisionPoint.x) - (entityB.position.x + entityB.collisionPoint.x));
	        distanceAB.y = ((entityA.position.y + entityA.collisionPoint.y) - (entityB.position.y + entityB.collisionPoint.y));
			distance = Math.sqrt(((distanceAB.x*distanceAB.x)+(distanceAB.y*distanceAB.y)));
            return (distance <= (entityA.collisionValues.x + entityB.collisionValues.x));
		}
	}
}
