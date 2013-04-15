package de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon
{
	import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;

	import flash.geom.Point;
    import starling.core.Starling;

    public class WeaponPlayerPowershot implements IWeapon
    {
        private var _speed:Number = 0;
        private var sumTime:Number = 0;
	    private static var _loadTime:Number = 0;

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

        }

	    public static function set loadTime(value:Number):void {
		    _loadTime = value;
	    }
    }
}
