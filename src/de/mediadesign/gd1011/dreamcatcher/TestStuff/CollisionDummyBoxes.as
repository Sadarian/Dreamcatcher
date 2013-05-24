package de.mediadesign.gd1011.dreamcatcher.TestStuff
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import flash.geom.Point;

	public class CollisionDummyBoxes
    {
		private static var _dummies:Vector.<CollisionImage> = new Vector.<CollisionImage>();

		public function CollisionDummyBoxes() {

		}

		private static function createRect(x:Number, y:Number, name:String):CollisionImage {
			var temRect:CollisionImage = new CollisionImage(GraphicsManager.graphicsManager.getTexture("Quad"),name);
			temRect.scaleX = x/100;
			temRect.scaleY = y/100;
			return temRect;
		}

		private static function createCircle(x:Number, name:String):CollisionImage {
			var temCircle:CollisionImage = new CollisionImage(GraphicsManager.graphicsManager.getTexture("Circle"), name);
			temCircle.scaleX = x/100;
			//noinspection JSSuspiciousNameCombination
            temCircle.scaleY = temCircle.scaleX;
			return temCircle;
		}

		public static function getDummy(entity:Entity):CollisionImage {
			var entityPosition:Point = entity.position;
			var entityCollisionValues:Point = entity.collisionValues;
			var image:CollisionImage;
			if (entity.collisionMode == GameConstants.COLLISION_RECTANGLE) {
				image = createRect(entityCollisionValues.x*2, entityCollisionValues.y*2, entity.name);

			}else{
				image = createCircle(entityCollisionValues.x*2, entity.name);
			}
			var position:Point = new Point(entityPosition.x - entityCollisionValues.x + entity.collisionPoint.x, entityPosition.y - entityCollisionValues.y + entity.collisionPoint.y);

			image.x = position.x;
			image.y = position.y;

			_dummies.push(image);
			return image;
		}

		public static function update():void {
			for each (var dummyImage:CollisionImage in _dummies) {
				for each (var entity:Entity in EntityManager.entityManager.entities) {
					if (dummyImage.entityName == entity.name) {
						dummyImage.x = entity.position.x - entity.collisionValues.x + entity.collisionPoint.x;
						dummyImage.y = entity.position.y - entity.collisionValues.y + entity.collisionPoint.y;
					}
				}
			}
		}

		public static function get dummies():Vector.<CollisionImage> {
			return _dummies;
		}
	}
}
