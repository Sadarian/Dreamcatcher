package de.mediadesign.gd1011.dreamcatcher {

	import de.mediadesign.gd1011.dreamcatcher.GameStage;

	import starling.display.Image;
	import starling.display.Sprite;

	public class GameStage  extends Sprite {

		private static var gameStagesLoaded:Boolean =false;

		private var entityManager:EntityManager;

		private static var gameStagesList:Vector.<Image> = new Vector.<Image>();

		private var gameStagePartOne:Image;
		private var gameStagePartTwo:Image;
		private var gameStagePartTree:Image;

		private var gameStageContainerOne:Sprite;
		private var gameStageContainerTwo:Sprite;

		private var gameStageContainerOneContent:Image;
		private var gameStageContainerTwoContent:Image;

		private var gameStageFrontPartOne:Image;
		private var gameStageFrontPartTwo:Image;

		private var animLayerContainerOne:Sprite;
		private var animLayerContainerTwo:Sprite;

		public function GameStage(){

			entityManager = new EntityManager();
			var player:Entity = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);

			//GameStage On which the Actor move

			gameStageContainerOne = new Sprite();
			gameStageContainerOne.width = 1280;
			gameStageContainerOne.height = 800;
			gameStageContainerOne.x = 0;


			gameStageContainerTwo = new Sprite();
			gameStageContainerTwo.width = 1280;
			gameStageContainerTwo.height = 800;
			gameStageContainerTwo.x =1280;

			gameStagePartOne = AssetsManager.getImage(GameConstants.GAME_STAGE);
			gameStagePartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE2);
			gameStagePartTree = AssetsManager.getImage(GameConstants.GAME_STAGE3);

			this.addChild(gameStagePartOne);
			gameStageContainerOne.addChild(gameStagePartOne);

			this.addChild(gameStagePartTwo);
			gameStageContainerTwo.addChild(gameStagePartTwo);


			addChild(gameStageContainerOne);
			addChild(gameStageContainerTwo);

			//AnimationLayer on the GameStage in one Container
			animLayerContainerOne = new Sprite();
			animLayerContainerOne.width = 1280;
			animLayerContainerOne.height = 800;

			animLayerContainerTwo = new Sprite();
			animLayerContainerTwo.width = 1280;
			animLayerContainerTwo.height = 800;
			animLayerContainerTwo.scaleX= -1;
			animLayerContainerTwo.x = animLayerContainerOne.width*2;

			//Filling the first Container
			var animPlaceHolder:Image = AssetsManager.getImage(GameConstants.GAME_STAGE_ANIM);
			this.addChild(animPlaceHolder);
			animLayerContainerOne.addChild(animPlaceHolder);

//			var animmationPlaceholder:MovieClip = AssetsManager.getMovieClip(GameConstants.BOSS);
//			this.addChild(animmationPlaceholder);
//			animLayerContainerOne.addChild(animmationPlaceholder);

			//Filling the second Container
			var animPlaceHolderTwo:Image = AssetsManager.getImage(GameConstants.GAME_STAGE_ANIM);
			this.addChild(animPlaceHolderTwo);
			animPlaceHolderTwo.scaleX = -1;
			animPlaceHolderTwo.pivotX = animPlaceHolderTwo.width;
			animLayerContainerTwo.addChild(animPlaceHolderTwo);

//			var animmationPlaceholderTwo:MovieClip = AssetsManager.getMovieClip(GameConstants.BOSS);
//			this.addChild(animmationPlaceholderTwo);
//			animLayerContainerTwo.addChild(animmationPlaceholderTwo);

			addChild(animLayerContainerOne);
			addChild(animLayerContainerTwo);

			//Front Part of the GameStage behind Actors can hide

			gameStageFrontPartOne = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT);
			addChild(gameStageFrontPartOne);

			gameStageFrontPartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT);
			gameStageFrontPartTwo.pivotX = gameStageFrontPartTwo.width;
			gameStageFrontPartTwo.x = gameStageFrontPartOne.width*2;
			addChild(gameStageFrontPartTwo);

			addChild(player.movieClip);

		}

		private function swapGameStageContainerTwo():void
		{
			trace("Content in Container TWO is swapped");
		}

		private function swapGameStageContainerOne():void
		{
			trace("Content in Container ONE is swapped");
		}

		private function moveBaseStage(speed:Number = 5):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);

			(gameStageContainerOne.x>-gameStageContainerOne.width)? gameStageContainerOne.x -= resizedSpeed:gameStageContainerOne.x = gameStageContainerTwo.x +(gameStageContainerOne.width) - resizedSpeed;
			(gameStageContainerTwo.x>-gameStageContainerTwo.width)?gameStageContainerTwo.x -= resizedSpeed:gameStageContainerTwo.x = gameStageContainerOne.x+(gameStageContainerOne.width) - resizedSpeed;

		}

		private function moveGameStageFront(speed:Number = 2):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);

			(gameStageFrontPartOne.x>-gameStageFrontPartOne.width)?gameStageFrontPartOne.x -= resizedSpeed:gameStageFrontPartOne.x = gameStageFrontPartTwo.x - resizedSpeed;
			(gameStageFrontPartTwo.x>0)?gameStageFrontPartTwo.x -= resizedSpeed:gameStageFrontPartTwo.x = gameStageFrontPartOne.x+(gameStageFrontPartOne.width*2) - resizedSpeed;
		}

		private function moveAnimLayer (speed:Number = 2):void
		{
			var resizedSpeed:Number = resizeSpeed(speed);
			(animLayerContainerOne.x>-animLayerContainerOne.width)?animLayerContainerOne.x -= resizedSpeed:animLayerContainerOne.x = animLayerContainerTwo.x - resizedSpeed;
			(animLayerContainerTwo.x>0)?animLayerContainerTwo.x -= resizedSpeed:animLayerContainerTwo.x = animLayerContainerOne.x+(animLayerContainerOne.width*2) - resizedSpeed;
		}

		private function  resizeSpeed(speed:Number):Number
		{
			var newSpeed:Number = Math.min(100, speed);
			return newSpeed;
		}

//		public static function createGame():void
//		{
//			if(!gameStagesLoaded)
//			{
//				for each (var gameStageEntry:String in GameConstants.GAME_STAGE_LIST)
//				{
//					var gameStagePartOne:Image = AssetsManager.getImage(GameConstants.GAME_STAGE);
//					gameStagesList.push(gameStagePartOne)
//
//					var gameStagePartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE);
//					gameStagePartTwo.pivotX = gameStagePartTwo.width;
//					gameStagePartTwo.x = gameStagePartOne.width*2;
//					gameStagesList.push(gameStagePartTwo)
//
//				}
//
//				gameStagesLoaded = true;
//			}
//		}

		public function moveGameStage(movementSpeedVector:Vector.<Number>):void
		{
			moveBaseStage(movementSpeedVector[0]);
			moveGameStageFront(movementSpeedVector[1]);
			moveAnimLayer(movementSpeedVector[2]);
			//trace("Position of Container ONE " + gameStageContainerOne.x);
			//trace("Position of Container TWO: " + gameStageContainerTwo.x);

			if (gameStageContainerOne.x == -gameStageContainerOne.width)
			{
				swapGameStageContainerOne();
			}
			else if (gameStageContainerTwo.x == -1280)
			{
				swapGameStageContainerTwo();
			}
			//else
			//trace("Nothing was swapped");
		}
	}
}