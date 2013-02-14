package de.mediadesign.gd1011.dreamcatcher
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import flash.geom.Rectangle;
	import flash.html.ControlInitializationError;
	import flash.trace.Trace;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;

	import org.osmf.events.TimeEvent;
	import starling.display.MovieClip;
	import starling.display.Sprite;

	public class GameStage  extends Sprite
	{
		private static var self:GameStage;
		private static var typeImage:Vector.<Boolean> = new <Boolean>[true, true, false, false, true, true];

		private var containerGroup:Vector.<StageContainer>;

		public var bossStage:Boolean = false;

		private var player:Entity;
		private var boss:Entity;
        private var enemy:Entity;
        private var victim:Entity;

		private var timer:Timer;

		private var movementSpeeds:Vector.<Number>;

		public function GameStage()
		{

			//GameStage On which the Actors move

			var viewPort:Rectangle = Starling.current.viewPort;

			movementSpeeds = GameConstants.GAME_STAGE_MOVMENT_SPEEDS.concat();

			player = EntityManager.entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
			boss = EntityManager.entityManager.createEntity(GameConstants.BOSS, GameConstants.bossStartPosition);
            enemy = EntityManager.entityManager.createEntity(GameConstants.ENEMY, GameConstants.enemyStartPosition);
            victim = EntityManager.entityManager.createEntity(GameConstants.VICTIM, GameConstants.victimStartPosition);

			containerGroup = new Vector.<StageContainer>(6);
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
								GameConstants.FOG_LIST,
								GameConstants.BUSH_IMAGE_LIST,
								GameConstants.FOREGROUND_IMAGE_LIST);

					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,
							GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
							GameConstants.ANIMATIONS_LIST_BOSS,
							GameConstants.FOG_LIST_BOSS,
							GameConstants.BUSH_IMAGE_LIST_BOSS,
							GameConstants.FOREGROUND_IMAGE_LIST_BOSS);

					createLevel(vector, vectorBoss);
					break;
				}
			}
			init();
		}

		private function createLevel(vector:Array, vectorBoss:Array):void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
			{
				containerGroup[i].fill(vector[i], false);
				containerGroup[i].fill(vectorBoss[i], true);
				addChild(containerGroup[i]);
			}

			addChild(player.movieClip);
			addChild(boss.movieClip);
			addChild(enemy.movieClip);
			addChild(victim.movieClip);

		}

		public function moveGameStage():void
		{
			for(var i:int = 0;i<containerGroup.length;i++)
			{
				containerGroup[i].move(movementSpeeds[i]);
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

		public function switchToBoss():void
		{
			var delay:Number;

			if(containerGroup[0].getChildAt(0).x < containerGroup[0].getChildAt(1).x)
			{
				delay = containerGroup[0].getChildAt(0).x + (2*containerGroup[0].getChildAt(0).width);
				delay /=GameConstants.GAME_STAGE_MOVMENT_SPEEDS[0];
			}

			bossStage = true;
			timer = new Timer(delay / 60 * 1000);
			timer.addEventListener(TimerEvent.TIMER, beginReduction);
			timer.start();
		}

		private function beginReduction(event:TimerEvent):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, beginReduction);
			timer = null;
			timer = new Timer(GameConstants.BOSS_SPEED_REDUCTION, 100);
			timer.addEventListener(TimerEvent.TIMER, reduceMovementSpeed);
			timer.start();
		}

		private function reduceMovementSpeed(event:TimerEvent):void

		{
			for (var i:int = 0; i < movementSpeeds.length; i++)
				movementSpeeds[i] -= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[i]/100;
		}
	}
}