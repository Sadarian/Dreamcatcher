package de.mediadesign.gd1011.dreamcatcher
{

	import flash.display3D.Context3DTextureFormat;
	import flash.media.Sound;

	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;


	public class Game extends Sprite
    {
        private var entityManager:EntityManager;
		private var shootingProcess:ShootingProcess;
		private var moveProcess:MoveProcess;
		private var collision:Collision;
		private var renderProcess:RenderProcess;
		private var time:Date;
		private var deltaTime:Number;
		private var mParticleSystems:Vector.<ParticleSystem>;
		private var mParticleSystem:ParticleSystem;

		private var Player1:MovieClip;
		private var Player2:MovieClip;

		public function Game()
        {
			//Testing AssetsHandling
			AssetsManager.start();

			//Fonts
			var testText:TextField = new TextField(600,600,"Lonely Boy is Dancing","TestFont",40,0xff0000,true)
			testText.x = 0;
			testText.y = 0;

			//Sound
			var testSound:Sound = AssetsManager.getSound("TestSound");
			testSound.play(0,0);

			//Textures
			var background:Image = AssetsManager.getImage("Background");
			 addChild(background);
			addChild(testText);

			//Particles


			mParticleSystem = AssetsManager.getParticle("testParticleConfig","testParticleTexture");
			mParticleSystem.emitterX = 620;
			mParticleSystem.emitterY = 340;

			addChild(mParticleSystem);

			//Animation
			Player2 = AssetsManager.getMovieClip("testAnimation", 6, 1, 6, 12);
			Player2.x = 530;
			Player2.y = 340;
			addChild(Player2);
			trace(Player2.isPlaying);

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
