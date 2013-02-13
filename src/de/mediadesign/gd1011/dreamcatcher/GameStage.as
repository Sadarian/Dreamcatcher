package de.mediadesign.gd1011.dreamcatcher
{
	import starling.display.MovieClip;
	import starling.display.Sprite;

	public class GameStage  extends Sprite
	{
		private static var self:GameStage;
		private static var typeImage:Vector.<Boolean> = new <Boolean>[true,  true,  false,  true,  true];

		private var containerGroup:Vector.<StageContainer>;

		public var bossStage:Boolean = false;

		private var player:Entity;
		private var boss:Entity;
        private var enemy:Entity;
        private var victim:Entity;

		public function GameStage()
		{
			player = EntityManager.entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
			boss = EntityManager.entityManager.createEntity(GameConstants.BOSS, GameConstants.bossStartPosition);
            enemy = EntityManager.entityManager.createEntity(GameConstants.ENEMY, GameConstants.enemyStartPosition);
            victim = EntityManager.entityManager.createEntity(GameConstants.VICTIM, GameConstants.victimStartPosition);

			containerGroup = new Vector.<StageContainer>(5);
		}

		public function init():void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
				containerGroup[i] = new StageContainer((typeImage[i]?StageContainer.LIST_TYPE_IMAGE:StageContainer.LIST_TYPE_CONTAINER));
		}

		public function loadLevel(levelIndex:int = 1):void
		{
			var vector:Array = [];
			var vectorBoss:Array = [];
			switch(levelIndex)
			{
				case 1:
				{
					vector.push(GameConstants.BACKGROUND_IMAGE_LIST,
								GameConstants.MAIN_STAGE_IMAGE_LIST,
								GameConstants.ANIMATIONS_LIST,
								GameConstants.BUSH_IMAGE_LIST,
								GameConstants.FOREGROUND_IMAGE_LIST);

					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,
							GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
							GameConstants.ANIMATIONS_LIST_BOSS,
							GameConstants.BUSH_IMAGE_LIST_BOSS,
							GameConstants.FOREGROUND_IMAGE_LIST_BOSS);

					createLevel(vector, vectorBoss);
					break;
				}
			}
		}

		private function createLevel(vector:Array, vectorBoss:Array):void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
			{
				containerGroup[i].fill(vector[i], false);
				containerGroup[i].fill(vectorBoss[i], true);
				this.addChild(containerGroup[i]);
			}
			addChild(player.movieClip);
			addChild(boss.movieClip);
			addChild(enemy.movieClip);
			addChild(victim.movieClip);
		}

		public function moveGameStage(movementSpeedVector:Vector.<Number>):void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
			{
				containerGroup[i].move(movementSpeedVector[i]);
				containerGroup[i].swap(bossStage);
			}
		}

		public static function get gameStage():GameStage {
			if(self == null)
			{
				self = new GameStage();
			}
			return self;
		}

		public function removeActor(movieClip:MovieClip):void
		{
			removeChild(movieClip);
		}
	}
}