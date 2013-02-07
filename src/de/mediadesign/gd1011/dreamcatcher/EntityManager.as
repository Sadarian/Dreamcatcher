package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementPlayer;

	import flash.geom.Point;

	public class EntityManager
    {
        private var _entities:Vector.<Entity>;

        public function EntityManager()
        {
            _entities = new Vector.<Entity>();
	        creatPlayer();
	        creatEntities();
        }

        public function destroyAllEntities():void
        {
            for each (var entity:Entity in _entities)
            {
                entity.destroy();
	            entity = null;
            }
        }

	    private function creatEntities():void
	    {
		    _entities.push(new Entity(GameConstants.bossName, new Point(500, 400), AssetManager.bossImage()));
		}

	    private function creatPlayer():void
	    {
		    _entities.push(new Entity(GameConstants.playerName,GameConstants.playerStartPosition, AssetManager.playerWalkCycle(), new MovementPlayer()));
	    }

	    public function getEntity(name:String):Entity
	    {
		    for each (var entity:Entity in _entities)
		    {
			    if (entity.getName() == name)
			    {
				    return entity
			    }
		    }
		    return null;
	    }

		public function get entities():Vector.<Entity> {
			return _entities;
		}
	}
}
