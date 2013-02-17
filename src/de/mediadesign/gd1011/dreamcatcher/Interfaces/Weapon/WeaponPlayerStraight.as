package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
    import flash.geom.Point;
    import starling.core.Starling;

    public class WeaponPlayerStraight implements IWeapon
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
                var temPosition:Point = new Point(position.x - -125, position.y - -33);
	            var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.PLAYER_BULLET, temPosition);
		        (entity.movementSystem as MovementBullet).target = new Point(Starling.current.viewPort.width, temPosition.y);
	            (entity.movementSystem as MovementBullet).calculateVelocity(temPosition);
                GameStage.gameStage.addChild(entity.movieClip);
            }
        }
    }
}
