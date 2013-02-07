package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IMovement;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IWeapon;
    import flash.geom.Point;
	import starling.display.MovieClip;

	public class Entity
    {
        //JSON-Config Data:
        private var _name:String;
        private var _health:Number;
        private var _movementSystem:IMovement;
        private var _weaponSystem:IWeapon;
        private var _collisionMode:String;
        private var _collisionPoint:Point;
        private var _collisionValues:Array;
        private var _movieClip:MovieClip; //added via JSON but it isn't in the Config!

       //Additional Constructor Data:
        private var _position:Point;

        public function Entity(jsonConfig:Array, position:Point)
        {
	        _name = jsonConfig[0];
            _health = jsonConfig[1];

            _movementSystem = jsonConfig[2];
            if(_movementSystem)
                _movementSystem.speed = jsonConfig[3];

            _weaponSystem = jsonConfig[4];
            if(_weaponSystem)
                _weaponSystem.speed = jsonConfig[5];

            _collisionMode = jsonConfig[6];
            _collisionPoint = jsonConfig[7];
            _collisionValues = jsonConfig[8];

            _movieClip = jsonConfig[9];

            _position = position;

	        init();
        }

		private function init():void
		{
			_movieClip.x = _position.x - _movieClip.width/2;
			_movieClip.y = _position.y - _movieClip.height/2;
		}

        public function move(deltaTime:Number):void
        {
            if(_movementSystem)
	            _position = _movementSystem.move(deltaTime, _position);
        }

        public function render():void
        {
            if(_movementSystem)
            {
                _movieClip.x = _position.x - _movieClip.width/2;
                _movieClip.y = _position.y - _movieClip.height/2;
            }
        }

		public function shoot(deltaTime:Number):void
		{
            if(_weaponSystem)
                _weaponSystem.shoot(_position, null);
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

		public function get movieClip():MovieClip
        {
			return _movieClip;
		}

        public function get collisionMode():String
        {
            return _collisionMode;
        }
    }
}