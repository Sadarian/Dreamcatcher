package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;

    import flash.geom.Point;

    public class MovementPlayerToStart implements IMovement
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
            var targetPoint:Point = GameConstants.playerStartPosition;
			if (targetPoint.equals(position))
			{
				return position;
			}
			else
			{
				var angle:Number = Math.atan2(targetPoint.y - position.y, targetPoint.x - position.x);
				var temPoint:Point = new Point((_speed * Math.cos(angle) * deltaTime), (_speed * Math.sin(angle) * deltaTime));
				if (temPoint.x >= 0)
				{
					return GameConstants.playerStartPosition
				}
				return (position.add(temPoint));
			}
        }
    }
}
