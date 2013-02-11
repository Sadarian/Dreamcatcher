package de.mediadesign.gd1011.dreamcatcher
{

    import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementPlayer;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.WeaponPlayer;

    import starling.core.Starling;

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
	        entityManager = EntityManager.entityManager;
	        moveProcess = new MoveProcess(entityManager);
	        shootingProcess = new ShootingProcess(entityManager);
	        collision = new Collision(entityManager);
	        renderProcess = new RenderProcess(entityManager);

            addChild(AssetsManager.getImage(GameConstants.BACKGROUND));

			var player:Entity = entityManager.createEntity(GameConstants.PLAYER, GameConstants.playerStartPosition);
	        addChild(player.movieClip);
	        var boss:Entity = entityManager.createEntity(GameConstants.BOSS, GameConstants.bossStartPosition);
	        addChild(boss.movieClip);
	        var enemy:Entity = entityManager.createEntity(GameConstants.ENEMY, GameConstants.enemyStartPosition);
	        addChild(enemy.movieClip);
	        var victim:Entity = entityManager.createEntity(GameConstants.VICTIM, GameConstants.victimStartPosition);
	        addChild(victim.movieClip);

	        startGame();
		}

		private function startGame():void
		{
			time = new Date();
			deltaTime = time.time;
			addEventListener(Event.ENTER_FRAME, update);
            addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function update(event:Event):void
		{
			time = new Date();
			deltaTime = time.time - deltaTime;

			moveProcess.update(deltaTime);
			shootingProcess.update(deltaTime);
			collision.update();
			renderProcess.update();

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
        }
    }
}
