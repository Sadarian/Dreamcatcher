package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.TestStuff.CollisionDummyBoxes;
    import de.mediadesign.gd1011.dreamcatcher.TestStuff.CollisionImage;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.View.LifeBarHandling;
    import flash.geom.Point;
    import starling.core.Starling;

    public class EntityManager
    {
        private var _entities:Vector.<Entity>;
		private var _unusedEntities:Vector.<Entity>;
		private var _lifeBars:Vector.<LifeBarHandling>;
		private static var self:EntityManager = null;

        public function EntityManager()
        {
            _entities = new Vector.<Entity>();
	        _unusedEntities = new Vector.<Entity>();
	        _lifeBars = new Vector.<LifeBarHandling>();
        }
		public static function get entityManager():EntityManager
		{
			if(!self)
			{
				self = new EntityManager();
			}
			return self;
		}

		public function init():void
		{
			createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
		}

        public function loadEntities(levelIndex:int = 1):void
        {
            var loadingEntities:Array = GameConstants.loadSpawnData(levelIndex);
            for(var i:int = 0;i<loadingEntities.length;i++)
            {
                Starling.current.juggler.delayCall(createEntity, loadingEntities[i][0], loadingEntities[i][2], new Point(Starling.current.viewPort.width, loadingEntities[i][1]));
            }
        }

	    public function createEntity(name:String, position:Point = null):Entity
	    {
		    if (position == null)
			    position = new Point(0, 0);
		    var tempEntity:Entity;
		    if(_unusedEntities.length > 0)
		    {
			    tempEntity = _unusedEntities.shift();
			    if (tempEntity.movieClip)
				    tempEntity.removeMovieClip();
		    }
            tempEntity = new Entity(GameConstants.getData(name), position);

            _entities.push(tempEntity);

		    if (name == GameConstants.PLAYER || name == GameConstants.BOSS)
		    {
			    _lifeBars.push(new LifeBarHandling(tempEntity));
		    }

            if(Dreamcatcher.debugMode)
		        GameStage.gameStage.addChild(CollisionDummyBoxes.getDummy(tempEntity));

            GameStage.gameStage.addChildAt(tempEntity.movieClip, 4);
            return tempEntity;
		}

		public function addUnusedEntity(entity:Entity):void
		{
			_entities.splice(_entities.indexOf(entity),1);

            if(Dreamcatcher.debugMode)
            {
                for each (var image:CollisionImage in CollisionDummyBoxes.dummies) {
                    if (entity.name == image.entityName) {
                        GameStage.gameStage.removeChild(image);
                        CollisionDummyBoxes.dummies.splice(CollisionDummyBoxes.dummies.indexOf(image), 1);
                        image.dispose();
                    }
                }
            }

			_unusedEntities.push(entity);
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

		public function get lifeBars():Vector.<LifeBarHandling> {
			return _lifeBars;
		}
	}
}
