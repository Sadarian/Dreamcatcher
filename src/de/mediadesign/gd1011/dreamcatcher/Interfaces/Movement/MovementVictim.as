package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import flash.geom.Point;

	import flashx.textLayout.compose.FlowDamageType;

	import starling.core.Starling;

    public class MovementVictim implements IMovement
    {
        private var idleTime:Number = GameConstants.victimTimeUntilMid;
        private var _speed:Number = 0;
	    private var directionChange:Number = 0;
	    private var direction:Number = 0;
	    private var minDirection:Number = -45;
	    private var maxDirection:Number = 45;
	    private var minMovementY:Number = 200;
	    private var maxMovementY:Number = 700;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            if(idleTime<=0)
            {



				var move:Number;

	            if (maxMovementY <= position.y)
	            {
		            direction = getDirection(0,minDirection, deltaTime);
	            }
	            else if (minMovementY >= position.y)
	            {
		            direction = getDirection(maxDirection, 0, deltaTime);
	            }
	            else
	            {
		            direction = getDirection(maxDirection, minDirection, deltaTime);
	            }

	            var point:Point = new Point(_speed * Math.cos(0) * deltaTime, _speed * Math.sin(direction) * deltaTime);

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
			    return direction;
		    }
	    }
    }
}
