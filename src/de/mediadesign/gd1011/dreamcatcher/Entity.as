package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.IMovement;
    import starling.display.Sprite;

    public class Entity extends Sprite
    {
        private var movementSystem:IMovement

        public function Entity(x:Number = 0, y:Number = 0, movementSystem:IMovement = null)
        {
            this.x = x;
            this.y = y;
            this.movementSystem = movementSystem;
        }

        public function update():void
        {
        }

        public function destroy():void
        {
        }
    }
}
