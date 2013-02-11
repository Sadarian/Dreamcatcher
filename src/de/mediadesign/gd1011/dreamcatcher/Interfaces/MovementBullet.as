package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;

    public class MovementBullet implements IMovement
    {
        private var _speed:Number = 0;
        private var _target:Point = new Point();
        private var velocity:Point = new Point();

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function set target(point:Point):void
        {
            _target = point;
        }

        public function calculateVelocity(position:Point):void
        {
            var angle:Number = Math.atan2(_target.y - position.y, _target.x - position.x);
            velocity.x = _speed * Math.cos(angle);
            velocity.y = _speed * Math.sin(angle);
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            return (position.add(new Point(velocity.x / (1000/deltaTime), velocity.y / (1000/deltaTime))));
        }
    }
}
