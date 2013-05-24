package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.IMovement;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementWeb;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.IWeapon;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.ColorFilter;

    import flash.geom.Point;

    import starling.core.Starling;
    import starling.display.DisplayObject;
    import starling.display.DisplayObjectContainer;

    public class Entity
    {
        //JSON-Config Data:
        private var _name:String;
        private var _health:Number;
		private var _maxHealth:Number;
        private var _movementSystem:IMovement;
        private var _weaponSystem:IWeapon;
        private var _collisionMode:String;
        private var _collisionPoint:Point;
        private var _collisionValues:Point;
        private var _movieClip:DisplayObject; //added via JSON but it isn't in the Config!
		private var _points:Number;
		private var _weaponSpeed:Number;
		private var _movementSpeed:Number;
		private var _isSlowed:Boolean;

       //Additional Constructor Data:
        private var _position:Point;

        private var _canAttacked:Boolean; //only for Player!

        public function Entity(jsonConfig:Array, position:Point)
        {
	        setData(jsonConfig, position);
        }

		public function setData(jsonConfig:Array, position:Point):void {
			_name = jsonConfig[0];
			_maxHealth = jsonConfig[1];
			_health = maxHealth;

			_movementSystem = jsonConfig[2];
			if(_movementSystem)
			{
				_movementSpeed = jsonConfig[3];
				setMovementSpeed();
			}

			_weaponSystem = jsonConfig[4];
			if(_weaponSystem)
			{
				_weaponSpeed = jsonConfig[5];
				setWeaponSpeed();
			}

			_collisionMode = jsonConfig[6];
			_collisionPoint = jsonConfig[7];
			_collisionValues = jsonConfig[8];

			_movieClip = jsonConfig[9];
            if(name.search(GameConstants.POWERUP) == -1)
                for (var i:int=0;i<(_movieClip as DisplayObjectContainer).numChildren;i++)
                    getAnimatedModel(i).owner = this;
            else
            {
                movieClip.pivotX = movieClip.width/2;
                movieClip.name = "-1";
            }

			_points = jsonConfig[10];

			_position = position;
            _canAttacked = true;

			_isSlowed = false;

            _movieClip.filter = null;

            init();
		}

		private function init():void
		{
			_movieClip.x = _position.x;
			_movieClip.y = _position.y;
			if(isEnemy || isCharger || isBoss1)
				GraphicsManager.graphicsManager.playSound(name+"Intro");
		}

        public function move(deltaTime:Number):void
        {
            if(_movementSystem)
            {
                _position = _movementSystem.move(deltaTime, _position);
                if(isVictim && _movementSystem is MovementVictim && !(_movementSystem as MovementVictim).onInit && getAnimatedModel(0).ActualAnimation.name == AnimatedModel.EAT)
                    playAnimation(AnimatedModel.FEAR);
            }
        }

        public function render():void
        {
            if(_movementSystem)
            {
                _movieClip.x = _position.x;
                _movieClip.y = _position.y;
                if(_movementSystem is MovementWeb)
                    _movieClip.rotation = (_movementSystem as MovementWeb).rotation;
            }
        }

		public function shoot(deltaTime:Number):void
		{
            if(_weaponSystem && EntityManager.entityManager.getEntity(GameConstants.PLAYER))
                _weaponSystem.shoot(deltaTime, _position, EntityManager.entityManager.getEntity(GameConstants.PLAYER).position);
        }

		public function removeMovieClip():void
		{
			GraphicsManager.graphicsManager.addMovieClip(_movieClip, _name);
		}

		public function switchMovement(movementSystem:IMovement):void
        {
			this._movementSystem = movementSystem;
		}

		public function switchWeapon(weaponSystem:IWeapon):void
        {
			this._weaponSystem = weaponSystem;
		}

	    public function get name():String
	    {
		    return _name;
	    }

		public function get movieClip():DisplayObject
        {
			return _movieClip;
		}

        public function getAnimatedModel(index:int = 0):AnimatedModel
        {
            return ((_movieClip as DisplayObjectContainer).getChildAt(index) as AnimatedModel);
        }

        public function get collisionMode():String
        {
            return _collisionMode;
        }

		public function get movementSystem():IMovement
		{
			return _movementSystem;
		}

        public function get weaponSystem():IWeapon
        {
            return _weaponSystem;
        }

		public function get collisionPoint():Point
		{
			return _collisionPoint;
		}

		public function get collisionValues():Point
		{
			return _collisionValues;
		}

		public function get position():Point
		{
			return _position;
		}

		public function get health():Number
		{
			return _health;
		}

		public function set health(value:Number):void
		{
			_health = value;
			if (_health > _maxHealth)
			{
				_health = _maxHealth;
			}
		}

		public function get points():Number
		{
			return _points;
		}

		public function increaseWeaponSpeed(multiplier:Number):void
		{
			if (_weaponSystem != null)
			{
				_weaponSystem.increaseSpeed(multiplier);
			}
		}

		public function setWeaponSpeed():void
		{
			if (_weaponSystem != null)
			{
				_weaponSystem.speed = _weaponSpeed
			}
		}

		public function increaseMovementSpeed(multiplier:Number):void
		{
			if (_movementSystem != null)
			{
				_movementSystem.increaseSpeed(multiplier);
                if(movementSystem is MovementBullet)
                    (_movementSystem as MovementBullet).updateVelocity();
			}
		}

        public function get maxHealth():Number
        {
            return _maxHealth;
        }

		public function setMovementSpeed():void
		{
			if (_movementSystem != null)
			{
				_movementSystem.speed = _movementSpeed;
			}
		}

        public function get isPlayer():Boolean
        {
            return (name == GameConstants.PLAYER);
        }

        public function get isBullet():Boolean
        {
            return (name.search(GameConstants.BULLET) != -1);
        }

	    public function get isPowerShot():Boolean
	    {
		    return (name == GameConstants.PLAYER_POWERSHOT);
	    }

        public function get isPowerUp():Boolean
        {
            return (name.search(GameConstants.POWERUP) != -1);
        }

        public function get isEnemy():Boolean
        {
            return (name == GameConstants.ENEMY && !isBullet);
        }

        public function get isCharger():Boolean
        {
            return (name == GameConstants.CHARGER);
        }

        public function get isVictim1():Boolean
        {
            return (name == GameConstants.VICTIM1);
        }

        public function get isVictim2():Boolean
        {
            return (name == GameConstants.VICTIM2);
        }

        public function get isVictim():Boolean
        {
            return (isVictim1 || isVictim2);
        }

        public function get isBoss1():Boolean
        {
            return (name == GameConstants.BOSS1 && !isBullet);
        }

	    public function get isBoss2():Boolean
	    {
		    return (name == GameConstants.BOSS2 && !isBullet);
	    }

	    public function get isBoss():Boolean
	    {
		    return (isBoss1 || isBoss2);
	    }

        public function get isMiniBoss():Boolean
        {
            return (name == GameConstants.MINIBOSS);
        }

        public function get isHostile():Boolean
        {
            return (isVictim || isEnemy || isCharger || isBoss1)
        }

        public function get canAttack():Boolean
        {
            return ((_movementSystem != null || (isBoss1 && MovementBoss.phase == MovementBoss.MELEE)) && !isVictim);
        }

        public function get canBeAttacked():Boolean
        {
            return (!getAnimatedModel(0).isDead && _canAttacked);
        }

        public function playAnimation(animation:String):void
        {
            for (var i:int=0;i<(_movieClip as DisplayObjectContainer).numChildren;i++)
                getAnimatedModel(i).playAnimation(animation);
        }

        public function set collisionMode(mode:String):void
        {
            _collisionMode = mode;
        }
        public function blink(a:int=1):void
        {
            _movieClip.filter = new ColorFilter(1, 0, 0);
            if(_name==GameConstants.PLAYER && a == GameConstants.blinkAmount(_name))
            {
                _canAttacked=false;
                Starling.juggler.delayCall(canAttackedTrue, GameConstants.playerBlinkInvulnerableTime);
            }
            a--;
            if(a>0)
            {
                Starling.juggler.delayCall(blink, (GameConstants.blinkDuration(_name)/((GameConstants.blinkAmount(_name)*2)-1))*2, a);
                Starling.juggler.delayCall(resetBlink, GameConstants.blinkDuration(_name)/((GameConstants.blinkAmount(_name)*2)-1));
            }
            else
                Starling.juggler.delayCall(resetBlink, GameConstants.blinkDuration(_name)/((GameConstants.blinkAmount(_name)*2)-1));
        }

        private function resetBlink():void
        {
            _movieClip.filter = null;
        }

        private function canAttackedTrue():void
        {
            _canAttacked = true;
        }
		public function get isSlowed():Boolean {
			return _isSlowed;
		}

		public function set isSlowed(value:Boolean):void {
			_isSlowed = value;
		}
	}
}