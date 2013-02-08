package de.mediadesign.gd1011.dreamcatcher {

	import starling.display.MovieClip;
	import starling.display.Sprite;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.ParticleSystem;

	public class GameStage  extends Sprite {

		private var entityManager:EntityManager;
		private var gameStagePartOne:Image;
		private var gameStagePartTwo:Image;

		private var gameStageFrontPartOne:Image;
		private var gameStageFrontPartTwo:Image;

		private var animLayerContainerOne:Sprite;
		private var animLayerContainerTwo:Sprite;

		public var player:Entity;

		public function GameStage(){

			entityManager = new EntityManager();

			player = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
			//entityManager.test()
			var boss:Entity = entityManager.createEntity(GameConstants.BOSS, GameConstants.bossStartPosition);
			//entityManager.test();
			//var scrollingSpeed:int = player.movementSystem.speed ;

			//GameStage On which the Actor move

			gameStagePartOne = AssetsManager.getImage(GameConstants.GAME_STAGE);
			addChild(gameStagePartOne);

			gameStagePartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE);
			gameStagePartTwo.pivotX = gameStagePartTwo.width;
			gameStagePartTwo.x = gameStagePartOne.width*2 - 1;
			addChild(gameStagePartTwo);

			//AnimationLayer on the GameStage in one Container
			animLayerContainerOne = new Sprite();
			animLayerContainerOne.width = 1280;
			animLayerContainerOne.height = 800;

			animLayerContainerTwo = new Sprite();
			animLayerContainerTwo.width = 1280;
			animLayerContainerTwo.height = 800;
			animLayerContainerTwo.scaleX= -1;
			animLayerContainerTwo.x = animLayerContainerOne.width*2 -1;

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
			gameStageFrontPartTwo.x = gameStageFrontPartOne.width*2 - 1;
			addChild(gameStageFrontPartTwo);


			//addChild(player.movieClip);
			addChild(boss.movieClip);

		}

		private function moveBaseStage(speed:Number = 5):void
		{
			var resizedSpeed:Number = Math.min(100, speed);
			(gameStagePartOne.x>-gameStagePartOne.width)?gameStagePartOne.x -= resizedSpeed:gameStagePartOne.x = gameStagePartTwo.x - resizedSpeed;
			(gameStagePartTwo.x>0)?gameStagePartTwo.x -= resizedSpeed:gameStagePartTwo.x = gameStagePartOne.x+(gameStagePartOne.width*2) - resizedSpeed;

		}

		private function moveGameStageFront(speed:Number = 2):void
		{
			var resizedSpeed:Number = Math.min(100, speed);

			(gameStageFrontPartOne.x>-gameStageFrontPartOne.width)?gameStageFrontPartOne.x -= resizedSpeed:gameStageFrontPartOne.x = gameStageFrontPartTwo.x - resizedSpeed;
			(gameStageFrontPartTwo.x>0)?gameStageFrontPartTwo.x -= resizedSpeed:gameStageFrontPartTwo.x = gameStageFrontPartOne.x+(gameStageFrontPartOne.width*2) - resizedSpeed;
		}

		private function moveAnimLayer (speed:Number = 2):void
		{
			var resizedSpeed:Number = Math.min(100, speed);
			(animLayerContainerOne.x>-animLayerContainerOne.width)?animLayerContainerOne.x -= resizedSpeed:animLayerContainerOne.x = animLayerContainerTwo.x - resizedSpeed;
			(animLayerContainerTwo.x>0)?animLayerContainerTwo.x -= resizedSpeed:animLayerContainerTwo.x = animLayerContainerOne.x+(animLayerContainerOne.width*2) - resizedSpeed;
		}

		public function moveGameStage(movementSpeedVector:Vector.<Number>):void
		{
			moveBaseStage(movementSpeedVector[0]);
			moveGameStageFront(movementSpeedVector[1]);
			moveAnimLayer(movementSpeedVector[2]);
		}
	}
}