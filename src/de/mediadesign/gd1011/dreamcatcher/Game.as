package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.SoundManager;

	import flash.media.Sound;
	import flash.media.SoundChannel;

	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.ParticleSystem;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.utils.Color;


	;

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
	        startGame();
		}

		private function startGame():void {
			time = new Date();
			deltaTime = time.time;
			addEventListener(Event.ENTER_FRAME, update);
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
	}
}
