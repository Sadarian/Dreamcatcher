package de.mediadesign.gd1011.dreamcatcher
{

	import de.mediadesign.gd1011.dreamcatcher.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.GameStage;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementPlayer;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.WeaponPlayer;

    import flash.geom.Point;

    import flash.geom.Rectangle;
    import flash.ui.Keyboard;

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
        private var entityManager:EntityManager;
		private var shootingProcess:ShootingProcess;
		private var moveProcess:MoveProcess;
		private var collision:Collision;
		private var renderProcess:RenderProcess;
		private var time:Date;
		private var destroyProcess:DestroyProcess;
		private var deltaTime:Number;
		private var BossButton:Button;


        //DEBUG:
        private var touchPosition:Point = new Point();

		public function Game()
        {
	        AssetsManager.start();
	        entityManager = EntityManager.entityManager;
	        moveProcess = new MoveProcess(entityManager);
	        shootingProcess = new ShootingProcess(entityManager);
	        collision = new Collision(entityManager);
	        destroyProcess = new DestroyProcess(entityManager);
	        renderProcess = new RenderProcess(entityManager);


            addChild(AssetsManager.getImage(GameConstants.BACKGROUND));
			addChild(GameStage.gameStage);

	        startGame();
			addChild(GameStage.gameStage)
			GameStage.gameStage.init();
			GameStage.gameStage.loadLevel();

			addChild(BossButton = new Button(AssetsLoader.getTexture(GameConstants.BUTTON),"BOSS BUTTON"));
			BossButton.x = 560;
			BossButton.fontName = "TestFont";

			startGame();
		}

		private function startGame():void
		{
			time = new Date();
			deltaTime = time.time;
			addEventListener(Event.ENTER_FRAME, update);
			addEventListener(TouchEvent.TOUCH, onTouch);

            Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, debugFunction);
			BossButton.addEventListener(Event.TRIGGERED, onButtonClick);
		}

		private function onButtonClick(event:Event):void {
			trace("Boss is Spawning!")
			GameStage.gameStage.switchToBoss();
			removeChild(BossButton,true);
		}

		private function update(event:Event):void
		{
			time = new Date();
			deltaTime = time.time - deltaTime;

			moveProcess.update(deltaTime);
			shootingProcess.update(deltaTime);
			collision.update();
			destroyProcess.update();
			renderProcess.update();
			CollisionDummyBoxes.update()
			GameStage.gameStage.moveGameStage();

			deltaTime = time.time;
		}

        private function onTouch(e:TouchEvent):void
        {
            var touches:Vector.<Touch> = new Vector.<Touch>();
	        e.getTouches(stage, TouchPhase.BEGAN, touches);
	        e.getTouches(stage, TouchPhase.MOVED, touches);
	        e.getTouches(stage, TouchPhase.STATIONARY, touches);

            MovementPlayer.touch = null;
            WeaponPlayer.touch = null;
            for each(var touch:Touch in touches)
                if(touch.getLocation(stage).x < Starling.current.viewPort.width/2)
                    MovementPlayer.touch = touch;
                else
                    WeaponPlayer.touch = touch;

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
        }
    }
}
