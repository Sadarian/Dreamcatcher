package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import flash.geom.Point;

    public class MovementEnemy implements IMovement
    {
        private var _speed:Number = 0;

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
            return (position.add(new Point(_speed * Math.cos(Math.PI) * deltaTime, _speed * Math.sin(Math.PI) * deltaTime)));
        }
    }
}
