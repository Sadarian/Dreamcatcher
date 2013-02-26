package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionUnidentical;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponBoss;
	import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

import flash.geom.Point;
    import starling.core.Starling;

    public class MovementBoss implements IMovement
    {
        public static var MELEE:String = "Melee";
        public static var RANGE:String = "Range";
	    public static var FLEE:String = "Flee";
        public static var MELEE_TO_RANGE:String = "MeleeToRange";
        public static var PREPARE_MELEE:String = "PrepareMelee";

        private static var _phase:String = RANGE;

        private var boss:Entity;
        private var player:Entity;
        private var startPoint:Point;
        private var targetPoint:Point;

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
                if(!_onInit && boss.name == GameConstants.BOSS1 && boss.health/boss.maxHealth <= 0.3 && phase != FLEE)
                    switchTo(FLEE);
                switch(_phase)
                {
                    case(RANGE):
                    {
                        if(_onInit)
                        {
                            boss = EntityManager.entityManager.getEntity(GameConstants.BOSS1);
                            player = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
                            startPoint = position;
                            _onInit = false;
                            (boss.weaponSystem as WeaponBoss).canShoot = true;
                        }

                        if(player && boss.movieClip.bounds.left - player.movieClip.bounds.right < 50)
                        {
                            targetPoint = player.position;
                            switchTo(MELEE);
                        }
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
                        if(CollisionUnidentical.checkCollision(player, boss) || position.x <= targetPoint.x)
                            switchTo(MELEE_TO_RANGE);
	                    _angle = Math.atan2(targetPoint.y - position.y, targetPoint.x - position.x);
                        return (position.add(new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime)));
                    }
                    case(MELEE_TO_RANGE):
                    {
                        if(position.x >= startPoint.x)
                            switchTo(RANGE);
                        _angle = Math.atan2(startPoint.y - position.y, startPoint.x - position.x);
                        return (position.add(new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime)));
                    }
	                case(FLEE):
	                {
                        if(!_onInit)
                            _onInit = true;
		                return (position.add(new Point(_speed * Math.cos(0) * deltaTime, _speed * Math.sin(0) * deltaTime)));
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
            _phase = phase;
	        trace(_phase);
            switch (_phase)
            {
                case(MELEE):
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

                case(PREPARE_MELEE):
                    (boss.weaponSystem as WeaponBoss).canShoot = false;
                    targetPoint = (Math.round(Math.random()) == 1)?
                            new Point(boss.movieClip.width/2, boss.movieClip.height/2):
                            new Point(boss.movieClip.width/2, Starling.current.viewPort.height-boss.movieClip.height/2);
                    boss.playAnimation(AnimatedModel.CLOSE_COMBAT);
                    break;
	            case(FLEE):
		            (boss.weaponSystem as WeaponBoss).canShoot = false;
		            _speed *= ((GameConstants.bossChargeSpeedMultiplier)*(-1));
		            break;

                default:
                    throw new ArgumentError("Error! Unsupported phase argument!")
            }
        }

	    public function increaseSpeed(multiplier:Number):void
	    {
			_speed /= multiplier;
	    }

	    public static function get phase():String
	    {
		    return _phase;
	    }

	    public static function resetPhase():void
	    {
		    _phase = RANGE;
	    }
    }
}
