package de.mediadesign.gd1011.dreamcatcher
{

    public class EntityManager
    {
        private var _entities:Vector.<Entity>;

        public function EntityManager()
        {
            _entities = new Vector.<Entity>();
	        creatPlayer();
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
		}

	    private function creatPlayer():void
	    {
		    _entities.push(new Entity(GameConstants.playerName,GameConstants.playerStartPosition, AssetManager.playerWalkCycle()));
	    }

	    public function getEntity(name:String):Entity
	    {
		    for each (var entity:Entity in _entities)
		    {
			    if (entity.getName() == GameConstants.playerName )
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
