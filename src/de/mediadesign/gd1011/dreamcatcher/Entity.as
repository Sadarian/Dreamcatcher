package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IMovement;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.IWeapon;

	import flash.geom.Point;

	import starling.display.MovieClip;

	public class Entity
    {

        private var movementSystem:IMovement;
		private var weaponSystem:IWeapon;
	    private var _name:String;
		private var _position:Point;
		private var _moviClip:MovieClip;

        public function Entity(name:String, position:Point, movieClip:MovieClip, movementSystem:IMovement = null, weaponSystem:IWeapon = null)
        {
	        this._name = name;
	        this._position = position;
	        this._moviClip = movieClip;
	        this.movementSystem = movementSystem;
	        this.weaponSystem = weaponSystem;
	        init();
        }

		private function init():void
		{
			_moviClip.x = _position.x;
			_moviClip.y = _position.y;
		}

        public function move(deltaTime:Number):void
        {
	        _position = movementSystem.move(deltaTime, _position);
        }

        public function render():void
        {
	        _moviClip.x = _position.x;
	        _moviClip.y = _position.y;
        }

		public function shoot():void
		{
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
			return _moviClip;
		}
	}
}