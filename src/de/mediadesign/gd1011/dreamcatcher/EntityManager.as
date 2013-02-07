package de.mediadesign.gd1011.dreamcatcher
{
	public class EntityManager
    {
        private var _entities:Vector.<Entity>;

        public function EntityManager()
        {
            _entities = new Vector.<Entity>();
	        createPlayer();
	        createEntity();
        }

        public function destroyAllEntities():void
        {
            for each (var entity:Entity in _entities)
            {
                entity.destroy();
	            entity = null;
            }
        }

	    private function createEntity():void
	    {
		   // _entities.push(new Entity(GameConstants.bossName, new Point(500, 400), AssetManager.bossImage()));
		}

	    private function createPlayer():void
	    {
		    _entities.push(new Entity(GameConstants.getData(GameConstants.PLAYER_DATA), GameConstants.playerStartPosition));
	    }

	    public function getEntity(name:String):Entity
	    {
		    for each (var entity:Entity in _entities)
		    {
			    if (entity.name == name)
			    {
				    return entity;
			    }
		    }
		    return null;
	    }

		public function get entities():Vector.<Entity>
        {
			return _entities;
		}
	}
}
