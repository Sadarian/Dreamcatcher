package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
	import flash.geom.Point;

    public interface IMovement
    {
        function set speed(value:Number):void

        function move(deltaTime:Number, position:Point):Point
    }
}
