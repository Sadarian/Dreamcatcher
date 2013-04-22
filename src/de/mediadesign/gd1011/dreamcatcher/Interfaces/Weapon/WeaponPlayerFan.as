package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
    import flash.geom.Point;

	import starling.animation.IAnimatable;
	import starling.core.Starling;
    import starling.events.Touch;

    public class WeaponPlayerFan implements IWeapon
    {
        private var _speed:Number = 0;
        private var sumTime:Number = 0;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

	    public function increaseSpeed(multiplier:Number):void
	    {
		    _speed *= multiplier;
	    }

	    public function shoot(deltaTime:Number, position:Point, target:Object):void
        {
            sumTime += deltaTime;
            if(sumTime>=_speed)
            {
                sumTime -= _speed;

                var temPosition:Point = new Point(position.x - -125, position.y - -33);

				for (var i:int = -1; i < 2; i++)
				{
					var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.PLAYER_STRONG_BULLET, temPosition);

					var targetPosition:Point;

					switch (i)
					{
						case -1:
						{
							targetPosition = new Point((Math.tan(GameConstants.fanAngle) * temPosition.y) + temPosition.x, 0);
							break;
						}

						case 0:
						{
							targetPosition = new Point((Starling.current.viewPort.width*1.2) + temPosition.x, temPosition.y);
							break;
						}
//
						case 1:
						{
							targetPosition = new Point((Math.tan(GameConstants.fanAngle) * temPosition.y) + temPosition.x, Starling.current.viewPort.height);
							break;
						}
					}

					(entity.movementSystem as MovementBullet).target = targetPosition;
					(entity.movementSystem as MovementBullet).calculateVelocity(temPosition);
					entity.movieClip.rotation = Math.atan2(targetPosition.y - temPosition.y, targetPosition.x - temPosition.x);
                    GraphicsManager.graphicsManager.playSound("PlayerShootPowerUp");
					GameStage.gameStage.addChild(entity.movieClip);
				}
            }
        }
    }
}
