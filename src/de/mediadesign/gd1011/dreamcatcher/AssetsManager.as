package de.mediadesign.gd1011.dreamcatcher
{
	import flash.media.Sound;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	import starling.textures.Texture;

	public class AssetsManager
	{
		private static var BitmapFontsLoaded:Boolean;

		private static var EnemyList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private static var VictimList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private static var BossList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private static var PlayerList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private static var BulletList:Vector.<MovieClip> = new Vector.<MovieClip>();
		private static var ParticleList:Vector.<ParticleSystem> = new Vector.<ParticleSystem>();

		public static const ENEMY:String = "Enemy";
		public static const ENEMY_ANIM_CONFIG:Vector.<int> = new <int>[4,2,7,8];
		public static const ENEMY_TEXTURE_NAME:String = "testAnimation";

		public static const BOSS:String = "Boss";
		public static const BOSS_ANIM_CONFIG:Vector.<int> = new <int>[6,1,6,12];
		public static const BOSS_TEXTURE_NAME:String = "testAnimation";

		public static const PLAYER:String = "Player";
		public static const PLAYER_ANIM_CONFIG:Vector.<int> = new <int>[6,1,6,12];
		public static const PLAYER_TEXTURE_NAME:String = "testAnimation";

		public static const VICTIM:String = "Victim";
		public static const VICTIM_ANIM_CONFIG:Vector.<int> = new <int>[6,1,6,12];
		public static const VICTIM_TEXTURE_NAME:String = "testAnimation";

		public static const BULLET:String = "Bullet";
		public static const BULLET_ANIM_CONFIG:Vector.<int> = new <int>[6,1,6,12];
		public static const BULLET_TEXTURE_NAME:String = "testAnimation";

		public static const PARTICLE:String = "Particle";
		public static const PARTICLE_CONFIG:String = "testParticleConfig";
		public static const PARTICLE_TEXTURE:String = "testParticleTexture";

		public static const BITMAP_FONT_TEXTURE:String = "testBitmapFont";
		public static const BITMAP_FONT_CONFIG:String = "testBitmapFontXml";


		public static function start():void
		{
			//Preparing BitMapFonts
			if (!BitmapFontsLoaded)
			{
				AssetsLoader.loadBitmapFonts(BITMAP_FONT_TEXTURE,BITMAP_FONT_CONFIG);
				BitmapFontsLoaded = true;
			}
			//Preparing Animation

			//Enemy
			while ( EnemyList.length < 10)
			{
				EnemyList.push(createMovieClip(ENEMY_TEXTURE_NAME,ENEMY_ANIM_CONFIG));
			}

			//Boss
			while ( BossList.length < 1)
			{
				BossList.push(createMovieClip(BOSS_TEXTURE_NAME,BOSS_ANIM_CONFIG));
			}

			//Victim
			while ( VictimList.length < 1)
			{
				VictimList.push(createMovieClip(VICTIM_TEXTURE_NAME,VICTIM_ANIM_CONFIG));
			}

			//Player
			while ( PlayerList.length < 1)
			{
				PlayerList.push(createMovieClip(PLAYER_TEXTURE_NAME,PLAYER_ANIM_CONFIG));
			}

			//Bullet
			while ( BulletList.length < 15)
			{
					BulletList.push(createMovieClip(BULLET_TEXTURE_NAME,BULLET_ANIM_CONFIG));
			}

			//Preparing Sounds
			AssetsLoader.prepareSounds();
		}

		public static function getMovieClip(item:String):MovieClip
		{
			switch (item)
			{
				case ENEMY:
				{
					if (EnemyList.length != 0 )
					{
						trace("Enemy was given from List");
						return EnemyList.shift();
					}
					else
					{
						EnemyList.push(createMovieClip(ENEMY_TEXTURE_NAME,ENEMY_ANIM_CONFIG));
						trace("Enemy was created")
						return EnemyList.shift();
					}
				}

				case VICTIM:
				{
					if (VictimList.length != 0 )
					{
						trace("Victim was given from List");
						return VictimList.shift();
					}
					else
					{
						VictimList.push(createMovieClip(VICTIM_TEXTURE_NAME,VICTIM_ANIM_CONFIG));
						trace("Victim was created")
						return VictimList.shift();
					}
				}

				case BOSS:
				{
					if (BossList.length != 0 )
					{
						trace("Boss was given from List");
						return BossList.shift();
					}
					else
					{
						BossList.push(createMovieClip(BOSS_TEXTURE_NAME,BOSS_ANIM_CONFIG));
						trace("Boss was created")
						return BossList.shift();
					}
				}

				case PLAYER:
				{
					if (PlayerList.length != 0 )
					{
						trace("Player was given from List");
						return PlayerList.shift();
					}
					else
					{
						PlayerList.push(createMovieClip(PLAYER_TEXTURE_NAME,PLAYER_ANIM_CONFIG));
						trace("Player was created")
						return PlayerList.shift();
					}
				}

				case BULLET:
				{
					if (BulletList.length != 0 )
					{
						trace("Bullet was given from List");
						return BulletList.shift();
					}
					else
					{
						BulletList.push(createMovieClip(PLAYER_TEXTURE_NAME,PLAYER_ANIM_CONFIG));
						trace("Bullet was created")
						return BulletList.shift();
					}
				}

				default :
				{
				throw new ArgumentError(item+" does not Exist! Only Player,Enemy,Boss or Victim");
				return null;
				}
			}
			return null;
		}

		public static function getImage(item:String):Image
		{
			var newImage:Image = new Image(AssetsLoader.getTexture(item));;
			return newImage;
		}

		public static function getParticleSystem(item:String):ParticleSystem
		{
			switch (item)
			{
				case PARTICLE:
				{
					if (ParticleList.length != 0 )
					{
						trace("Particle System was given from List");
						return ParticleList.shift();
					}
					else
					{
						ParticleList.push(createParticleSystem(PARTICLE_CONFIG,PARTICLE_TEXTURE));
						trace("Particle System created")
						return ParticleList.shift();
					}
				}

				default :
				{
					throw new ArgumentError(item+" does not Exist! Only 'Particle' is valid");
					return null;
				}
			}
			return null;
		}

		public static function getSound(item:String):Sound
		{
			var newSound:Sound = AssetsLoader.getSound(item);
			return newSound;
		}

		private static function createMovieClip(assetName:String, v:Vector.<int>):MovieClip
		{
			var newClip:MovieClip;
			var frames:Vector.<Texture> = AssetsLoader.createAtlasAnim(assetName,v[0],v[1],v[2]).getTextures(assetName);
			newClip = new MovieClip(frames, v[3]);
			newClip.play();
			Starling.juggler.add(newClip);
			return newClip;
		}

		private static function createParticleSystem(config:String,texture:String):ParticleSystem
		{
			var newConfig:XML = AssetsLoader.getXML(config);
			var newTexture:Texture = Texture(AssetsLoader.getTexture(texture));
			var newPDParticleSystem:ParticleSystem = new PDParticleSystem(newConfig, newTexture);
			Starling.juggler.add(newPDParticleSystem);
			return newPDParticleSystem;
		}

		public static function addMovieClip(clip:MovieClip,item:String):void
		{
			switch (item)
			{
				case ENEMY:
				{
					EnemyList.push(clip);
					trace("Enemy was added to EnemyList")
				}

				case VICTIM:
				{
					VictimList.push(clip);
					trace("Victim was added to VictimList")
				}

				case BOSS:
				{
					BossList.push(clip);
					trace("Boss was added to BossList")
				}

				case PLAYER:
				{
					PlayerList.push(clip);
					trace("Player was added to PlayerList")
				}

				case BULLET:
				{
					BulletList.push(clip);
					trace("Bullet was added to PlayerList")
				}

				default :
				{
					throw new ArgumentError(item+" does not Exist! Only Player,Enemy,Boss or Victim can be added");
				}
			}
		}

	}
}
