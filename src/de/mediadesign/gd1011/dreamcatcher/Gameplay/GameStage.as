package de.mediadesign.gd1011.dreamcatcher.Gameplay
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPlayer;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPlayerToStart;
	import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.HighScoreMenu;
    import de.mediadesign.gd1011.dreamcatcher.View.PauseButton;
	import de.mediadesign.gd1011.dreamcatcher.Game;
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBoss;
	import de.mediadesign.gd1011.dreamcatcher.View.LevelEndScreen;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;
	import de.mediadesign.gd1011.dreamcatcher.View.Score;

	import flash.media.SoundChannel;

	import flash.media.SoundTransform;

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

		private var _movementSpeeds:Vector.<Number>;

        private var _pauseButton:PauseButton;

		private var lvlEnd:Boolean;
		private var initComplete:Boolean = false;

		private var endScreen:LevelEndScreen;

		private var background:Image;

		private var lose:Boolean;

	    private var musicChanel:SoundChannel;

		public function GameStage()
		{
			_movementSpeeds = GameConstants.GAME_STAGE_MOVEMENT_SPEEDS.concat();
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
			initComplete = true;

			containerGroup = new Vector.<StageContainer>(6);
			_movementSpeeds = GameConstants.GAME_STAGE_MOVEMENT_SPEEDS.concat();

			background = GraphicsManager.graphicsManager.getImage( GameConstants.BACKGROUND);
            addChild(background);

			for(var i:int = 0;i<containerGroup.length;i++)
            {
                containerGroup[i] = new StageContainer((typeImage[i]?StageContainer.LIST_TYPE_IMAGE:StageContainer.LIST_TYPE_CONTAINER));
                containerGroup[i].touchable = false;
                addChild(containerGroup[i]);
            }

            _pauseButton = new PauseButton();
            addChild(_pauseButton);

			if (Game.currentLvl != GameConstants.TUTORIAL)
			{
				var musicTransform:SoundTransform = new SoundTransform(0.5);
				musicChanel = GraphicsManager.graphicsManager.playSound("GreySkies", 0, 10, musicTransform);
			}
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

			_movementSpeeds = null;
			initComplete = false;

			removeChild(_pauseButton, true);

			_pauseButton = null;

			removeChild(background, true);

			Score.removeScoreField();
			PowerUpTrigger.deleteButton();
			MovementBoss.resetPhase();
			EntityManager.entityManager.removeAll();
			removeChildren();
			if (musicChanel)
			{
				musicChanel.stop();
			}
		}

		public function loadLevel(levelIndex:int = 1):void
		{
			var vector:Array = [];
			var vectorBoss:Array = [];
			switch(levelIndex)
			{
				case GameConstants.TUTORIAL:
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
                case -1:
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
					vector.push(GameConstants.BACKGROUND_IMAGE_LIST,
                                GameConstants.MAIN_STAGE_IMAGE_LIST,
                                GameConstants.FOREST_LIST_BOSS,
                                GameConstants.FOG_LIST,
                                GameConstants.BUSH_IMAGE_LIST_LVL2,
                                GameConstants.FOREGROUND_IMAGE_LIST);

					vectorBoss.push(GameConstants.BACKGROUND_IMAGE_LIST_BOSS_LVL2,
                                    GameConstants.MAIN_STAGE_IMAGE_LIST_BOSS,
                                    GameConstants.FOREST_LIST_BOSS_LVL2,
                                    GameConstants.FOG_LIST_BOSS_LVL2,
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
			if (!lvlEnd && initComplete)
			{
				for (var i:int = 0; i < containerGroup.length; i++)
				{
					containerGroup[i].move(_movementSpeeds[i]);
					containerGroup[i].swap(bossStage);
				}
				if (!bossStage)
				{
					if (Game.currentLvl == 1 && (now.toFixed() == "62"))
					{
						switchToBoss();
					}
					if (Game.currentLvl == 2 && (now.toFixed() == "78"))
					{
						switchToBoss();
					}
				}
			}

            if (EntityManager.entityManager.getEntity(GameConstants.PLAYER) != null && EntityManager.entityManager.getEntity(GameConstants.PLAYER).health <= 0 && !lvlEnd)
            {
                if(EndlessMode.hasInstance)
                {
                    endLvl("Yo have failed, but your Rumors will remain!");
                }
                else
                {
                    lose = true;
                    endLvl("You Lose!");
                }
            }

			if (lvlEnd && endScreen && endScreen.alpha <= 1)
			{
				endScreen.alpha += 0.02;
                trace(endScreen.alpha);
				endScreen.fadeIn();

				if (endScreen.alpha >= 1)
				{
					resetAll();
                    addChild(endScreen.screen);
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
				delay /= GameConstants.GAME_STAGE_MOVEMENT_SPEEDS[0];
			}
            else
            {
                delay = containerGroup[0].getChildAt(1).x + (2*containerGroup[0].getChildAt(0).width);
                delay /= GameConstants.GAME_STAGE_MOVEMENT_SPEEDS[0];
            }

			bossStage = true;
            Starling.juggler.delayCall(beginReduction, delay/60);
			var player:Entity = EntityManager.entityManager.getEntity(GameConstants.PLAYER);
            function beginReduction():void
            {
                var call:DelayedCall = Starling.juggler.delayCall(reduceMovementSpeed, GameConstants.BOSS_SPEED_REDUCTION);
                call.repeatCount = 100;
                call.addEventListener(Event.REMOVE_FROM_JUGGLER, playerDefault);
            }
            function reduceMovementSpeed():void
            {
                for (var i:int = 0; i < _movementSpeeds.length; i++)
                    _movementSpeeds[i] -= GameConstants.GAME_STAGE_MOVEMENT_SPEEDS[i]/100;
            }
            function playerDefault():void
            {
                GameConstants.Player_Default = "Stand";

                if(player.getAnimatedModel(0).ActualAnimation.name == AnimatedModel.WALK)
                    player.playAnimation(AnimatedModel.STAND);
	            if (Game.currentLvl == 1)
	            {
		            Starling.juggler.delayCall(enterBoss, 5);
	            }
	            else if (Game.currentLvl == 2)
	            {
		            Starling.juggler.delayCall(enterBoss, 7);
	            }
            }
			function enterBoss():void
			{
				player.switchMovement(new MovementPlayerToStart());
				player.setMovementSpeed();
				player.increaseMovementSpeed(1.5);
				MovementPlayer.touch = null;
				player.switchWeapon(null);
			}
		}

		public function endLvl(text:String):void
		{
			lvlEnd = true;
            if(lose)
            {
                endScreen = new LevelEndScreen(text);
                endScreen.createRestartButton();
	            addChild(endScreen.screen);
            }
			else
            {
                if(!EndlessMode.hasInstance)
                {
                    Dreamcatcher.localObject.data.Progress = (Dreamcatcher.localObject.data.Progress >= (Game.currentLvl+1)) ? Dreamcatcher.localObject.data.Progress : (Game.currentLvl+1);
                    if(Game.currentLvl == 2 && Dreamcatcher.localObject.data.Endless == false)
                        Dreamcatcher.localObject.data.Endless = true;
                    if(Game.currentLvl == 2 && HighScoreMenu.creditsOnceShown == false)
                    {
                        HighScoreMenu.credits = true;
                        HighScoreMenu.creditsOnceShown = true;
                    }
                }
                Dreamcatcher.localObject.flush();
                HighScoreMenu.showAndHide();
                HighScoreMenu.highScoreMenu.setScore(Score.score);
                resetAll();
            }

		}

        public function get movementSpeeds():Vector.<Number>
        {
            return _movementSpeeds;
        }
    }
}