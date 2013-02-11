package de.mediadesign.gd1011.dreamcatcher
{
	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameStage  extends Sprite {

		private var entityManager:EntityManager;

		private var animLayerPartContainerOne:Sprite = new Sprite();
		private var animLayerPartContainerTwo:Sprite = new Sprite();
		private var animLayerPartContainerTree:Sprite = new Sprite();

		private var gameStageContentList:Vector.<Image> = new Vector.<Image>;
		private var gameStageFrontContentList:Vector.<Image> = new Vector.<Image>;
		private var animatedLayerContentList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;

		private var gameStageContainerOne:Sprite = new Sprite();
		private var gameStageContainerTwo:Sprite = new Sprite();

		private var animLayerContainerOne:Sprite = new Sprite();
		private var animLayerContainerTwo:Sprite = new Sprite();

		private var gameStageFrontContainerOne:Sprite = new Sprite();
		private var gameStageFrontContainerTwo:Sprite = new Sprite();

		private var firstContainerList:Vector.<DisplayObjectContainer> = new <DisplayObjectContainer>[gameStageContainerOne,animLayerContainerOne,gameStageFrontContainerOne];
		private var secondContainerList:Vector.<DisplayObjectContainer> = new <DisplayObjectContainer>[gameStageContainerTwo,animLayerContainerTwo,gameStageFrontContainerTwo];

		private var player:Entity;
		private var boss:Entity;

		public function GameStage()
		{
			entityManager = EntityManager.entityManager;
			player = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
			boss = entityManager.createEntity(GameConstants.BOSS, GameConstants.bossStartPosition);

			//GameStage On which the Actors move

			var viewPort:Rectangle = Starling.current.viewPort;

			for each (var container in firstContainerList)
			{
				container.width  	= viewPort.width;
				container.height 	= viewPort.height;
				container.x			= 0;
			}

			for each (var container in secondContainerList)
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
					createLevel(GameConstants.GAME_STAGE_IMAGE_LIST,GameConstants.GAME_STAGE_ANIMATIONS_IMAGE_LIST,GameConstants.GAME_STAGE_FRONT_IMAGE_LIST);
				}
			}
		}

		private function createLevel(gameStageImageList:Vector.<String>,
									 gameStageAnimImageList:Vector.<String>,
									 gameStageFrontImageList:Vector.<String>):void
		{
			var containerIndex:int = 0;

			for each ( var ImageEntry:String in gameStageImageList )
			{
				var newGameStageImage:Image = AssetsManager.getImage(ImageEntry)
				gameStageContentList.push(newGameStageImage);
			}

			for each ( var ImageEntry:String in gameStageAnimImageList )
			{
				containerIndex++
				var newGameStageImage:Image = AssetsManager.getImage(ImageEntry)

					if(containerIndex == 1)
					{
						animLayerPartContainerOne.addChild(newGameStageImage);
						trace("ANIMLAYER ONE");
						trace(containerIndex)
					}
					else if (containerIndex == 2)
					{
						animLayerPartContainerTwo.addChild(newGameStageImage);
						trace("ANIMLAYER TWO");
						trace(containerIndex)
					}
					else if (containerIndex == 3)
					{
						animLayerPartContainerTree.addChild(newGameStageImage);
						trace("ANIMLAYER TREE");
						containerIndex =0;
						trace(containerIndex)
					}


			}

				animatedLayerContentList.push(animLayerPartContainerOne);
				animatedLayerContentList.push(animLayerPartContainerTwo);
				animatedLayerContentList.push(animLayerPartContainerTree);

			for each ( var ImageEntry:String in gameStageFrontImageList )
			{
				var newGameStageFrontImage:Image = AssetsManager.getImage(ImageEntry)
				gameStageFrontContentList.push(newGameStageFrontImage);
			}

			gameStageContainerOne.addChild(gameStageContentList.shift());
			gameStageContainerTwo.addChild(gameStageContentList.shift());

			animLayerContainerOne.addChild(animatedLayerContentList.shift());
			animLayerContainerTwo.addChild(animatedLayerContentList.shift());

			gameStageFrontContainerOne.addChild(gameStageFrontContentList.shift());
			gameStageFrontContainerTwo.addChild(gameStageFrontContentList.shift());

			addChild(gameStageContainerOne);
			addChild(gameStageContainerTwo);

			addChild(animLayerContainerOne);
			addChild(animLayerContainerTwo)

			addChild(player.movieClip);
			addChild(boss.movieClip);

			addChild(gameStageFrontContainerOne);
			addChild(gameStageFrontContainerTwo);

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

		private function  resizeSpeed(speed:Number):Number
		{
			var newSpeed:Number = Math.min(100, speed);
			return newSpeed;
		}

		public function moveGameStage(movementSpeedVector:Vector.<Number>):void
		{
			moveContainer(gameStageContainerOne,gameStageContainerTwo,movementSpeedVector[0]);
			moveContainer(gameStageFrontContainerOne,gameStageFrontContainerTwo,movementSpeedVector[1]);
			moveContainer(animLayerContainerOne,animLayerContainerTwo,movementSpeedVector[2]);


			if (gameStageContainerOne.x == -gameStageContainerOne.width)
			{
				swapContainerContent(gameStageContainerOne,gameStageContentList);
			}
			else if (gameStageContainerTwo.x == -gameStageContainerTwo.width)
			{
				swapContainerContent(gameStageContainerTwo,gameStageContentList);
			}

			if (gameStageFrontContainerOne.x == -gameStageFrontContainerOne.width)
			{
				swapContainerContent(gameStageFrontContainerOne,gameStageFrontContentList);
			}
			else if (gameStageFrontContainerTwo.x == -gameStageFrontContainerTwo.width)
			{
				swapContainerContent(gameStageFrontContainerTwo,gameStageFrontContentList);
			}

			if (animLayerContainerOne.x == -animLayerContainerOne.width)
			{
				swapContainerContent(animLayerContainerOne,null,animatedLayerContentList);
			}
			else if (animLayerContainerTwo.x == -animLayerContainerTwo.width)
			{
				swapContainerContent(animLayerContainerTwo,null,animatedLayerContentList);
			}
		}
	}
}