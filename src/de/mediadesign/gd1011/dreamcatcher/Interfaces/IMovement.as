package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;

    public interface IMovement
    {
        function move(deltaTime:Number, position:Point):Point
    }
}
