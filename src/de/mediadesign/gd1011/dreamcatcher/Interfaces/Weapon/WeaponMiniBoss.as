package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementWeb;

    import flash.geom.Point;

    public class WeaponMiniBoss implements IWeapon
    {
        private var _speed:Number = 0;
        private var sumTime:Number = 0;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function shoot(deltaTime:Number, position:Point, target:Object):void
        {
            sumTime += deltaTime;
            if(sumTime>=_speed)
            {
                sumTime -= _speed;
                var entity:Entity, targetPosition:Point;
                entity = EntityManager.entityManager.createEntity(GameConstants.MINIBOSS_BULLET_WEB, new Point(position.x - 70, position.y));
                targetPosition = (target != null)?new Point(target.x, target.y):new Point(0 , 0);
                (entity.movementSystem as MovementWeb).target = targetPosition;
                (entity.movementSystem as MovementWeb).calculateVelocity(position);
            }
        }

        public function increaseSpeed(multiplier:Number):void
        {
            _speed *= multiplier;
        }
    }
}
