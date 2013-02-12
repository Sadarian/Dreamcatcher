package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.EntityManager;
	import de.mediadesign.gd1011.dreamcatcher.EntityManager;

	import flash.geom.Rectangle;
	import flash.trace.Trace;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;

	public class GameStage  extends Sprite {
		private static var self:GameStage;

		private var animationBoxOne:Sprite = new Sprite();
		private var animationBoxTwo:Sprite = new Sprite();
		private var animationBoxTree:Sprite = new Sprite();

		private var mainStageContentList:Vector.<Image> = new Vector.<Image>;
		private var bushContentList:Vector.<Image> = new Vector.<Image>;
		private var backgroundContentList:Vector.<Image> = new Vector.<Image>;
		private var foregroundContentList:Vector.<Image> = new Vector.<Image>;
		private var animationContentList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;

		private var backgroundContainerOne:Sprite = new Sprite();
		private var backgroundContainerTwo:Sprite = new Sprite();

		private var mainStageContainerOne:Sprite = new Sprite();
		private var mainStageContainerTwo:Sprite = new Sprite();

		private var animationContainerOne:Sprite = new Sprite();
		private var animationContainerTwo:Sprite = new Sprite();

		private var bushContainerOne:Sprite = new Sprite();
		private var bushContainerTwo:Sprite = new Sprite();

		private var foregroundContainerOne:Sprite = new Sprite();
		private var foregroundContainerTwo:Sprite = new Sprite();

		private var firstContainerList:Vector.<DisplayObjectContainer> = new <DisplayObjectContainer>[	mainStageContainerOne,
																										animationContainerOne,
																										bushContainerOne,
																										foregroundContainerOne,
																										backgroundContainerOne];

		private var secondContainerList:Vector.<DisplayObjectContainer> = new <DisplayObjectContainer>[	mainStageContainerTwo,
																										animationContainerTwo,
																										bushContainerTwo,
																										foregroundContainerTwo,
																										backgroundContainerTwo];

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
			//GameStage On which the Actors move

			var viewPort:Rectangle = Starling.current.viewPort;

			for each (var container:DisplayObjectContainer in firstContainerList)
			{
				container.width  	= viewPort.width;
				container.height 	= viewPort.height;
				container.x			= 0;
			}

			for each (container in secondContainerList)
			{
				container.width  	= viewPort.width;
				container.height 	= viewPort.height;
				container.x			= viewPort.width;
			}
		}

		public function loadLevel(levelIndex:int = 1):void
		{
			switch(levelIndex)
			{
				case 1:
				{
					createLevel(GameConstants.GAME_STAGE_IMAGE_LIST,
								GameConstants.GAME_STAGE_ANIMATIONS_IMAGE_LIST,
								GameConstants.GAME_STAGE_FRONT_IMAGE_LIST,
								GameConstants.GAME_STAGE_BACKGROUND_IMAGE_LIST,
								GameConstants.GAME_STAGE_FOREGROUND_IMAGE_LIST);
					break;
				}
			}
		}

		private function createLevel(gameStageImageList:Vector.<String>,
									gameStageAnimImageList:Vector.<String>,
									gameStageFrontImageList:Vector.<String>,
									backgroundImageList:Vector.<String>,
									foregroundImageList:Vector.<String>):void
		{
			var containerIndex:int = 0;

			for each ( var ImageEntry:String in gameStageImageList )
			{
				var newGameStageImage:Image = AssetsManager.getImage(ImageEntry)
				mainStageContentList.push(newGameStageImage);
			}
			for each ( var ImageEntry:String in backgroundImageList )
			{
				var newGameStageImage:Image = AssetsManager.getImage(ImageEntry)
				backgroundContentList.push(newGameStageImage);
			}
			for each ( var ImageEntry:String in foregroundImageList )
			{
				var newGameStageImage:Image = AssetsManager.getImage(ImageEntry)
				foregroundContentList.push(newGameStageImage);
			}

			for each (ImageEntry in gameStageAnimImageList )
			{
				containerIndex++
				newGameStageImage = AssetsManager.getImage(ImageEntry)

					if(containerIndex == 1)
					{
						animationBoxOne.addChild(newGameStageImage);
					}
					else if (containerIndex == 2)
					{
						animationBoxTwo.addChild(newGameStageImage);
					}
					else if (containerIndex == 3)
					{
						animationBoxTree.addChild(newGameStageImage);
						containerIndex =0;
					}
			}

				animationContentList.push(animationBoxOne);
				animationContentList.push(animationBoxTwo);
				animationContentList.push(animationBoxTree);

			for each (ImageEntry in gameStageFrontImageList )
			{
				var newGameStageFrontImage:Image = AssetsManager.getImage(ImageEntry)
				bushContentList.push(newGameStageFrontImage);
			}

			backgroundContainerOne.addChild(backgroundContentList.shift());
			backgroundContainerTwo.addChild(backgroundContentList.shift());

			mainStageContainerOne.addChild(mainStageContentList.shift());
			mainStageContainerTwo.addChild(mainStageContentList.shift());

			animationContainerOne.addChild(animationContentList.shift());
			animationContainerTwo.addChild(animationContentList.shift());

			bushContainerOne.addChild(bushContentList.shift());
			bushContainerTwo.addChild(bushContentList.shift());

			foregroundContainerOne.addChild(foregroundContentList.shift());
			foregroundContainerTwo.addChild(foregroundContentList.shift());


			addChild(backgroundContainerOne);
			addChild(backgroundContainerTwo);

			addChild(mainStageContainerOne);
			addChild(mainStageContainerTwo);

			addChild(animationContainerOne);
			addChild(animationContainerTwo)

			addChild(player.movieClip);
			addChild(boss.movieClip);
            addChild(enemy.movieClip);
            addChild(victim.movieClip);

			addChild(bushContainerOne);
			addChild(bushContainerTwo);

			addChild(foregroundContainerOne);
			addChild(foregroundContainerTwo);

		}

		private function swapContainerContent(container:DisplayObjectContainer,
											  ContentImageList:Vector.<Image>,
											  ContentContainerList:Vector.<DisplayObjectContainer> = null):void
		{
			if (ContentImageList)
			{
				trace("Swaping Image");
				var randomNumber:Number = Math.random()*10;
				var resizedInt:int = int(randomNumber);

				if (resizedInt <= 4)
				{
					ContentImageList.push(container.removeChildAt(0));
					container.addChildAt(ContentImageList.shift(),0);
				}
				else
				{
					ContentImageList.push(container.removeChildAt(0));
					container.addChildAt(ContentImageList.pop(),0);
				}
			}
			else if (ContentContainerList)
			{
				trace("Swaping Container");
				var randomNumber:Number = Math.random()*10;
				var resizedInt:int = int(randomNumber);

				if (resizedInt <= 4)
				{
					ContentContainerList.push(container.removeChildAt(0));
					container.addChildAt(ContentContainerList.shift(),0);
				}
				else
				{
					ContentContainerList.push(container.removeChildAt(0));
					container.addChildAt(ContentContainerList.pop(),0);
				}
			}
		}

		private function moveContainer(containerOne:DisplayObjectContainer,
									   containerTwo:DisplayObjectContainer,speed:Number):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);

			(containerOne.x>-containerOne.width)? containerOne.x -= resizedSpeed:containerOne.x = containerTwo.x+(containerOne.width) -resizedSpeed;
			(containerTwo.x>-containerTwo.width)?containerTwo.x -= resizedSpeed:containerTwo.x = containerOne.x+(containerOne.width) - resizedSpeed;

		}

		private function checkContainerPosition(containerOne:DisplayObjectContainer,containerTwo:DisplayObjectContainer,contentImageList:Vector.<Image> = null,contentContainerList:Vector.<DisplayObjectContainer> = null):void
		{
			if (contentImageList)
			{
				if (containerOne.x == -containerOne.width)
				{
					swapContainerContent(containerOne,contentImageList);
				}
				else if (containerTwo.x == -containerTwo.width)
				{
					swapContainerContent(containerTwo,contentImageList);
				}
			}
			else if(contentContainerList)
			{
				if (containerOne.x == -containerOne.width)
				{
					swapContainerContent(containerOne,null,contentContainerList);
				}
				else if (containerTwo.x == -containerTwo.width)
				{
					swapContainerContent(containerTwo,null,contentContainerList);
				}
			}
		}

		private function  resizeSpeed(speed:Number):Number
		{
			var newSpeed:Number = Math.min(100, speed);
			return newSpeed;
		}

		public function moveGameStage(movementSpeedVector:Vector.<Number>):void
		{
			moveContainer(mainStageContainerOne,mainStageContainerTwo,movementSpeedVector[0]);
			moveContainer(bushContainerOne,bushContainerTwo,movementSpeedVector[1]);
			moveContainer(animationContainerOne,animationContainerTwo,movementSpeedVector[2]);
			moveContainer(backgroundContainerOne,backgroundContainerTwo,movementSpeedVector[3]);
			moveContainer(foregroundContainerOne,foregroundContainerTwo,movementSpeedVector[4]);

			checkContainerPosition(mainStageContainerOne,mainStageContainerTwo,mainStageContentList);
			checkContainerPosition(bushContainerOne,bushContainerTwo,bushContentList);
			checkContainerPosition(animationContainerOne,animationContainerTwo,null,animationContentList);
			checkContainerPosition(mainStageContainerOne,mainStageContainerTwo,mainStageContentList);
			checkContainerPosition(backgroundContainerOne,backgroundContainerTwo,backgroundContentList);
			checkContainerPosition(foregroundContainerOne,foregroundContainerTwo,foregroundContentList );

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