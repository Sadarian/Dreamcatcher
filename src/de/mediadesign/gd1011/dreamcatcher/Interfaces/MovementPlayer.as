package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;

    import flash.geom.Point;
    import flash.geom.Rectangle;

    import robotlegs.bender.extensions.commandCenter.impl.NullCommandUnmapper;

    import starling.core.Starling;
    import starling.events.Touch;

    public class MovementPlayer implements IMovement
    {
        private static var BORDER:Rectangle = GameConstants.playerMovementBorder;

        private static var _touch:Touch = null;

        private var _speed:Number = 0;
        private var velocity:Point = new Point();

        public static function set touch(touch:Touch):void
        {
            _touch = touch;
        }

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        private function calculateVelocity(position:Point):void
        {
            if(_touch != null)
            {
                var target:Point = _touch.getLocation(Starling.current.stage);
                var angle:Number = Math.atan2(target.y - position.y, target.x - position.x);
                velocity.x = _speed * Math.cos(angle);
                velocity.y = _speed * Math.sin(angle);
            }
            else
                velocity = new Point();
        }

        private function validateVelocity(position:Point, deltaTime:Number):void
        {
            if(_touch != null)
            {
                var touchLocation:Point = _touch.getLocation(Starling.current.stage);

                var tempCalc:Point = new Point(velocity.x / (1000/deltaTime), velocity.y / (1000/deltaTime));
                //Validation for Y
                if(((velocity.y > 0) && ((position.y + tempCalc.y) > touchLocation.y)) ||
                        ((velocity.y < 0) && ((position.y + tempCalc.y) < touchLocation.y)))
                    velocity.y = (touchLocation.y - position.y);

                if(position.y == touchLocation.y)
                    velocity.y = 0;

                //Validation for X
                if(((velocity.x > 0) && ((position.x + tempCalc.x) > touchLocation.x)) ||
                        ((velocity.x < 0) && ((position.x + tempCalc.x) < touchLocation.x)))
                    velocity.x = (touchLocation.x - position.x);

                if(position.x == touchLocation.x)
                    velocity.x = 0;
            }

            if(velocity.y > 0 && position.y + tempCalc.y > BORDER.bottom)
                velocity.y = BORDER.bottom - position.y;

            if(velocity.y < 0 && position.y + tempCalc.y < BORDER.top)
                velocity.y = BORDER.top - position.y;

            if(velocity.x > 0 && position.x + tempCalc.x > BORDER.right)
                velocity.x = BORDER.right - position.y;

            if(velocity.x < 0 && position.x + tempCalc.x < BORDER.left)
                velocity.x = BORDER.left - position.x;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            calculateVelocity(position);
            if(velocity.length!=0)
                validateVelocity(position, deltaTime);
            return (position.add(new Point(velocity.x / (1000/deltaTime), velocity.y / (1000/deltaTime))));
        }
    }
}
