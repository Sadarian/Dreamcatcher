package de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement
{
	import flash.geom.Point;

    public interface IMovement
    {
        function set speed(value:Number):void

	    function increaseSpeed(multiplier:Number):void;

        function move(deltaTime:Number, position:Point):Point
    }
}
