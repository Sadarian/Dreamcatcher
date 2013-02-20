package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.AssetsLoader;
    import de.mediadesign.gd1011.dreamcatcher.Assets.AssetsManager;
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
	import flash.net.SharedObject;
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
		private var shootingProcess:ShootingProcess;
		private var moveProcess:MoveProcess;
		private var collisionProcess:CollisionProcess;
		private var renderProcess:RenderProcess;
		private var destroyProcess:DestroyProcess;
		private var lastFrameTimeStamp:Number;
		private var BossButton:Button;
		private var soDreamcatcher:SharedObject;

        //DEBUG:
        private var touchPosition:Point = new Point();

		public function Game()
        {
	        AssetsManager.start();
	        var entityManager:EntityManager = EntityManager.entityManager;

	        soDreamcatcher = SharedObject.getLocal(GameConstants.SHAREDOBJECT);
	        soDreamcatcher.data.reachedBoss = false;
	        if (soDreamcatcher.data.achievedLvl <= 0)
	        {
		        soDreamcatcher.data.achievedLvl = 1;
	        }
	        soDreamcatcher.flush();

	        moveProcess = new MoveProcess();
	        shootingProcess = new ShootingProcess();
	        collisionProcess = new CollisionProcess();
	        destroyProcess = new DestroyProcess();
	        renderProcess = new RenderProcess();

            addChild(AssetsManager.getImage(GameConstants.BACKGROUND));
			addChild(GameStage.gameStage);
			GameStage.gameStage.init();
			GameStage.gameStage.loadLevel();

			addChild(BossButton = new Button(AssetsLoader.getTexture(GameConstants.BUTTON),"RESTART"));
			BossButton.x = 560;
			BossButton.fontName = "TestFont";
			BossButton.enabled = false;

            entityManager.initGameEntities();
			startGame();
		}

		private function startGame():void
		{
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(TouchEvent.TOUCH, onTouch);

            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, debugFunction);
			BossButton.addEventListener(Event.TRIGGERED, onButtonClick);
		}

        public function setStartTimeStamp():void
        {
            lastFrameTimeStamp = getTimer() / 1000;
        }

		private function onButtonClick(event:Event):void {


			trace("Restarting Game!");

			EntityManager.entityManager.createSpawnList();

			if(EntityManager.entityManager.getEntity(GameConstants.PLAYER) == null)
			EntityManager.entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
			BossButton.enabled = false;

		}

		private function update(event:Event):void
		{
			if (EntityManager.entityManager.getEntity(GameConstants.PLAYER) == null)
			{
				BossButton.enabled = true;
			}
            var now:Number = getTimer() / 1000;
            var passedTime:Number = now - lastFrameTimeStamp;
            lastFrameTimeStamp = now;

			moveProcess.update(passedTime);
			shootingProcess.update(passedTime);
			collisionProcess.update();
			destroyProcess.update();
			renderProcess.update();

			CollisionDummyBoxes.update();
			GameStage.gameStage.moveGameStage();
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

            //DEBUG:
            if(e.getTouch(stage, TouchPhase.HOVER))
                touchPosition = e.getTouch(stage, TouchPhase.HOVER).getLocation(stage);
        }

        //DEBUG:
        private function debugFunction(e:KeyboardEvent):void
        {
            if(e.keyCode==Keyboard.F1 && (EntityManager.entityManager.getEntity(GameConstants.PLAYER) == null))
                EntityManager.entityManager.createEntity(GameConstants.PLAYER, touchPosition);
            if(e.keyCode==Keyboard.F2)
                EntityManager.entityManager.createEntity(GameConstants.ENEMY, touchPosition);
            if(e.keyCode==Keyboard.F3)
                EntityManager.entityManager.createEntity(GameConstants.VICTIM, touchPosition);
            if(e.keyCode==Keyboard.F4)
                EntityManager.entityManager.createEntity(GameConstants.BOSS, touchPosition);
            if(e.keyCode==Keyboard.F5)
                EntityManager.entityManager.createSpawnList();
        }

		public function destroySharedObject():void
		{
			soDreamcatcher.clear();
		}
    }
}
