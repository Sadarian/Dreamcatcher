package de.mediadesign.gd1011.dreamcatcher
{

	import de.mediadesign.gd1011.dreamcatcher.GameConstants;

	import org.osmf.media.MediaPlayer;

	import starling.display.Sprite;
    import starling.events.Event;

    public class EntityManager
    {
        private var entities:Vector.<Entity>;
	    private var player:Entity

        public function EntityManager()
        {
            entities = new Vector.<Entity>();
	        //creatEntities();
        }

	    private function creatEntities():void {
		    entities.concat(new Entity(GameConstants.playerName));
	    }

        public function update():void
        {
            for (var i:int = 0;i<entities.length;i++)
                entities[i].update()
        }

        public function destroy():void
        {
            for (var i:int=0;i<entities.length;i++)
                entities[i].destroy();
        }
    }
}
