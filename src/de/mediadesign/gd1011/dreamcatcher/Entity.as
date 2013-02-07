package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IMovement;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IWeapon;
//    import de.mediadesign.gd1011.dreamcatcher.Interfaces.WeaponPlayer;

    import flash.geom.Point;

	import starling.display.MovieClip;

	public class Entity
    {
        //JSON-Config Data:
        private var _name:String;
        private var _health:Number;
        private var _movementSystem:IMovement;
        private var _movementSpeed:Number;
        private var _weaponSystem:IWeapon;
        private var _weaponSpeed:Number;
        private var _collisionMode:String;
        private var _collisionPoint:Point;
        private var _collisionValues:Array;
        private var _movieClip:MovieClip; //added via JSON but it isn't in the Config!

<<<<<<< HEAD
        private var movementSystem:IMovement;
		private var weaponSystem:IWeapon;
	    private var _name:String;
		private var _position:Point;
		private var _movieClip:MovieClip;
        private var fireRate:Number;
        private var fireTime:Number;
        private var _collisionMode:String;


        public function Entity(name:String, position:Point, movieClip:MovieClip, movementSystem:IMovement = null, weaponSystem:IWeapon = null, fireRate:Number = 0)
        {
	        this._name = name;
	        this._position = position;
	        this._movieClip = movieClip;
	        this.movementSystem = movementSystem;
	        this.weaponSystem = weaponSystem;
            this.fireRate = fireRate;
=======
        //Additional Constructor Data:
        private var _position:Point;

        //Initialization during construction
        private var fireTime:Number;
        private var target:Point;

        public function Entity(jsonConfig:Array, position:Point)
        {
	        _name = jsonConfig[0];
            _health = jsonConfig[1];
            _movementSystem = jsonConfig[2];
            _movementSpeed = jsonConfig[3];
            _weaponSystem = jsonConfig[4];
            _weaponSpeed = jsonConfig[5];
            _collisionMode = jsonConfig[6];
            _collisionPoint = jsonConfig[7];
            _collisionValues = jsonConfig[8];
            _movieClip = jsonConfig[9];

            _position = position;

            fireTime = 0;
            target = null;

>>>>>>> feature/shooting
	        init();

            //Test for Player:
            this.fireRate = 250;
//            this.weaponSystem = new WeaponPlayer();
        }

		private function init():void
		{
			_movieClip.x = _position.x - _movieClip.width/2;
			_movieClip.y = _position.y - _movieClip.height/2;
		}

        public function move(deltaTime:Number):void
        {
<<<<<<< HEAD
            if(movementSystem)
	            _position = movementSystem.move(deltaTime, _position);
=======
            if(_movementSystem)
	            _position = _movementSystem.move(deltaTime, _position, _movementSpeed);
>>>>>>> feature/shooting
        }

        public function render():void
        {
<<<<<<< HEAD
	        _movieClip.x = _position.x - _movieClip.width/2;
	        _movieClip.y = _position.y - _movieClip.height/2;
=======
            if(_movementSystem)
            {
                _movieClip.x = _position.x - _movieClip.width/2;
                _movieClip.y = _position.y - _movieClip.height/2;
            }
>>>>>>> feature/shooting
        }

		public function shoot(deltaTime:Number):void
		{
<<<<<<< HEAD
//            if(weaponSystem)
//            {
//                fireTime += deltaTime;
//                if (fireTime>=fireRate)
//                {
//                    fireTime -= fireRate;
//                    weaponSystem.shoot(_position);
//                }
//            }
=======
            if(_weaponSystem)
            {
                fireTime += deltaTime;
                if (fireTime>=_weaponSpeed)
                {
                    fireTime -= _weaponSpeed;
                    _weaponSystem.shoot(_position, (_name!="Player")?target:null);
                }
            }
>>>>>>> feature/shooting
        }

		public function switchMovement(movementSystem:IMovement):void {
			this._movementSystem = movementSystem;
		}

		public function switchWeapon(weaponSystem:IWeapon):void {
			this._weaponSystem = weaponSystem;
		}

		public function destroy():void
		{
			_movementSystem = null;
			_weaponSystem = null;
		}

	    public function get name():String
	    {
		    return _name;
	    }

		public function getMoviClip():MovieClip {
			return _movieClip;
		}

        public function get collisionMode():String
        {
            return _collisionMode;
        }
<<<<<<< HEAD
=======

        public function setTargetPoint(point:Point):void
        {
            target = point;
        }
>>>>>>> feature/shooting
    }
}