package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import flash.geom.Point;
    import starling.core.Starling;

    public class MovementVictim implements IMovement
    {
        private var idleTime:Number = GameConstants.victimTimeUntilMid;
        private var _speed:Number = 0;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            if(idleTime<=0)
                return (position.add(new Point(_speed * Math.cos(0) * deltaTime, _speed * Math.sin(0) * deltaTime)));
            else
            {
                idleTime-=deltaTime;
                return (position.add(new Point(-(Starling.current.viewPort.width/2)/GameConstants.victimTimeUntilMid*deltaTime, 0)));
            }
        }
    }
}
