package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementBullet;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementPlayer;

    import flash.geom.Point;

    public class EntityManager
    {
        private static var _singleton:EntityManager;
        private var _entities:Vector.<Entity>;

        public function EntityManager()
        {
            _singleton = this;
            _entities = new Vector.<Entity>();
	        creatPlayer();
        }

        public static function get singleton():EntityManager
        {
            return _singleton;
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

        public function createBullet(type:String, position:Point, target:Point):void
        {
           // _entities.push(new Entity(type, position, AssetsManager.getAnimatedModel(type), new MovementBullet(target)))
        }

	    private function creatPlayer():void
	    {
		    _entities.push(new Entity(GameConstants.getData(GameConstants.PLAYER_DATA), GameConstants.playerStartPosition));
	    }

	    public function getEntity(name:String):Entity
	    {
		    for each (var entity:Entity in _entities)
		    {
			    if (entity.name == "Player" )
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
