package de.mediadesign.gd1011.dreamcatcher.Interfaces
{
    import flash.geom.Point;

    public interface IWeapon
    {
        function set speed(value:Number):void

        function shoot(deltaTime:Number, position:Point, target:Object):void
	}
}
