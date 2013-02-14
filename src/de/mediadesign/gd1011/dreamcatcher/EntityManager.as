package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Entity;

	import flash.geom.Point;

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
	        initGame(new Array(GameConstants.ENEMY, GameConstants.ENEMY));
        }

		public static function get entityManager():EntityManager
		{
			if(self == null)
			{
				self = new EntityManager();
			}
			return self;
		}

		private function initGame(initEntities:Array):void {
			for each (var name:String in initEntities) {
				_unusedEntities.push(new Entity(GameConstants.getData(name), new Point(0, 0)));
			}
		}

		public function initGameEntites():void
		{
			createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
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
				    tempEntity.removeMoviclip();
		    }
            tempEntity = new Entity(GameConstants.getData(name), position);

            _entities.push(tempEntity);

		    if (name == GameConstants.PLAYER || name == GameConstants.BOSS)
		    {
			    _lifeBars.push(new LifeBarHandling(tempEntity));
		    }

		    GameStage.gameStage.addChild(CollisionDummyBoxes.getDummy(tempEntity));
            GameStage.gameStage.addChildAt(tempEntity.movieClip, GameStage.gameStage.numChildren-3);
            return tempEntity;
		}

		public function addUnusedEntity(entity:Entity):void
		{
			_entities.splice(_entities.indexOf(entity),1);
			for each (var image:CollisionImage in CollisionDummyBoxes.dummies) {
				if (entity.name == image.entityName) {
					GameStage.gameStage.removeChild(image);
					CollisionDummyBoxes.dummies.splice(CollisionDummyBoxes.dummies.indexOf(image), 1);
					image.dispose();
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
