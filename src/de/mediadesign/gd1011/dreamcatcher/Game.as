package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.SoundManager;

	import flash.media.Sound;
	import flash.media.SoundChannel;

<<<<<<< HEAD
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.MovementPlayer;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.WeaponPlayer;

    import starling.display.Sprite;
	import starling.events.Event;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
=======
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleSystem;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Color;


	;
>>>>>>> refs/heads/feature/AssestHandeling

	public class Game extends Sprite
    {
        private var entityManager:EntityManager;
		private var shootingProcess:ShootingProcess;
		private var moveProcess:MoveProcess;
		private var collision:Collision;
		private var renderProcess:RenderProcess;
		private var time:Date;
		private var deltaTime:Number;
		private var mParticleSystem:ParticleSystem;

		private var Enemy:MovieClip;

		public function Game()
        {
<<<<<<< HEAD
	        entityManager = new EntityManager();
	        moveProcess = new MoveProcess(entityManager);
	        shootingProcess = new ShootingProcess(entityManager);
	        collision = new Collision(entityManager);
	        renderProcess = new RenderProcess(entityManager);

            addChild(AssetManager.background());

			var player:Entity = entityManager.getEntity("Player");
	        addChild(player.movieClip);
	        //var boss:Entity = entityManager.getEntity(GameConstants.bossName);
	        //addChild(boss.movieClip);

=======
			//Testing AssetsHandling
			AssetsManager.start();

			//Textures/Images
			var background:Image = AssetsManager.getImage("Background");
			addChild(background);

			//Fonts
			var testText:TextField = new TextField(600,600,"Lonely Boy is Dancing","TestFont",40,0xff0000,true)
			testText.x = 0;
			testText.y = 0;
			addChild(testText);

			//BitMapFonts
			var bmpFontTF:TextField = new TextField(300, 150,"It is very easy to use Bitmap fonts,\nas well!", "testBitmapFont");
			bmpFontTF.fontSize = 40;
			bmpFontTF.color = Color.WHITE;
			addChild(bmpFontTF);

			//Sound
			SoundManager.createChannels();
			var testSound:SoundChannel = SoundManager.getSoundChannel("TestSound");
			SoundManager.addSound(testSound,SoundManager.TEST_SOUND);

			//Particles
			ParticleManager.start();
			mParticleSystem = ParticleManager.getParticleSystem("Particle");
			mParticleSystem.emitterX = 620;
			mParticleSystem.emitterY = 340;


			addChild(mParticleSystem);
			//Animation
			Enemy = AssetsManager.getMovieClip("Enemy");
			Enemy.x = 430;
			Enemy.y = 340;
			addChild(Enemy)


			//Filter

            entityManager = new EntityManager();
	        moveProcess = new MoveProcess();
	        collision = new Collision();
	        renderProcess = new RenderProcess();
>>>>>>> refs/heads/feature/AssestHandeling
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

            MovementPlayer.setTouch(touches);
            WeaponPlayer.setTouch(touches);
        }
    }
}
