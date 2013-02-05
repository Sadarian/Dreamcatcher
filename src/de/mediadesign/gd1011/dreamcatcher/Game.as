package de.mediadesign.gd1011.dreamcatcher
{

    import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementPlayer;
    import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
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
		private var deltaTime:Number;

		public function Game()
        {
	        var background:Image = new Image(Assets.getTexture("Background"));
	        addChild(background);

            entityManager = new EntityManager();
	        moveProcess = new MoveProcess();
	        collision = new Collision();
	        renderProcess = new RenderProcess();

	        startGame();
		}

		private function startGame():void {
			time = new Date();
			deltaTime = time.time;
			addEventListener(Event.ENTER_FRAME, update);
            addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function update(event:Event):void
		{
			time = new Date();
			deltaTime = time.time - deltaTime;

			//shootingProcess.update(entityManager, deltaTime);
			moveProcess.update(entityManager, deltaTime);
			collision.update(entityManager);
			renderProcess.update(entityManager);

			deltaTime = time.time;
		}

        private function onTouch(e:TouchEvent):void
        {
            var touches:Vector.<Touch> = new Vector.<Touch>();
            e.getTouches(stage, TouchPhase.BEGAN, touches);
            e.getTouches(stage, TouchPhase.MOVED, touches);
            e.getTouches(stage, TouchPhase.STATIONARY, touches);

            MovementPlayer.setTouch(touches);
        }
    }
}
