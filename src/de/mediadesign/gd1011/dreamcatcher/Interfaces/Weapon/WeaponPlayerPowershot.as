package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
	import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	import flash.geom.Point;

	import org.osmf.metadata.CuePoint;

	import starling.core.Starling;

    public class WeaponPlayerPowershot implements IWeapon
    {
        private var _speed:Number = 0;
        private var sumTime:Number = 0;
	    private var loadPowerShot:AnimatedModel;
	    private var temPosition:Point;
	    private var stack:Number = 0;
	    private var canShoot:Boolean = false;

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
	        temPosition = new Point(position.x - -125, position.y - -33);

	        if (loadPowerShot == null)
	        {
		        loadPowerShot = new AnimatedModel("PlayerPowershot", new Array(), "Charging");
		        loadPowerShot.start();
		        loadPowerShot.x = temPosition.x;
		        loadPowerShot.y = temPosition.y;
		        loadPowerShot.scaleX = 0;
		        loadPowerShot.scaleY = 0;
		        GameStage.gameStage.addChild(loadPowerShot);
	        }
	        sumTime += deltaTime;

	        if (sumTime >= 1 && sumTime < 2)
	        {
		        loadPowerShot.x = temPosition.x;
		        loadPowerShot.y = temPosition.y;
		        loadPowerShot.scaleX = 0.5;
		        loadPowerShot.scaleY = 0.5;
		        stack = 1;
		        canShoot = true;
	        }
	        else if (sumTime >= 2)
	        {
		        loadPowerShot.x = temPosition.x;
		        loadPowerShot.y = temPosition.y;
		        loadPowerShot.scaleX = 1;
		        loadPowerShot.scaleY = 1;
		        stack = 2;
		        canShoot = true;
	        }
        }

	    public function shootNow():void
	    {
		    if (loadPowerShot != null && canShoot)
		    {
			    sumTime = 0;

			    loadPowerShot.scaleX = 0;
			    loadPowerShot.scaleY = 0;

			    var entity:Entity = EntityManager.entityManager.createEntity(GameConstants.PLAYER_POWERSHOT, temPosition);
			    (entity.movementSystem as MovementBullet).target = new Point(Starling.current.viewPort.width * 1.2, temPosition.y);
			    (entity.movementSystem as MovementBullet).calculateVelocity(temPosition);
			    GraphicsManager.graphicsManager.playSound("PowerShoot");
			    GameStage.gameStage.addChild(entity.movieClip);

			    switch (stack)
			    {
				    case 1:
				    {
					    entity.health /= 2;
					    entity.movieClip.scaleX = 0.5;
					    entity.movieClip.scaleY = 0.5;
					    trace("powerBullet HP: " + entity.health);
					    break;
				    }
				    case 2:
				    {
					    entity.movieClip.scaleX = 1;
					    entity.movieClip.scaleY = 1;
					    trace("powerBullet better HP: " + entity.health);
					    break;
				    }
			    }

			    stack = 0;
			    canShoot = false;
		    }
	    }
    }
}
