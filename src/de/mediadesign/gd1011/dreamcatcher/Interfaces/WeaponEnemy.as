package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import de.mediadesign.gd1011.dreamcatcher.Entity;
    import de.mediadesign.gd1011.dreamcatcher.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;

    import flash.geom.Point;

    import starling.core.Starling;

    public class WeaponEnemy implements IWeapon
    {
        private var _speed:Number = 0;
        private var sumTime:Number = 0;

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
                var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.BULLET, position);
                (entity.movementSystem as MovementBullet).target = (target != null)?new Point(target.x, target.y):new Point(0 , position.y);
                (entity.movementSystem as MovementBullet).calculateVelocity(position);
                Starling.current.stage.addChild(entity.movieClip);
            }
        }
    }
}
