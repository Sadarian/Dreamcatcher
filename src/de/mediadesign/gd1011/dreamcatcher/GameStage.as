package de.mediadesign.gd1011.dreamcatcher {

	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;

	public class GameStage  extends Sprite {

		private var entityManager:EntityManager;

		private var gameStagePartOne:Image;
		private var gameStagePartTwo:Image;
		private var gameStagePartTree:Image;

		private var animPlaceHolder:Image;
		private var animPlaceHolderTwo:Image;
		private var animPLaceHolderTree:Image;

		private var gameStageFrontPartOne:Image;
		private var gameStageFrontPartTwo:Image;
		private var gameStageFrontPartTree:Image;

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

		public function GameStage(){

			entityManager = new EntityManager();
			var player:Entity = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);

			//GameStage On which the Actors move

			gameStageContainerOne = new Sprite();
			gameStageContainerOne.width = 1280;
			gameStageContainerOne.height = 800;
			gameStageContainerOne.x = 0;

			gameStageContainerTwo = new Sprite();
			gameStageContainerTwo.width = 1280;
			gameStageContainerTwo.height = 800;
			gameStageContainerTwo.x = 1280;

			gameStagePartOne = AssetsManager.getImage(GameConstants.GAME_STAGE);
			gameStagePartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE2);
			gameStagePartTree = AssetsManager.getImage(GameConstants.GAME_STAGE3);

			gameStageContentList.push(gameStagePartOne);
			gameStageContentList.push(gameStagePartTwo);
			gameStageContentList.push(gameStagePartTree);

			gameStageContainerOne.addChild(gameStageContentList.shift());
			gameStageContainerTwo.addChild(gameStageContentList.shift());

			addChild(gameStageContainerOne);
			addChild(gameStageContainerTwo);

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

			animPlaceHolder = AssetsManager.getImage(GameConstants.GAME_STAGE_ANIMATIONS);
			animPlaceHolderTwo = AssetsManager.getImage(GameConstants.GAME_STAGE_ANIMATIONS2);
			animPLaceHolderTree = AssetsManager.getImage(GameConstants.GAME_STAGE_ANIMATIONS3);

			animLayerPartContainerOne.addChild(animPlaceHolder);
			animLayerPartContainerTwo.addChild(animPlaceHolderTwo);
			animLayerPartContainerTree.addChild(animPLaceHolderTree);

			animatedLayerContentList.push(animLayerPartContainerOne);
			animatedLayerContentList.push(animLayerPartContainerTwo);
			animatedLayerContentList.push(animLayerPartContainerTree);

			animLayerContainerOne.addChild(animatedLayerContentList.shift());
			animLayerContainerTwo.addChild(animatedLayerContentList.shift());

			addChild(animLayerContainerOne);
			addChild(animLayerContainerTwo);

			//Front Part of the GameStage behind Actors can hide

			gameStageFrontContainerOne = new Sprite();
			gameStageFrontContainerOne.width = 1280;
			gameStageFrontContainerOne.height = 800;
			gameStageFrontContainerOne.x =0;

			gameStageFrontContainerTwo = new Sprite();
			gameStageFrontContainerTwo.width = 1280;
			gameStageFrontContainerTwo.height = 800;
			gameStageFrontContainerTwo.x = 1280;

			gameStageFrontPartOne = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT);
			gameStageFrontPartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT2);
			gameStageFrontPartTree = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT3);

			gameStageFrontContentList.push(gameStageFrontPartOne);
			gameStageFrontContentList.push(gameStageFrontPartTwo);
			gameStageFrontContentList.push(gameStageFrontPartTree);

			gameStageFrontContainerOne.addChild(gameStageFrontContentList.shift());
			gameStageFrontContainerTwo.addChild(gameStageFrontContentList.shift());

			addChild(gameStageFrontContainerOne);
			addChild(gameStageFrontContainerTwo);


			addChild(player.movieClip);
		}

		private function swapGameStageContainerTwo():void
		{
			var randomNumber:Number = Math.random()*10;
			var resizedInt:int = int(randomNumber);

			if (resizedInt <= 4)
			{
				gameStageContentList.push(gameStageContainerTwo.removeChildAt(0));
				gameStageContainerTwo.addChildAt(gameStageContentList.shift(),0);
			}
			else
			{
				gameStageContentList.push(gameStageContainerTwo.removeChildAt(0));
				gameStageContainerTwo.addChildAt(gameStageContentList.pop(),0);
			}

		}

		private function swapGameStageContainerOne():void
		{
			var randomNumber:Number = Math.random()*10;
			var resizedInt:int = int(randomNumber);

			if (resizedInt <= 4)
			{
				gameStageContentList.push(gameStageContainerOne.removeChildAt(0));
				gameStageContainerOne.addChildAt(gameStageContentList.shift(),0);
			}
			else
			{
				gameStageContentList.push(gameStageContainerOne.removeChildAt(0));
				gameStageContainerOne.addChildAt(gameStageContentList.pop(),0);
			}


		}

		private function swapGameStageFrontContainerOne():void
		{
			var randomNumber:Number = Math.random()*10;
			var resizedInt:int = int(randomNumber);

			if (resizedInt <= 4)
			{
				gameStageFrontContentList.push(gameStageFrontContainerOne.removeChildAt(0));
				gameStageFrontContainerOne.addChildAt(gameStageFrontContentList.shift(),0);
			}
			else
			{
				gameStageFrontContentList.push(gameStageFrontContainerOne.removeChildAt(0));
				gameStageFrontContainerOne.addChildAt(gameStageFrontContentList.pop(),0);
			}
		}

		private function swapGameStageFrontContainerTwo():void
		{
			var randomNumber:Number = Math.random()*10;
			var resizedInt:int = int(randomNumber);

			if (resizedInt <= 4)
			{
				gameStageFrontContentList.push(gameStageFrontContainerTwo.removeChildAt(0));
				gameStageFrontContainerTwo.addChildAt(gameStageFrontContentList.shift(),0);
			}
			else
			{
				gameStageFrontContentList.push(gameStageFrontContainerTwo.removeChildAt(0));
				gameStageFrontContainerTwo.addChildAt(gameStageFrontContentList.pop(),0);
			}
		}

		private function swapGameStageAnimatedContainerOne():void
		{
			var randomNumber:Number = Math.random()*10;
			var resizedInt:int = int(randomNumber);

			if (resizedInt <= 4)
			{
				animatedLayerContentList.push(animLayerContainerOne.removeChildAt(0));
				animLayerContainerOne.addChildAt(animatedLayerContentList.shift(),0);
			}
			else
			{
				animatedLayerContentList.push(animLayerContainerOne.removeChildAt(0));
				animLayerContainerOne.addChildAt(animatedLayerContentList.pop(),0);
			}
		}

		private function swapGameStageAnimatedContainerTwo():void
		{
			var randomNumber:Number = Math.random()*10;
			var resizedInt:int = int(randomNumber);

			if (resizedInt <= 4)
			{
				animatedLayerContentList.push(animLayerContainerTwo.removeChildAt(0));
				animLayerContainerTwo.addChildAt(animatedLayerContentList.shift(),0);
			}
			else
			{
				animatedLayerContentList.push(animLayerContainerTwo.removeChildAt(0));
				animLayerContainerTwo.addChildAt(animatedLayerContentList.pop(),0);
			}
		}

		private function moveBaseStage(speed:Number = 5):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);

			(gameStageContainerOne.x>-gameStageContainerOne.width)? gameStageContainerOne.x -= resizedSpeed:gameStageContainerOne.x = gameStageContainerTwo.x+(gameStageContainerOne.width) -resizedSpeed;
			(gameStageContainerTwo.x>-gameStageContainerTwo.width)?gameStageContainerTwo.x -= resizedSpeed:gameStageContainerTwo.x = gameStageContainerOne.x+(gameStageContainerOne.width) - resizedSpeed;

		}

		private function moveGameStageFront(speed:Number = 2):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);

			(gameStageFrontContainerOne.x>-gameStageFrontContainerOne.width)?gameStageFrontContainerOne.x -= resizedSpeed:gameStageFrontContainerOne.x = gameStageFrontContainerTwo.x +(gameStageFrontContainerOne.width) - resizedSpeed;
			(gameStageFrontContainerTwo.x>-gameStageFrontContainerTwo.width)?gameStageFrontContainerTwo.x -= resizedSpeed:gameStageFrontContainerTwo.x = gameStageFrontContainerOne.x+(gameStageFrontContainerOne.width) - resizedSpeed;
		}

		private function moveAnimLayer (speed:Number = 2):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);
			(animLayerContainerOne.x>-animLayerContainerOne.width)?animLayerContainerOne.x -= resizedSpeed:animLayerContainerOne.x = animLayerContainerTwo.x +(animLayerContainerOne.width) -resizedSpeed;
			(animLayerContainerTwo.x>-animLayerContainerTwo.width)?animLayerContainerTwo.x -= resizedSpeed:animLayerContainerTwo.x = animLayerContainerOne.x +(animLayerContainerOne.width) -resizedSpeed;
		}

		private function  resizeSpeed(speed:Number):Number
		{
			var newSpeed:Number = Math.min(100, speed);
			return newSpeed;
		}

		public function moveGameStage(movementSpeedVector:Vector.<Number>):void
		{
			moveBaseStage(movementSpeedVector[0]);
			moveGameStageFront(movementSpeedVector[1]);
			moveAnimLayer(movementSpeedVector[2]);

			if (gameStageContainerOne.x == -gameStageContainerOne.width)
			{
				swapGameStageContainerOne();
			}
			else if (gameStageContainerTwo.x == -gameStageContainerTwo.width)
			{
				swapGameStageContainerTwo();
			}

			if (gameStageFrontContainerOne.x == -gameStageFrontContainerOne.width)
			{
				swapGameStageFrontContainerOne();
			}
			else if (gameStageFrontContainerTwo.x == -gameStageFrontContainerTwo.width)
			{
				swapGameStageFrontContainerTwo();
			}

			if (animLayerContainerOne.x == -animLayerContainerOne.width)
			{
				swapGameStageAnimatedContainerOne();
			}
			else if (animLayerContainerTwo.x == -animLayerContainerTwo.width)
			{
				swapGameStageAnimatedContainerTwo();
			}
		}
	}
}