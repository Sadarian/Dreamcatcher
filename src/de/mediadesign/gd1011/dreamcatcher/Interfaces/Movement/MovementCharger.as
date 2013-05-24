package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;

    import flash.geom.Point;

    public class MovementCharger implements IMovement
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
            var targetPoint:Point = (EntityManager.entityManager.getEntity(GameConstants.PLAYER)) ? (EntityManager.entityManager.getEntity(GameConstants.PLAYER)).position : new Point(0, position.y);
            var angle:Number = Math.atan2(targetPoint.y - position.y, targetPoint.x - position.x);
            return (position.add(new Point((_speed * Math.cos(angle) * deltaTime), (_speed * Math.sin(angle) * deltaTime))));
        }
    }
}
