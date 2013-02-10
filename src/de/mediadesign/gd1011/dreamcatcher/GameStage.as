package de.mediadesign.gd1011.dreamcatcher
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameStage  extends Sprite {

		private var entityManager:EntityManager;

		private var animLayerPartContainerOne:Sprite;
		private var animLayerPartContainerTwo:Sprite;
		private var animLayerPartContainerTree:Sprite;

		private var gameStageContentList:Vector.<Image> = new Vector.<Image>;
		private var gameStageFrontContentList:Vector.<Image> = new Vector.<Image>;
		private var animatedLayerContentList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>;

		private var gameStageContainerOne:Sprite;
		private var gameStageContainerTwo:Sprite;

		private var animLayerContainerOne:Sprite;
		private var animLayerContainerTwo:Sprite;

		private var gameStageFrontContainerOne:Sprite;
		private var gameStageFrontContainerTwo:Sprite;

		private var player:Entity;

		public function GameStage(){

			entityManager = new EntityManager();
			player = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);

			//GameStage On which the Actors move

			gameStageContainerOne = new Sprite();
			gameStageContainerOne.width = 1280;
			gameStageContainerOne.height = 800;
			gameStageContainerOne.x = 0;

			gameStageContainerTwo = new Sprite();
			gameStageContainerTwo.width = 1280;
			gameStageContainerTwo.height = 800;
			gameStageContainerTwo.x = 1280;

			//AnimationLayer on the GameStage

			animLayerContainerOne = new Sprite();
			animLayerContainerOne.width = 1280;
			animLayerContainerOne.height = 800;
			animLayerContainerOne.x =0;

			animLayerContainerTwo = new Sprite();
			animLayerContainerTwo.width = 1280;
			animLayerContainerTwo.height = 800;
			animLayerContainerTwo.x = 1280;

			animLayerPartContainerOne = new Sprite();
			animLayerPartContainerTwo = new Sprite();
			animLayerPartContainerTree = new Sprite();

			//Front Part of the GameStage behind Actors can hide

			gameStageFrontContainerOne = new Sprite();
			gameStageFrontContainerOne.width = 1280;
			gameStageFrontContainerOne.height = 800;
			gameStageFrontContainerOne.x =0;

			gameStageFrontContainerTwo = new Sprite();
			gameStageFrontContainerTwo.width = 1280;
			gameStageFrontContainerTwo.height = 800;
			gameStageFrontContainerTwo.x = 1280;


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

		private function createLevel(gameStageImageList:Vector.<String>,gameStageAnimImageList:Vector.<String>,gameStageFrontImageList:Vector.<String>):void
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

			addChild(gameStageFrontContainerOne);
			addChild(gameStageFrontContainerTwo);

			addChild(player.movieClip);

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

		private function moveContainer(containerOne:DisplayObjectContainer,containerTwo:DisplayObjectContainer,speed:Number):void
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
				swapContainerContent(animLayerContainerOne,null,animatedLayerContentList);
			}
		}
	}
}