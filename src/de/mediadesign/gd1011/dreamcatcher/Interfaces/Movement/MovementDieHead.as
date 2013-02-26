package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import flash.geom.Point;

    public class MovementDieHead implements IMovement
    {
        private var _speed:Number;

        public function MovementDieHead(speed:Number)
        {
            _speed = speed;
        }

        public function set speed(value:Number):void
        {
            _speed = value;
        }

	    public function increaseSpeed(multiplier:Number):void
        {
	        _speed /= multiplier;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            return (position.add(new Point(_speed * Math.cos(0) * deltaTime, _speed * Math.sin(0) * deltaTime)));
        }
    }
}
