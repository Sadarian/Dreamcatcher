package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

import flash.geom.Point;

import starling.core.Starling;

public class WeaponBoss implements IWeapon
    {
        private var _canShoot:Boolean = false;
        private var boss:Entity;

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
                    boss = EntityManager.entityManager.getEntity(GameConstants.BOSS1);
                    boss.playAnimation(AnimatedModel.SHOOT);
                    var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.BOSS1_BULLET, new Point(boss.position.x - 70, boss.position.y));
                    var targetPosition:Point = (target != null)?new Point(target.x, target.y):new Point(0 , 0);
                    (entity.movementSystem as MovementBullet).target = targetPosition;
                    (entity.movementSystem as MovementBullet).calculateVelocity(boss.position);
                    entity.movieClip.rotation = Math.atan2(targetPosition.y - boss.position.y, targetPosition.x - boss.position.x)+Math.PI;
                    shoots++;
                    if(shoots == GameConstants.bossShootsUntilCharge)
                    {
                        shoots = 0;
                        (EntityManager.entityManager.getEntity(GameConstants.BOSS1).movementSystem as MovementBoss).switchTo(MovementBoss.PREPARE_MELEE);
                    }
                }
            }
        }

        public function set canShoot(value:Boolean):void
        {
            _canShoot = value;
        }

        public function increaseSpeed(multiplier:Number):void
        {
            _speed *= multiplier;
        }
    }
}
