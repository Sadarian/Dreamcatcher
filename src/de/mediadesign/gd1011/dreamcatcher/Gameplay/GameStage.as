package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
	import de.mediadesign.gd1011.dreamcatcher.View.PauseButton;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
	import de.mediadesign.gd1011.dreamcatcher.View.LevelEndScreen;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;
	import de.mediadesign.gd1011.dreamcatcher.View.Score;

    import flash.net.SharedObject;

    import starling.animation.DelayedCall;
    import starling.core.Starling;
    import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
    import starling.events.Event;

    public class GameStage  extends Sprite
	{
		private static var self:GameStage;
		private static var typeImage:Vector.<Boolean> = new <Boolean>[true, true, false, false, true, true];

		private var containerGroup:Vector.<StageContainer>;

		public var bossStage:Boolean;

		private var movementSpeeds:Vector.<Number>;

        private var pauseButton:PauseButton;

		private var lvlEnd:Boolean;

		private var endScreen:LevelEndScreen;

		private var background:Image;

		private var lose:Boolean;

		public function GameStage()
		{
			movementSpeeds = GameConstants.GAME_STAGE_MOVMENT_SPEEDS.concat();
			containerGroup = new Vector.<StageContainer>(6);
		}

        public static function get gameStage():GameStage
        {
            if(!self)
            {
                self = new GameStage();
            }
            return self;
        }

		public function init():void
		{
			bossStage = false;
			lose = false;
			lvlEnd = false;

			containerGroup = new Vector.<StageContainer>(6);
			movementSpeeds = GameConstants.GAME_STAGE_MOVMENT_SPEEDS.concat();

			background = GraphicsManager.graphicsManager.getImage("Lvl" + Game.currentLvl + "_" + GameConstants.BACKGROUND)
            addChild(background);

			for(var i:int = 0;i<containerGroup.length;i++)
            {
                containerGroup[i] = new StageContainer((typeImage[i]?StageContainer.LIST_TYPE_IMAGE:StageContainer.LIST_TYPE_CONTAINER));
                containerGroup[i].touchable = false;
                addChild(containerGroup[i]);
            }

            pauseButton = new PauseButton();
            addChild(pauseButton);
		}

		public function resetAll():void
		{
			for each (var stageContainer:StageContainer in containerGroup)
			{
				removeChild(stageContainer, true);
				stageContainer.dispose();
			}
			containerGroup = null;

			bossStage = false;

			movementSpeeds = null;

			removeChild(pauseButton, true);

			pauseButton = null;

			removeChild(background, true);

			Score.removeScoreField();
			PowerUpTrigger.deleteButton();
			MovementBoss.resetPhase();
			EntityManager.entityManager.removeAll();
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
								GameConstants.FOREST_LIST,
								GameConstants.FOG_LIST,
								GameConstants.BUSH_IMAGE_LIST,
								GameConstants.FOREGROUND_IMAGE_LIST);

					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,
									GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
									GameConstants.FOREST_LIST_BOSS,
									GameConstants.FOG_LIST_BOSS,
									GameConstants.BUSH_IMAGE_LIST_BOSS,
									GameConstants.FOREGROUND_IMAGE_LIST_BOSS);
					break;
				}
				case 2:
				{
					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST,
									GameConstants.MAIN_STAGE_IMAGE_LIST,
									GameConstants.FOREST_LIST_BOSS,
									GameConstants.FOG_LIST,
									GameConstants.BUSH_IMAGE_LIST,
									GameConstants.FOREGROUND_IMAGE_LIST);

					vector.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS,
								GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
								GameConstants.FOREST_LIST,
								GameConstants.FOG_LIST_BOSS,
								GameConstants.BUSH_IMAGE_LIST_BOSS,
								GameConstants.FOREGROUND_IMAGE_LIST_BOSS);
					break;
				}
			}
            for(var i:int = 0;i<containerGroup.length;i++)
            {
                containerGroup[i].fill(vector[i], false);
                if(levelIndex!=1)
                    containerGroup[i].fill(vectorBoss[i], true);
            }
		}

		public function update(now:Number):void
		{
			if (!lvlEnd)
			{
				for (var i:int = 0; i < containerGroup.length; i++) {
					containerGroup[i].move(movementSpeeds[i]);
					containerGroup[i].swap(bossStage);
				}
				if ((!bossStage) && (now.toFixed() == "50")) {
					switchToBoss();
				}
			}

            if (EntityManager.entityManager.getEntity(GameConstants.PLAYER) != null && EntityManager.entityManager.getEntity(GameConstants.PLAYER).health <= 0 && !lvlEnd)
            {
                lose = true;
                endLvl("You Lose!");
            }

			if (EntityManager.entityManager.getEntity(GameConstants.BOSS1) != null)
			{
				if ((MovementBoss.phase == "Flee") || (EntityManager.entityManager.getEntity(GameConstants.BOSS1).health <= 0))
				{
					if (!lvlEnd)
					{
						MovementBoss.resetPhase();
						endLvl("Congratulations! You have passed Level " + Game.currentLvl);
					}
				}
			}

			if (lvlEnd && endScreen.alpha <= 1)
			{
				endScreen.alpha += 0.02;
				endScreen.fadeIn();

				if (endScreen.alpha >= 1)
				{
					resetAll();
				}
			}
		}

		public function removeActor(object:DisplayObject):void
		{
			removeChild(object);
		}

		public function switchToBoss():void
		{
            var delay:Number;

			if(containerGroup[0].getChildAt(0).x < containerGroup[0].getChildAt(1).x)
			{
                delay = containerGroup[0].getChildAt(0).x + (2*containerGroup[0].getChildAt(1).width);
				delay /= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[0];
			}
            else
            {
                delay = containerGroup[0].getChildAt(1).x + (2*containerGroup[0].getChildAt(0).width);
                delay /= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[0];
            }

			bossStage = true;
            Starling.juggler.delayCall(beginReduction, delay/60);
            function beginReduction():void
            {
                var call:DelayedCall = Starling.juggler.delayCall(reduceMovementSpeed, GameConstants.BOSS_SPEED_REDUCTION);
                call.repeatCount = 100;
                call.addEventListener(Event.REMOVE_FROM_JUGGLER, playerDefault);
            }
            function reduceMovementSpeed():void
            {
                for (var i:int = 0; i < movementSpeeds.length; i++)
                    movementSpeeds[i] -= GameConstants.GAME_STAGE_MOVMENT_SPEEDS[i]/100;
            }
            function playerDefault():void
            {
                GameConstants.Player_Default = "Stand";
                var player:Entity = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
                if(player.getAnimatedModel(0).ActualAnimation.name == AnimatedModel.WALK)
                    player.playAnimation(AnimatedModel.STAND);
            }
		}

		private function endLvl(text:String):void
		{
			lvlEnd = true;
			endScreen = new LevelEndScreen(text);
			if (lose)
				endScreen.createRestartButton();
			else
            {
                Dreamcatcher.localObject.data.Progress = (Dreamcatcher.localObject.data.Progress >= (Game.currentLvl+1)) ? Dreamcatcher.localObject.data.Progress : (Game.currentLvl+1);
                Dreamcatcher.localObject.flush();
                endScreen.createNextLevelButton();
            }
			addChild(endScreen.screen);
		}
	}
}