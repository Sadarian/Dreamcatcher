package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.IMovement;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.IWeapon;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

    import flash.geom.Point;
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

       //Additional Constructor Data:
        private var _position:Point;

        public function Entity(jsonConfig:Array, position:Point)
        {
	        setData(jsonConfig, position);

	        init();
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
		}

		private function init():void
		{
			_movieClip.x = _position.x;
			_movieClip.y = _position.y;
		}

        public function move(deltaTime:Number):void
        {
            if(_movementSystem)
            {
                _position = _movementSystem.move(deltaTime, _position);
                if(isVictim && !(_movementSystem as MovementVictim).onInit && getAnimatedModel(0).ActualAnimation.name == AnimatedModel.EAT)
                    playAnimation(AnimatedModel.FEAR);
            }
        }

        public function render():void
        {
            if(_movementSystem)
            {
                _movieClip.x = _position.x;
                _movieClip.y = _position.y;
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
			_movieClip = null;
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

        public function getAnimatedModel(index:int = 0):de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel
        {
            return ((_movieClip as DisplayObjectContainer).getChildAt(index) as de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel);
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

        public function get isPowerUp():Boolean
        {
            return (name.search(GameConstants.POWERUP) != -1);
        }

        public function get isEnemy():Boolean
        {
            return (name == GameConstants.ENEMY && !isBullet);
        }

        public function get isVictim():Boolean
        {
            return (name == GameConstants.VICTIM1);
        }

        public function get isBoss():Boolean
        {
            return (name == GameConstants.BOSS1 && !isBullet);
        }

        public function get isHostile():Boolean
        {
            return (isVictim || isEnemy || isBoss)
        }

        public function get canAttack():Boolean
        {
            return _weaponSystem != null;
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
	}
}