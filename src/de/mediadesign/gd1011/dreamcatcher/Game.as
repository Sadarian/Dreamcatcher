package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
	import de.mediadesign.gd1011.dreamcatcher.Assets.Unused.SoundExtended;
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
    import flash.geom.Point;
	import flash.media.Sound;
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

		private var lastFrameTimeStamp:Number;
		private var BossButton:Button;
		public var testSound:Sound;

        //DEBUG:
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

			addChild(gameStage);
		}

        public function init():void
        {
            graphicsManager.init();
            graphicsManager.loadQueue(function(ratio:Number):void
            {
                if(ratio==1)
                    Starling.juggler.delayCall(resumeInit, 0.15);
            });
        }

        private function resumeInit():void
        {
            gameStage.init();
            entityManager.init();

//			GraphicsManager.graphicsManager.addSound("TestSound",testSound);
//			GraphicsManager.graphicsManager.playSound("TestSound");

            startLevel();

            addEventListener(Event.ENTER_FRAME, update);
            addEventListener(TouchEvent.TOUCH, onTouch);

            if(Dreamcatcher.debugMode)
            {
                Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, debugFunction);

                addChild(BossButton = new Button(graphicsManager.getTexture(GameConstants.BUTTON),"RESTART"));
                BossButton.x = 560;
                BossButton.fontName = "TestFont";
                BossButton.enabled = false;
                BossButton.addEventListener(Event.TRIGGERED, onButtonClick);
            }
        }

		private function startLevel(levelIndex:int = 1):void
		{
            gameStage.loadLevel(levelIndex);
            entityManager.loadEntities(levelIndex);
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

		private function update(event:Event):void
		{
            var now:Number = getTimer() / 1000;
            var passedTime:Number = now - lastFrameTimeStamp;
            lastFrameTimeStamp = now;

			moveProcess.update(passedTime);
			shootingProcess.update(passedTime);
			collisionProcess.update();
			destroyProcess.update();
			renderProcess.update();
            gameStage.update();

            if(Dreamcatcher.debugMode)
            {
                if (entityManager.getEntity(GameConstants.PLAYER) == null)
                    BossButton.enabled = true;
                CollisionDummyBoxes.update();
            }
		}

        private function onTouch(e:TouchEvent):void
        {
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
                entityManager.createEntity(GameConstants.VICTIM, touchPosition);
            if(e.keyCode==Keyboard.F4)
                entityManager.createEntity(GameConstants.BOSS, touchPosition);
            if(e.keyCode==Keyboard.F5)
                entityManager.loadEntities();
        }
    }
}
