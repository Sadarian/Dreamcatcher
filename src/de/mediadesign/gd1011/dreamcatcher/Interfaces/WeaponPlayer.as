package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import de.mediadesign.gd1011.dreamcatcher.Entity;
    import de.mediadesign.gd1011.dreamcatcher.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.GameStage;

	import flash.geom.Point;

    import starling.core.Starling;
    import starling.events.Touch;

    public class WeaponPlayer implements IWeapon
    {
        private static var _touch:Touch = null;

        private var _speed:Number = 0;
        private var sumTime:Number = 0;

        public static function set touch(touch:Touch):void
        {
            _touch = touch;
        }

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function shoot(deltaTime:Number, position:Point, target:Object):void
        {
            sumTime += 1000/deltaTime;
            if(sumTime>=_speed)
            {
                sumTime -= _speed;
                var temPosition:Point = new Point(position.x - -125, position.y - -33)
	            var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.PLAYER_BULLET, temPosition);
                (entity.movementSystem as MovementBullet).target = (_touch != null)?_touch.getLocation(Starling.current.stage):new Point(Starling.current.viewPort.width , position.y);
                (entity.movementSystem as MovementBullet).calculateVelocity(position);
                GameStage.gameStage.addChild(entity.movieClip);
            }
        }
    }
}
