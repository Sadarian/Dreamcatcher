package de.mediadesign.gd1011.dreamcatcher
{

	import starling.display.Sprite;
	import starling.events.Event;



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
	        entityManager = new EntityManager();
	        moveProcess = new MoveProcess();
	        shootingProcess = new ShootingProcess();
	        collision = new Collision();
	        renderProcess = new RenderProcess();

			var player:Entity = entityManager.getEntity(GameConstants.playerName);
	        addChild(AssetManager.background());
	        addChild(player.getMoviClip());

	        startGame();
		}

		private function startGame():void
		{
			time = new Date();
			deltaTime = time.time;
			addEventListener(Event.ENTER_FRAME, update);
		}

		private function update(event:Event):void
		{
			time = new Date();
			deltaTime = time.time - deltaTime;

			moveProcess.update(entityManager, deltaTime);
			shootingProcess.update(entityManager, deltaTime);
			collision.update(entityManager);
			renderProcess.update(entityManager);

			deltaTime = time.time;
		}
	}
}
