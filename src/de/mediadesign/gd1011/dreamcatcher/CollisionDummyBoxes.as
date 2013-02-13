/**
 * Created with IntelliJ IDEA.
 * User: tofrey
 * Date: 12.02.13
 * Time: 08:54
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.dreamcatcher {

	import flash.geom.Point;


	public class CollisionDummyBoxes {
		private static var dummies:Vector.<CollisionImage> = new Vector.<CollisionImage>();

		public function CollisionDummyBoxes() {

		}

		private static function createRect(x:Number, y:Number, name:String):CollisionImage {
			var temRect:CollisionImage = new CollisionImage(AssetsLoader.getTexture("Quad"),name);
			temRect.scaleX = x/100;
			temRect.scaleY = y/100;
			return temRect;
		}

		private static function createCircle(x:Number, name:String):CollisionImage {
			var temCircle:CollisionImage = new CollisionImage(AssetsLoader.getTexture("Circle"), name)
			temCircle.scaleX = x/100;
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
			
			dummies.push(image);
			image.x = entityPosition.x - entityCollisionValues.x - entity.collisionPoint.x;
			image.y = entityPosition.y - entityCollisionValues.y - entity.collisionPoint.y;
			return image;
		}

		public static function update():void {
			for each (var dummyImage:CollisionImage in dummies) {
				for each (var entity:Entity in EntityManager.entityManager.entities) {
					if (dummyImage.entityName == entity.name) {
						dummyImage.x = entity.position.x - entity.collisionValues.x - entity.collisionPoint.x;
						dummyImage.y = entity.position.y - entity.collisionValues.y - entity.collisionPoint.y;
					}
				}
			}
		}
	}
}
