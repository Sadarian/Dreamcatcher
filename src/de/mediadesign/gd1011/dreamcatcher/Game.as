package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Processes.ActivePowerUpProcess;
	import de.mediadesign.gd1011.dreamcatcher.TestStuff.CollisionDummyBoxes;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.EntityManager;
    import de.mediadesign.gd1011.dreamcatcher.Gameplay.GameStage;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPlayer;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerControllable;
    import de.mediadesign.gd1011.dreamcatcher.Processes.CollisionProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.DestroyProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.MoveProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.RenderProcess;
    import de.mediadesign.gd1011.dreamcatcher.Processes.ShootingProcess;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.PowerUpTrigger;
	import de.mediadesign.gd1011.dreamcatcher.View.UserInterface;

	import flash.geom.Point;
	import flash.ui.Keyboard;
    import flash.utils.getTimer;
    import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.utils.ProgressBar;

public class Game extends Sprite
    {
        private var graphicsManager:GraphicsManager;
        private var entityManager:EntityManager;
        private var gameStage:GameStage;


        private var moveProcess:MoveProcess;
		private var shootingProcess:ShootingProcess;
		private var collisionProcess:CollisionProcess;
        private var destroyProcess:DestroyProcess;
		private var renderProcess:RenderProcess;

	    public static var currentLvl:Number = 1;
		private var lastFrameTimeStamp:Number;

        //DEBUG:
	    private var BossButton:Button;
        private var touchPosition:Point = new Point();

		public function Game()
        {
            graphicsManager = GraphicsManager.graphicsManager;
            gameStage = GameStage.gameStage;
	        entityManager = EntityManager.entityManager;

	        moveProcess = new MoveProcess();
	        shootingProcess = new ShootingProcess();
	        collisionProcess = new CollisionProcess();
	        destroyProcess = new DestroyProcess();
	        renderProcess = new RenderProcess();
		}

        public function init():void
        {
            var pB:ProgressBar = new ProgressBar(240, 80);
            pB.x = stage.stageWidth/2 - pB.width/2;
            pB.y = stage.stageHeight/2 - pB.height/2;
            addChild(pB);
            graphicsManager.init();
            graphicsManager.loadQueue(function(ratio:Number):void
            {
                pB.ratio = ratio;
                if(ratio==1)
                {
                    removeChild(pB);
                    pB.dispose();
                    Starling.juggler.delayCall(resumeInit, 0.15);
                }
            });
        }

        private function resumeInit():void
        {
            graphicsManager.initCompleted = true;
            addChild(gameStage);
            MainMenu.showAndHide();

            if(Dreamcatcher.debugMode)
            {
	            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, debugFunction);

                addChild(BossButton = new Button(graphicsManager.getTexture(GameConstants.BUTTON),"RESTART"));
                BossButton.x = 560;
                BossButton.fontName = "MenuFont";
                BossButton.enabled = false;
                BossButton.addEventListener(Event.TRIGGERED, onButtonClick);
            }

			GraphicsManager.graphicsManager.playSound("Slayer");
        }

		public function startLevel(levelIndex:int = 1):void
		{
            if(!hasEventListener(Event.ENTER_FRAME))
                addEventListener(Event.ENTER_FRAME, update);
            if(!hasEventListener(TouchEvent.TOUCH))
                addEventListener(TouchEvent.TOUCH, onTouch);
			gameStage.init();
			entityManager.init();
			UserInterface.userInterface.init();
			PowerUpTrigger.init();
            gameStage.loadLevel(levelIndex);
            entityManager.loadEntities(levelIndex);
		}

	    public function nextLevel():void
	    {
		    currentLvl++;
		    startLevel(currentLvl);
	    }

		public function restartLevel():void
		{
			startLevel(currentLvl);
		}

        public function setStartTimeStamp():void
        {
            lastFrameTimeStamp = getTimer() / 1000;
        }

		private function onButtonClick(event:Event):void
        {
            if(event.target == BossButton)
            {
                trace("Restarting Game!");

                entityManager.loadEntities();

                if(entityManager.getEntity(GameConstants.PLAYER) == null)
                    entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
                BossButton.enabled = false;
            }
		}

		private function update():void
		{
            if(Starling.juggler.isActive && !MainMenu.isActive())
            {
                var now:Number = getTimer() / 1000;
                var passedTime:Number = now - lastFrameTimeStamp;
                lastFrameTimeStamp = now;

//                entityManager.rotatePowerUps(passedTime);
                moveProcess.update(passedTime);
                shootingProcess.update(passedTime);
                collisionProcess.update();
                destroyProcess.update();
                renderProcess.update();
                gameStage.update(now);

                if(Dreamcatcher.debugMode)
                {
                    if (entityManager.getEntity(GameConstants.PLAYER) == null)
                        BossButton.enabled = true;
                    CollisionDummyBoxes.update();
                }

                if (PowerUpTrigger.powerUpActive)
                {
                    ActivePowerUpProcess.update(passedTime);
                }
            }

		}

        private function onTouch(e:TouchEvent):void
        {
			//if(e.getTouch(stage, TouchPhase.BEGAN).tapCount >= 2)
			//	PowerUpTrigger.powerUpButton.dispatchEventWith(Event.TRIGGERED);

            var touches:Vector.<Touch> = new Vector.<Touch>();
	        e.getTouches(stage, TouchPhase.BEGAN, touches);
	        e.getTouches(stage, TouchPhase.MOVED, touches);
	        e.getTouches(stage, TouchPhase.STATIONARY, touches);

            MovementPlayer.touch = null;
            WeaponPlayerControllable.touch = null;

            for each(var touch:Touch in touches)
                if(touch.getLocation(stage).x < GameConstants.playerMovementBorder.width)
                    MovementPlayer.touch = touch;
                else
                    WeaponPlayerControllable.touch = touch;

            if(Dreamcatcher.debugMode)
                if(e.getTouch(stage, TouchPhase.HOVER))
                    touchPosition = e.getTouch(stage, TouchPhase.HOVER).getLocation(stage);
        }

        //DEBUG:
        private function debugFunction(e:KeyboardEvent):void
        {
            if(e.keyCode==Keyboard.F1 && (entityManager.getEntity(GameConstants.PLAYER) == null))
                entityManager.createEntity(GameConstants.PLAYER, touchPosition);
            if(e.keyCode==Keyboard.F2)
                entityManager.createEntity(GameConstants.ENEMY, touchPosition);
            if(e.keyCode==Keyboard.F3)
                entityManager.createEntity(GameConstants.VICTIM1, touchPosition);
            if(e.keyCode==Keyboard.F4)
                entityManager.createEntity(GameConstants.BOSS1, touchPosition);
            if(e.keyCode==Keyboard.F5)
                entityManager.loadEntities();
            if(e.keyCode==Keyboard.F6)
                trace(touchPosition);
        }
    }
}
