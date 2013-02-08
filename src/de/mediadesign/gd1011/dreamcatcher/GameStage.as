package de.mediadesign.gd1011.dreamcatcher {

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.extensions.ParticleSystem;

	public class GameStage  extends Sprite {

		private var entityManager:EntityManager;
		private var gameStagePartOne:Image;
		private var gameStagePartTwo:Image;

		private var gameStageFrontPartOne:Image;
		private var gameStageFrontPartTwo:Image;

		private var particleAnimPlaceholderOne:ParticleSystem;

		public var player:Entity;

		public function GameStage(){

			entityManager = new EntityManager();

			player = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
			//entityManager.test()
			var boss:Entity = entityManager.createEntity(GameConstants.BOSS, GameConstants.bossStartPosition);
			//entityManager.test();
			//var scrollingSpeed:int = player.movementSystem.speed ;

			//AnimationLayer behind the GameStage
			ParticleManager.start();
			particleAnimPlaceholderOne = ParticleManager.getParticleSystem(GameConstants.PARTICLE);
			particleAnimPlaceholderOne.emitterX =1000;
			particleAnimPlaceholderOne.emitterY =400;
			addChild(particleAnimPlaceholderOne);

			//GameStage On which the Actor move

			gameStagePartOne = AssetsManager.getImage(GameConstants.GAME_STAGE);
			addChild(gameStagePartOne);

			gameStagePartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE);
			gameStagePartTwo.scaleX = -1;
			gameStagePartTwo.x = gameStagePartOne.width*2 - 1;
			addChild(gameStagePartTwo);

			//Part of the Stage behind Actors can hide

			gameStageFrontPartOne = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT);
			addChild(gameStageFrontPartOne);

			gameStageFrontPartTwo = AssetsManager.getImage(GameConstants.GAME_STAGE_FRONT);
			gameStageFrontPartTwo.scaleX = -1;
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
			(gameStagePartOne.x>-gameStagePartOne.width)?particleAnimPlaceholderOne.emitterX -= resizedSpeed:particleAnimPlaceholderOne.emitterX = gameStagePartTwo.x - resizedSpeed;
		}

		public function moveGameStage(speedBaseStage:Number,speedGameStageFront:Number,speedAnimLayer:Number):void {

			moveBaseStage(speedBaseStage);
			moveGameStageFront(speedGameStageFront);
			moveAnimLayer(speedAnimLayer);

		}
	}
}