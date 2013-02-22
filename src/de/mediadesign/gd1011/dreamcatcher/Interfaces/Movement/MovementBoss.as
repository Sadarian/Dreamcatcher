package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionUnidentical;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponBoss;

    import flash.geom.Point;
    import starling.core.Starling;

    public class MovementBoss implements IMovement
    {
        public static var MELEE:String = "Melee";
        public static var RANGE:String = "Range";
        public static var MELEE_TO_RANGE:String = "MeleeToRange";

        private var phase:String = RANGE;

        private var boss:Entity;
        private var player:Entity;
        private var startPoint:Point;
        private var playerPoint:Point;

        private var _onInit:Boolean = true;
        private var _duration:Number = 0;
        private var _angle:Number = 0;
        private var _speed:Number = 0;
        private var _direction:Point = new Point();
        private var _lastMoveUp:Boolean = Math.round(Math.random()) == 1;

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            _duration += deltaTime;
            if(_duration < GameConstants.bossFadingInTime)
                return (position.add(new Point(-GameConstants.bossDistanceBorder/GameConstants.bossFadingInTime * deltaTime ,0)));
            else
            {
                switch(phase)
                {
                    case(RANGE):
                    {
                        if(_onInit)
                        {
                            boss = EntityManager.entityManager.getEntity(GameConstants.BOSS);
                            player = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
                            startPoint = position;
                            _onInit = false;
                            (boss.weaponSystem as WeaponBoss).canShoot = true;
                        }

                        if(player.movieClip && boss.movieClip.bounds.left - player.movieClip.bounds.right < 50)
                            switchTo(MELEE);

                        if(_direction.length != 0 && (((_lastMoveUp) && position.y <= _direction.y) || ((!_lastMoveUp) && position.y >= _direction.y)))
                            _direction = new Point();

                        if(_direction.length == 0)
                        {
                            _direction.copyFrom(position);
                            if(_lastMoveUp)
                            {
                                _direction.offset(0, (Starling.current.viewPort.height - position.y - boss.movieClip.height/2)*Math.random());
                                _lastMoveUp = false;
                            }
                            else
                            {
                                _direction.offset(0, (Starling.current.viewPort.y - position.y + boss.movieClip.height/2)*Math.random());
                                _lastMoveUp = true;
                            }
                            _angle = Math.atan2(_direction.y - position.y, _direction.x - position.x);
                        }
                        return (position.add(new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime)));
                    }
                    case(MELEE):
                    {
                        if(CollisionUnidentical.checkCollision(player, boss) || position.x <= playerPoint.x)
                            switchTo(MELEE_TO_RANGE);
                        _angle = Math.atan2(playerPoint.y - position.y, playerPoint.x - position.x);
                        return (position.add(new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime)));
                    }
                    case(MELEE_TO_RANGE):
                    {
                        if(position.x >= startPoint.x)
                            switchTo(RANGE);
                        _angle = Math.atan2(startPoint.y - position.y, startPoint.x - position.x);
                        return (position.add(new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime)));
                    }
                }
                return position;
            }
        }

        public function get onInit():Boolean
        {
            return _onInit;
        }

        public function switchTo(phase:String):void
        {
            trace(phase);
            this.phase = phase;
            switch (phase)
            {
                case(MELEE):
                    playerPoint = player.position;
                    _speed *= GameConstants.bossChargeSpeedMultiplier;
                    (boss.weaponSystem as WeaponBoss).canShoot = false;
                    break;

                case(RANGE):
                    _speed /= GameConstants.bossChargeSpeedMultiplier;
                    _direction = new Point();
                    break;

                case(MELEE_TO_RANGE):
                    (boss.weaponSystem as WeaponBoss).canShoot = true;
                    break;

                default:
                    throw new ArgumentError("Error! Unsupported phase argument!")
            }
        }

	    public function increaseSpeed(multiplier:Number):void {
	    }
    }
}
