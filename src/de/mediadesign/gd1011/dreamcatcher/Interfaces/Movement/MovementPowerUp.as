package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;

    import flash.geom.Point;

	public class MovementPowerUp implements IMovement
	{
		private var _speed:Number;

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
            return position.add(new Point((_speed * GameStage.gameStage.movementSpeeds[0] * Math.cos(0) * deltaTime)*-1, _speed * GameStage.gameStage.movementSpeeds[0]  * Math.sin(0) * deltaTime));
		}
	}
}
