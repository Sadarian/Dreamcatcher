package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Touch;

    public class MovementBullet implements IMovement
    {
        private static var SPEED:Number = 5;

        private var velocity:Point = new Point();

        public function MovementBullet(target:Point):void
        {

        }

        public function move(deltaTime:Number, position:Point):Point
        {
            return (position.add(velocity));
        }
    }
}
