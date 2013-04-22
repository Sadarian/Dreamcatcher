package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.Entity;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Collision.CollisionUnidentical;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponBoss;
	import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

	import flash.display.Bitmap;
	import flash.display.BitmapData;

	import flash.display.Shape;
	import flash.geom.Point;

	import flash.geom.Point;

	import starling.animation.Transitions;

	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class MovementBoss implements IMovement
    {
        public static var MELEE:String = "Melee";
        public static var RANGE:String = "Range";
	    public static var FLEE:String = "Flee";
	    public static var PINPLAYER:String = "PinPlayer";
        public static var MELEE_TO_RANGE:String = "MeleeToRange";
        public static var PREPARE_MELEE:String = "PrepareMelee";

        private static var _phase:String = RANGE;

        private var boss:Entity;
        private var player:Entity;
        private var startPoint:Point;
        private var targetPoint:Point;

        private var _onInit:Boolean = true;
	    private static var textureSwitchComplete:Boolean = false;
		private static var _incoming:Boolean = false;
	    private var lightFlashScreen:Sprite;
        private var _duration:Number = 0;
        private var _angle:Number = 0;
        private var _speed:Number = 0;
        private var _direction:Point = new Point();
        private var _lastMoveUp:Boolean = Math.round(Math.random()) == 1;
        private var _canMove:Boolean = true;
        private var raged:Boolean = false;

        public function get canMove():Boolean
        {
            return _canMove;
        }

        public function set speed(value:Number):void
        {
            _speed = value;
        }

        public function move(deltaTime:Number, position:Point):Point
        {
            _duration += deltaTime;
            if(_duration < GameConstants.bossFadingInTime)
			{
				_incoming = true;
				return (position.add(new Point(-GameConstants.bossDistanceBorder/GameConstants.bossFadingInTime * deltaTime ,0)));
			}
            else if(!_incoming)
            {
                if(!_onInit && boss.name == GameConstants.BOSS1 && boss.health/boss.maxHealth <= 0.3 && phase != FLEE)
                {
	                changeTexture();
                }
                if(!_onInit && !raged && boss.isBoss2 && boss.health/boss.maxHealth <= 0.3)
                {
                    trace(boss.health/boss.maxHealth, boss.health);
                    raged = true;
                    GraphicsManager.graphicsManager.playSound("Boss2CloseCombat");
                    boss.increaseMovementSpeed(0.66);
                    boss.increaseWeaponSpeed(0.66);
                }
                if(!_canMove && _phase != FLEE) return position;
                switch(_phase)
                {
                    case(RANGE):
                    {
                        if(_onInit)
                        {
                            boss = EntityManager.entityManager.getEntity(GameConstants.BOSS1);
                            if(!boss) boss = EntityManager.entityManager.getEntity(GameConstants.BOSS2);
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
                        trace(position.x)
                        if(position.x >= startPoint.x)
                            switchTo(RANGE);
                        _angle = Math.atan2(startPoint.y - position.y, startPoint.x - position.x);
                        return (position.add(new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime)));
                    }
	                case(FLEE):
	                {
                        if(!_onInit)
                            _onInit = true;
		                if (position.x == Starling.current.viewPort.width-20)
		                {
			                GameStage.gameStage.endLvl("The END!");
		                }
		                return (position.add(new Point(_speed * Math.cos(0) * deltaTime, _speed * Math.sin(0) * deltaTime)));
	                }
	                case(PINPLAYER):
	                {
		                if (position.x == Starling.current.viewPort.width/2 && position.y == Starling.current.viewPort.height/2)
		                {
			                player.switchMovement(null);
			                switchTo(FLEE);
		                }
		                else
		                {
			                _angle = Math.atan2(Starling.current.viewPort.height/2 - position.y, Starling.current.viewPort.width/2 - position.x);
			                var temPoint:Point = new Point(_speed * Math.cos(_angle) * deltaTime, _speed * Math.sin(_angle) * deltaTime);
			                if (temPoint.x >= 0)
			                {
				                return new Point(Starling.current.viewPort.width/2, Starling.current.viewPort.height/2);
			                }
			                return (position.add(temPoint));
		                }
	                }
                }
                return position;
            }
			return position;
        }

	    public function changeTexture():void
	    {
		    if (textureSwitchComplete)
		    {
			    switchTo(PINPLAYER);
		    }
		    else if (!lightFlashScreen)
		    {
			    lightFlashScreen = new Sprite();
			    lightFlashScreen.addChild(new Quad(Starling.current.viewPort.width,Starling.current.viewPort.height, 0xe111111));
			    lightFlashScreen.alpha = 0.2;
			    player.switchWeapon(null);
			    GameStage.gameStage.addChild(lightFlashScreen);
			    fadeIn(lightFlashScreen);
			    switchTexture();
			    Starling.juggler.delayCall(fadeOut,1, lightFlashScreen);
			    Starling.juggler.delayCall(deleteLightFlash, 2, lightFlashScreen)
		    }
	    }

		private function switchTexture():void
		{
			trace("lvl2 texture");
		}

		private function deleteLightFlash(lightFlashScreen:DisplayObject):void
		{
			GameStage.gameStage.removeActor(lightFlashScreen);
			lightFlashScreen.dispose();
		}

        public function get onInit():Boolean
        {
            return _onInit;
        }

        public function switchTo(phase:String):void
        {
            if(phase == _phase)
                return;
            _phase = phase;
            switch (_phase)
            {
                case(MELEE):
                    _speed *= GameConstants.bossChargeSpeedMultiplier;
                    (boss.weaponSystem as WeaponBoss).canShoot = false;
                    break;

                case(RANGE):
                    _direction = new Point();
                    break;

                case(MELEE_TO_RANGE):
                    _speed /= GameConstants.bossChargeSpeedMultiplier;
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
		            break;

	            case(PINPLAYER):
		            (boss.weaponSystem as WeaponBoss).canShoot = false;
		            break;

                default:
                    throw new ArgumentError("Error! Unsupported phase argument!")
            }
        }

		private function fadeIn(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,0.5,Transitions.EASE_IN);
			mTween.fadeTo(1);
			Starling.juggler.add(mTween);

		}

		private function fadeOut(tweenObject:DisplayObject):void
		{
			var mTween:Tween = new Tween (tweenObject,0.5,Transitions.EASE_OUT);
			mTween.fadeTo(0);
			textureSwitchComplete = true;
			Starling.juggler.add(mTween);
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

        public function set canMove(value:Boolean):void
        {
            _canMove = value;
        }

		public static function get incoming():Boolean {
			return _incoming;
		}

		public static function set incoming(value:Boolean):void {
			_incoming = value;
		}
	}
}
