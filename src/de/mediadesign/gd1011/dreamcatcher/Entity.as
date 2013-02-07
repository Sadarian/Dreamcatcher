package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IMovement;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IWeapon;
//    import de.mediadesign.gd1011.dreamcatcher.Interfaces.WeaponPlayer;

    import flash.geom.Point;

	import starling.display.MovieClip;

	public class Entity
    {

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
            if(movementSystem)
	            _position = movementSystem.move(deltaTime, _position);
        }

        public function render():void
        {
	        _movieClip.x = _position.x - _movieClip.width/2;
	        _movieClip.y = _position.y - _movieClip.height/2;
        }

		public function shoot(deltaTime:Number):void
		{
//            if(weaponSystem)
//            {
//                fireTime += deltaTime;
//                if (fireTime>=fireRate)
//                {
//                    fireTime -= fireRate;
//                    weaponSystem.shoot(_position);
//                }
//            }
        }

		public function switchMovement(movementSystem:IMovement):void {
			this.movementSystem = movementSystem;
		}

		public function switchWeapon(weaponSystem:IWeapon):void {
			this.weaponSystem = weaponSystem;
		}

		public function destroy():void
		{
			movementSystem = null;
			weaponSystem = null;
		}

	    public function getName():String
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
    }
}