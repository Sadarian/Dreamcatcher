package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;

    import starling.core.Starling;
    import starling.events.Touch;

    public class WeaponPlayer implements IWeapon
    {
        private static var touch:Touch = null;

        public static function setTouch(touchList:Vector.<Touch>):void
        {
            WeaponPlayer.touch = null;
            for each (var touch:Touch in touchList)
                if(touch.getLocation(Starling.current.stage).x > Starling.current.viewPort.width/2)
                    WeaponPlayer.touch = touch;
        }

        public function set speed(value:Number):void
        {

        }

        public function shoot(position:Point, target:Object):void
        {

        }
    }
}
