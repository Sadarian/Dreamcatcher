package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import flash.geom.Point;

	import starling.core.Starling;

    public class MovementVictim implements IMovement
    {
        private var idleTime:Number = GameConstants.victimTimeUntilMid;
        private var _speed:Number = 0;
	    private var directionChange:Number = 0;
	    private var _direction:Number = 0;

	    private var _onInit:Boolean = true;

	    private var minDirection:Number = GameConstants.victimDirectionBorderMin;
	    private var maxDirection:Number = GameConstants.victimDirectionBorderMax;
	    private var minMovementY:Number = GameConstants.victimMovementBorderMin;
	    private var maxMovementY:Number = GameConstants.victimMovementBorderMax;

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
            if(idleTime<=0)
            {
                if(_onInit)
                    _onInit = false;

	            if (maxMovementY <= position.y)
	            {
		            _direction = getDirection(0,minDirection, deltaTime);
	            }
	            else if (minMovementY >= position.y)
	            {
		            _direction = getDirection(maxDirection, 0, deltaTime);
	            }
	            else
	            {
		            _direction = getDirection(maxDirection, minDirection, deltaTime);
	            }

	            var point:Point = new Point(_speed * Math.cos(0) * deltaTime, _speed * Math.sin(_direction) * deltaTime);

                return (position.add(point));
            }
            else
            {
                idleTime-=deltaTime;
                return (position.add(new Point(-(Starling.current.viewPort.width/2)/GameConstants.victimTimeUntilMid*deltaTime, 0)));
            }
        }

	    private function getDirection(maxDirection:Number, minDirection:Number, deltaTime:Number):Number {

		    if (directionChange<=0 || maxDirection == 0 || minDirection == 0)
		    {
			    directionChange = 0.5;
			    return Math.floor(Math.random()*(maxDirection - (minDirection) + 1)) + (minDirection);
		    }
		    else
		    {
			    directionChange -= deltaTime;
			    return _direction;
		    }
	    }

	    public function get onInit():Boolean {
		    return _onInit;
	    }

        public function get speed():Number
        {
            return _speed;
        }
    }
}
