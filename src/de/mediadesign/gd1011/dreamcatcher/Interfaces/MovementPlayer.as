package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;

    import starling.core.Starling;
    import starling.events.Touch;

    public class MovementPlayer implements IMovement
    {
        private static var maxSpeed:Number = 5;

        private static var touch:Touch = null;
        private var velocity:Point = new Point();

        public static function setTouch(touchList:Vector.<Touch>):void
        {
            MovementPlayer.touch = null;
            for each (var touch:Touch in touchList)
                if(touch.getLocation(Starling.current.stage).x < Starling.current.viewPort.width/2)
                    MovementPlayer.touch = touch;
        }

        private function calculateVelocity(position:Point):void
        {
            var tempPoint:Point = new Point();
            if(touch != null)
            {
                tempPoint.copyFrom(touch.getLocation(Starling.current.stage));
                var tempVelocity = tempPoint;
                tempVelocity.subtract(position);
                velocity.x = (tempPoint.x < position.x) ? Math.max(-maxSpeed, -tempVelocity.x) : Math.min(maxSpeed, tempVelocity.x);
                velocity.y = (tempPoint.y < position.y) ? Math.max(-maxSpeed, -tempVelocity.y) : Math.min(maxSpeed, tempVelocity.y);
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

            if(velocity.y > 0 && position.y + velocity.y > Starling.current.viewPort.height - 128)
                velocity.y = Starling.current.viewPort.height - 128 - position.y;

            if(velocity.y < 0 && position.y + velocity.y < 128)
                velocity.y = 128 - position.y;

            if(velocity.x > 0 && position.x + velocity.x > Starling.current.viewPort.width/2)
                velocity.x = Starling.current.viewPort.width/2 - position.y;

            if(velocity.x < 0 && position.x + velocity.x < 128)
                velocity.x = 128 - position.x;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            calculateVelocity(position);
            validateVelocity(position);
            return (position.add(velocity));
        }
    }
}
