package de.mediadesign.gd1011.dreamcatcher
{
	import flash.media.Sound;
	import flash.utils.Dictionary;

	import org.hamcrest.object.isFalse;

	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	import starling.textures.Texture;

	public class AssetsManager
	{
		private static var Assets:Dictionary = new Dictionary();
		private static var MovieArray:Vector.<MovieClip> = new Vector.<MovieClip>;
		private static var ParticleArray:Vector.<ParticleSystem> = new Vector.<ParticleSystem>;
		private static var ImageArray:Vector.<Image> = new Vector.<Image>;
		private static var SoundArray:Vector.<Sound> = new Vector.<Sound>;

		//Constants for Keys
		private static const MOVIE:String 		="MOVIE";
		private static const PARTICLE:String 	="PARTICLE";
		private static const IMAGE:String		="IMAGE";
		private static const SOUND:String 		="SOUND";

		//Keying Arrays in Dictionary
		Assets[MovieArray] 			= MOVIE;
		Assets[ParticleArray]		= PARTICLE;
		Assets[ImageArray]			= IMAGE;
		Assets[SoundArray]			= SOUND;

		//Preparing Sounds
		AssetsLoader.prepareSounds();

		public static function start():void
			{
				trace(Assets[MovieArray]);

				//Preparing Sounds
				AssetsLoader.prepareSounds();
			}

		public static function getMovieClip(item:String = null, w:int = 0, h:int = 0, steps:int = 0, frameAmount:int = 0):MovieClip
		{
			if(Assets[MovieArray] != undefined)
				{
					var newClip:MovieClip;
					var frames:Vector.<Texture> = AssetsLoader.createAtlasAnim(item,w,h,steps).getTextures(item);
					newClip = new MovieClip(frames, frameAmount);
					newClip.play();
					Starling.juggler.add(newClip);
					Assets[MovieArray] = newClip;
				}
			return Assets[MovieArray];
		}

		public static function getImage(item:String = null):Image
		{
			if(Assets[ImageArray] != undefined)
			{
				var newImage:Image = new Image(AssetsLoader.getTexture(item));
				Assets[ImageArray] = newImage;
			}
			return Assets[ImageArray];
		}

		public static function getParticle(config:String = null, texture:String = null):ParticleSystem
		{
			if (Assets[ParticleArray]!= undefined)
			{
				var newConfig:XML = AssetsLoader.getXML(config);
				var newTexture:Texture = Texture(AssetsLoader.getTexture(texture));
				var newPDParticleSystem:ParticleSystem = new PDParticleSystem(newConfig, newTexture);
				Starling.juggler.add(newPDParticleSystem);
				newPDParticleSystem.start();
				Assets[ParticleArray] = newPDParticleSystem;
			}
			return Assets[ParticleArray];
		}

		public static function getSound(item:String = null):Sound
		{
			if(Assets[SoundArray]!= undefined)
			{
				var newSound:Sound = AssetsLoader.getSound(item);
				Assets[SoundArray] = newSound;
			}
			return Assets[SoundArray]
		}

	}
}
