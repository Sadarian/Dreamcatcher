package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
    import flash.geom.Point;

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
            sumTime += deltaTime;
            if(sumTime>=_speed)
            {
                sumTime -= _speed;
                var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.ENEMY_BULLET, position);
	            var targetPosition:Point = (target != null)?new Point(target.x, target.y):new Point(0 , 0);
			    (entity.movementSystem as MovementBullet).target = targetPosition;
                (entity.movementSystem as MovementBullet).calculateVelocity(position);
	            entity.movieClip.rotation = Math.atan2(targetPosition.y - position.y, targetPosition.x - position.x)+Math.PI;
                GameStage.gameStage.addChild(entity.movieClip);
            }
        }
    }
}
