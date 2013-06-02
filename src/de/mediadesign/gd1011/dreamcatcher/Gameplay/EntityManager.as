package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.TestStuff.CollisionDummyBoxes;
    import de.mediadesign.gd1011.dreamcatcher.TestStuff.CollisionImage;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.View.LifeBarHandling;
	import flash.geom.Point;

	import starling.animation.Juggler;
	import starling.core.Starling;

    public class EntityManager
    {
        private var _entities:Vector.<Entity>;
		private var _unusedEntities:Vector.<Entity>;
		private var _lifeBars:Vector.<LifeBarHandling>;
		private static var self:EntityManager = null;
	    private var juggler:Juggler = Starling.juggler;

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
		}

        public function loadEntities(levelIndex:int = 1):void
        {
            createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
            _entities[0].switchWeapon(null);
            if(levelIndex==-1)
            {
                EndlessMode.reset();
                var endless:EndlessMode = EndlessMode.instance;
                trace(endless);
                return;
            }
            var loadingEntities:Array = GameConstants.loadSpawnData(levelIndex);
            var i:int;
            for(i=0;i<loadingEntities.length;i++)
                juggler.delayCall(createEntity, loadingEntities[i][0], loadingEntities[i][2], new Point(Starling.current.viewPort.width, loadingEntities[i][1]));
        }



	    public function createEntity(name:String, position:Point = null):Entity
	    {
		    if (position == null)
			    position = new Point(0, 0);
		    var tempEntity:Entity;
		    if(_unusedEntities.length > 0)
		    {
			    tempEntity = _unusedEntities.shift();
                if(tempEntity != null)
                    tempEntity.setData(GameConstants.getData(name), position);
                else
                    tempEntity = new Entity(GameConstants.getData(name), position);
		    }
            else
                tempEntity = new Entity(GameConstants.getData(name), position);

            _entities.push(tempEntity);

		    if (name == GameConstants.PLAYER || name == GameConstants.BOSS1 || name == GameConstants.BOSS2)
		    {
			    _lifeBars.push(new LifeBarHandling(tempEntity));
		    }

            if(Dreamcatcher.debugMode)
		        GameStage.gameStage.addChild(CollisionDummyBoxes.getDummy(tempEntity));

            GameStage.gameStage.addChildAt(tempEntity.movieClip, 5);
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

        /*
        public function rotatePowerUps(deltaTime:Number):void
        {
            var powerUps:Vector.<Entity> =  _entities.filter(allPowerUps);
            function allPowerUps(item:Entity, index:int, vector:Vector.<Entity>):Boolean
            {
                return (item.name.search(GameConstants.POWERUP) != -1)
            }
            var i:int = 0;
            for (i; i<powerUps.length; i++)
            {
                powerUps[i].movieClip.scaleX += deltaTime * Number(powerUps[i].movieClip.name);
                if(powerUps[i].movieClip.scaleX <= -1)
                    powerUps[i].movieClip.name = "1";
                else if(powerUps[i].movieClip.scaleX >= 1)
                    powerUps[i].movieClip.name = "-1";
            }
        }
        */

		public function get entities():Vector.<Entity>
        {
			return _entities;
		}

		public function get lifeBars():Vector.<LifeBarHandling> {
			return _lifeBars;
		}

	    public function removeAll():void
	    {
		    juggler.purge();

		    while (_entities.length > 0) {
			    for each (var entity:Entity in _entities) {
				    GameStage.gameStage.removeActor(entity.movieClip);
				    entity.removeMovieClip();
				    addUnusedEntity(entity);
			    }
		    }

		    for each (var lifeBar:LifeBarHandling in _lifeBars)
		    {
				lifeBar.removeLiveBar();
			    lifeBar = null;
		    }
	    }
    }
}
