package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;

    public class MovementVictim implements IMovement
    {
        private var _speed:Number = 0;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            return (position.add(new Point(_speed * Math.cos(0) / deltaTime, _speed * Math.sin(0) / deltaTime)));
        }
    }
}
