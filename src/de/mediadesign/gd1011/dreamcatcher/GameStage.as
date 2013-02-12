package de.mediadesign.gd1011.dreamcatcher
{
	import flash.geom.Rectangle;
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

		public var bossStage:Boolean = false;


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

		public function changeSetting(ContentImageList:Vector.<Image>,
									  ContentContainerList:Vector.<DisplayObjectContainer> = null):void
		{
			if(ContentImageList == mainStageContentList )
			{
				fillLists(GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,mainStageContentList);
			}
			if(ContentImageList == bushContentList)
			{
				fillLists(GameConstants.BUSH_IMAGE_LIST_BOSS,bushContentList);
			}
			if(ContentImageList == backgroundContentList)
			{
				fillLists(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,backgroundContentList);
			}
			if(ContentImageList == foregroundContentList)
			{
				fillLists(GameConstants.FOREGROUND_IMAGE_LIST_BOSS,foregroundContentList);
			}
			if(ContentContainerList == animationContentList)
			{
				fillLists(GameConstants.ANIMATIONS_LIST_BOSS,null,animationContentList);
			}

		}

		public function loadLevel(levelIndex:int = 1):void
		{
			switch(levelIndex)
			{
				case 1:
				{
					createLevel(GameConstants.MAIN_STAGE_IMAGE_LIST,
								GameConstants.ANIMATIONS_LIST,
								GameConstants.BUSH_IMAGE_LIST,
								GameConstants.BACKGROUND_IMAGE_LIST,
								GameConstants.FOREGROUND_IMAGE_LIST);
					break;
				}
			}
		}

		private function fillLists(listsContent:Vector.<String>,imageList:Vector.<Image> = null ,containerList:Vector.<DisplayObjectContainer> = null):void
		{
			var Entry:String

			if (imageList)
			{
				for each ( Entry in listsContent )
				{
					var newGameStageImage:Image = AssetsManager.getImage(Entry);
					imageList.push(newGameStageImage);
				}
			}
			else if (containerList)
			{
				var containerIndex:int = 0;
				for each ( Entry in listsContent )
				{
					containerIndex++
					var newGameStageImage = AssetsManager.getImage(Entry);

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

				containerList.push(animationBoxOne);
				containerList.push(animationBoxTwo);
				containerList.push(animationBoxTree);
			}
		}

		private function emptyLists(imageList:Vector.<Image> = null ,containerList:Vector.<DisplayObjectContainer> = null):void
		{
			var ImageEntry:Image;
			var ContainerEntry:DisplayObjectContainer;

			if (imageList)
			{
				for each ( ImageEntry in imageList )
				{
					var newGameStageImage:Image = imageList.shift();
					newGameStageImage.dispose();
				}
			}
			else if (containerList)
			{
				var containerIndex:int = 0;
				for each ( ContainerEntry in containerList )
				{
					var animationBox:DisplayObjectContainer = containerList.shift();
					animationBox.dispose();
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

			fillLists(gameStageImageList,mainStageContentList);
			fillLists(backgroundImageList,backgroundContentList);
			fillLists(foregroundImageList,foregroundContentList);
			fillLists(gameStageFrontImageList,bushContentList);
			fillLists(gameStageAnimImageList,null,animationContentList);

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
				var randomNumber:Number = Math.random()*10;
				var resizedInt:int = int(randomNumber);

				if (resizedInt <= 4)
				{
					ContentImageList.push(container.removeChildAt(0));
					checkForNewContent(ContentImageList);
					container.addChildAt(ContentImageList.shift(),0);
				}
				else
				{
					ContentImageList.push(container.removeChildAt(0));
					checkForNewContent(ContentImageList);
					container.addChildAt(ContentImageList.pop(),0);
				}
			}
			else if (ContentContainerList)
			{
				var randomNumber:Number = Math.random()*10;
				var resizedInt:int = int(randomNumber);

				if (resizedInt <= 4)
				{
					ContentContainerList.push(container.removeChildAt(0));
					checkForNewContent(null, ContentContainerList);
					container.addChildAt(ContentContainerList.shift(),0);
				}
				else
				{
					ContentContainerList.push(container.removeChildAt(0));
					checkForNewContent(null,ContentContainerList);
					container.addChildAt(ContentContainerList.pop(),0);
				}
			}
		}

		private function checkForNewContent(ContentImageList:Vector.<Image>,
											ContentContainerList:Vector.<DisplayObjectContainer> = null):void
		{
			if(bossStage == true)
			{
				trace("EMPTYING Lists")
				if(ContentImageList)
				{
					emptyLists(ContentImageList);
					changeSetting(ContentImageList);
				}
				else if(ContentContainerList)
				{
					emptyLists(null,ContentContainerList);
					changeSetting(null,ContentContainerList);
				}
			}

		}

		private function moveContainer(containerOne:DisplayObjectContainer,
										containerTwo:DisplayObjectContainer,
										speed:Number):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);

			(containerOne.x>-containerOne.width)? containerOne.x -= resizedSpeed:containerOne.x = containerTwo.x+(containerOne.width) -resizedSpeed;
			(containerTwo.x>-containerTwo.width)?containerTwo.x -= resizedSpeed:containerTwo.x = containerOne.x+(containerOne.width) - resizedSpeed;

		}

		private function checkContainerVisibility(containerOne:DisplayObjectContainer):Boolean
		{

				if (containerOne.x == -containerOne.width)
				{
					return false;
				}
				else
				{
					return true;
				}
		}

		private function checkContainerPositionAndSwap(containerOne:DisplayObjectContainer,
														containerTwo:DisplayObjectContainer,
														contentImageList:Vector.<Image> = null,
														contentContainerList:Vector.<DisplayObjectContainer> = null):void
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

			checkContainerPositionAndSwap(mainStageContainerOne,mainStageContainerTwo,mainStageContentList);
			checkContainerPositionAndSwap(bushContainerOne,bushContainerTwo,bushContentList);
			checkContainerPositionAndSwap(animationContainerOne,animationContainerTwo,null,animationContentList);
			checkContainerPositionAndSwap(backgroundContainerOne,backgroundContainerTwo,backgroundContentList);
			checkContainerPositionAndSwap(foregroundContainerOne,foregroundContainerTwo,foregroundContentList );


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