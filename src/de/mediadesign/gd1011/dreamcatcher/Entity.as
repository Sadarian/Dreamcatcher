package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.IMovement;

    public class Entity
    {

        private var movementSystem:IMovement;
	    private var name:String;

        public function Entity(name:String, movementSystem:IMovement = null)
        {
	        this.name = name;
        }

        public function update():void
        {
        }

        public function destroy():void
        {
        }
    }
}