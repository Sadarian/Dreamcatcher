package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
import de.mediadesign.gd1011.dreamcatcher.GameConstants;

import flash.geom.Point;

    public class MovementMiniBoss implements IMovement
    {
        private var _speed:Number = 0;
        private var directionChange:Number = 0;
        private var _direction:Number = 0;

        //noinspection JSFieldCanBeLocal
        private var minDirection:Number = GameConstants.victimDirectionBorderMin;
        //noinspection JSFieldCanBeLocal
        private var maxDirection:Number = GameConstants.victimDirectionBorderMax;
        //noinspection JSFieldCanBeLocal
        private var minMovementY:Number = GameConstants.victimMovementBorderMin;
        //noinspection JSFieldCanBeLocal
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

            var point:Point = new Point(_speed * Math.cos(Math.PI) * deltaTime, _speed * Math.sin(_direction) * deltaTime);

            return (position.add(point));
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

        public function get speed():Number
        {
            return _speed;
        }
    }
}