package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;

    import flash.geom.Point;
    import flash.geom.Rectangle;

    import starling.core.Starling;
    import starling.events.Touch;

    public class MovementPlayer implements IMovement
    {
        private static var BORDER:Rectangle = GameConstants.playerMovementBorder;

        private static var touch:Touch = null;
        private var velocity:Point = new Point();

        private var _speed:Number;

        public static function setTouch(touchList:Vector.<Touch>):void
        {
            MovementPlayer.touch = null;
            for each (var touch:Touch in touchList)
                if(touch.getLocation(Starling.current.stage).x < Starling.current.viewPort.width/2)
                    MovementPlayer.touch = touch;
        }

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        private function calculateVelocity(position:Point):void
        {
            var tempPoint:Point = new Point();
            if(touch != null)
            {
                tempPoint.copyFrom(touch.getLocation(Starling.current.stage));
                var tempVelocity:Point = tempPoint;
                tempVelocity.subtract(position);
                velocity.x = (tempPoint.x < position.x) ? Math.max(-_speed, -tempVelocity.x) : Math.min(_speed, tempVelocity.x);
                velocity.y = (tempPoint.y < position.y) ? Math.max(-_speed, -tempVelocity.y) : Math.min(_speed, tempVelocity.y);
            }
            else
                velocity.copyFrom(tempPoint);
        }

        private function validateVelocity(position:Point):void
        {
            if(touch != null)
            {
                var touchLocation:Point = touch.getLocation(Starling.current.stage);

                //Validation for Y
                if(velocity.y > 0 && position.y + velocity.y > touchLocation.y ||
                        velocity.y < 0 && position.y + velocity.y < touchLocation.y)
                    velocity.y = touchLocation.y - position.y;

                if(position.y == touchLocation.y)
                    velocity.y = 0;

                //Validation for X
                if(velocity.x > 0 && position.x + velocity.x > touchLocation.x ||
                        velocity.x < 0 && position.x + velocity.x < touchLocation.x)
                    velocity.x = touchLocation.x - position.x;

                if(position.x == touchLocation.x)
                    velocity.x = 0;
            }

            if(velocity.y > 0 && position.y + velocity.y > BORDER.bottom)
                velocity.y = BORDER.bottom - position.y;

            if(velocity.y < 0 && position.y + velocity.y < BORDER.top)
                velocity.y = BORDER.top - position.y;

            if(velocity.x > 0 && position.x + velocity.x > BORDER.right)
                velocity.x = BORDER.right - position.y;

            if(velocity.x < 0 && position.x + velocity.x < BORDER.left)
                velocity.x = BORDER.left - position.x;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            calculateVelocity(position);
            validateVelocity(position);
            return (position.add(velocity));
        }
    }
}
