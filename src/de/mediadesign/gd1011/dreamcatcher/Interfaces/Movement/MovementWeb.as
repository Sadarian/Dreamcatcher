package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import flash.geom.Point;

    import starling.utils.deg2rad;

    public class MovementWeb implements IMovement
    {
        private var _speed:Number = 0;
        private var _target:Point = new Point();
        private var velocity:Point = new Point();
        private var _rotation:Number = deg2rad(225);
        private var speedY:Number;
        private var time:Number;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

	    public function increaseSpeed(multiplier:Number):void
	    {
		    _speed /= multiplier;
	    }

        public function set target(point:Point):void
        {
            _target = point;
        }

        public function calculateVelocity(position:Point):void
        {
            velocity.x = -_speed;
            velocity.y = Math.abs(_target.x-position.x)/-1;
            speedY = Math.abs(velocity.y) + (_target.y - position.y);
            time = (Math.abs(_target.x-position.x) / Math.abs(_speed))/2;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            _rotation = Math.atan2(velocity.y, velocity.x) + Math.PI;
            velocity.y += speedY/(time/deltaTime);
            return (position.add(new Point((velocity.x * deltaTime), (velocity.y * deltaTime))));
        }

        public function get rotation():Number
        {
            return _rotation;
        }
    }
}
