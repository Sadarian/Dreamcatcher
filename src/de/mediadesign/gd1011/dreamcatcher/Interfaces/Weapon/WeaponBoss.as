package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
    import flash.geom.Point;

    public class WeaponBoss implements IWeapon
    {
        private var _canShoot:Boolean = false;

        private var shoots:Number = 0;
        private var _speed:Number = 0;
        private var sumTime:Number = 0;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function shoot(deltaTime:Number, position:Point, target:Object):void
        {
            if(_canShoot)
            {
                sumTime += deltaTime;
                if(sumTime>=_speed)
                {
                    sumTime -= _speed;

                    var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.BOSS_BULLET, position);
                    var targetPosition:Point = (target != null)?new Point(target.x, target.y):new Point(0 , 0);
                    (entity.movementSystem as MovementBullet).target = targetPosition;
                    (entity.movementSystem as MovementBullet).calculateVelocity(position);
                    entity.movieClip.rotation = Math.atan2(targetPosition.y - position.y, targetPosition.x - position.x)+Math.PI;

                    shoots++;
                    if(shoots == GameConstants.bossShootsUntilCharge)
                    {
                        shoots = 0;
                        (EntityManager.entityManager.getEntity(GameConstants.BOSS1).movementSystem as MovementBoss).switchTo(MovementBoss.MELEE);
                    }
                }
            }
        }

        public function set canShoot(value:Boolean):void
        {
            _canShoot = value;
        }

	    public function increaseSpeed(multiplier:Number):void {
	    }
    }
}
