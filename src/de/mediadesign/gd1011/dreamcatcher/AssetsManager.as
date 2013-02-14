package de.mediadesign.gd1011.dreamcatcher
{
	import flash.media.Sound;

	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	import starling.extensions.ParticleSystem;
	import starling.textures.Texture;

	public class AssetsManager
	{
		private static var BitmapFontsLoaded:Boolean;

		private static var EnemyList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private static var VictimList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private static var BossList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private static var PlayerList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private static var PlayerBulletList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private static var EnemyBulletList:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private static var ParticleList:Vector.<ParticleSystem> = new Vector.<ParticleSystem>();


		public static function start():void
		{
			//Preparing BitMapFonts
			if (!BitmapFontsLoaded)
			{
				AssetsLoader.loadBitmapFonts(GameConstants.BITMAP_FONT_TEXTURE,GameConstants.BITMAP_FONT_CONFIG);
				BitmapFontsLoaded = true;
			}
			//Preparing Animation

			//Enemy
			while ( EnemyList.length < 10)
			{
				EnemyList.push(new Sprite());
				EnemyList[EnemyList.length-1].addChild(createMovieClip(GameConstants.ENEMY_TEXTURE_NAME,GameConstants.ENEMY_ANIM_CONFIG));

			}

			//Boss
			while ( BossList.length < 1)
			{
				BossList.push(new Sprite());
				BossList[BossList.length-1].addChild(createMovieClip(GameConstants.BOSS_TEXTURE_NAME,GameConstants.BOSS_ANIM_CONFIG));
			}

			//Victim
			while ( VictimList.length < 1)
			{
				VictimList.push(new Sprite());
				VictimList[VictimList.length-1].addChild(createMovieClip(GameConstants.VICTIM_TEXTURE_NAME,GameConstants.VICTIM_ANIM_CONFIG));
			}

			//Player
			while ( PlayerList.length < 1)
			{
				PlayerList.push(new Sprite());
				PlayerList[PlayerList.length-1].addChild(createMovieClip(GameConstants.PLAYER_TEXTURE_NAME,GameConstants.PLAYER_ANIM_CONFIG));
				PlayerList[PlayerList.length-1].addChild(createMovieClip(GameConstants.PLAYER_ARM_TEXTURE_NAME, GameConstants.PLAYER_ARM_ANIM_CONFIG));
			}

			//Bullet
			while ( PlayerBulletList.length < 15)
			{
				PlayerBulletList.push(new Sprite());
				PlayerBulletList[PlayerBulletList.length-1].addChild(createMovieClip(GameConstants.PLAYER_BULLET_TEXTURE_NAME,GameConstants.PLAYER_BULLET_ANIM_CONFIG));
			}

			while ( EnemyBulletList.length < 15)
			{
				EnemyBulletList.push(new Sprite());
				EnemyBulletList[EnemyBulletList.length-1].addChild(createMovieClip(GameConstants.ENEMY_BULLET_TEXTURE_NAME,GameConstants.ENEMY_BULLET_ANIM_CONFIG));
			}

			//Preparing Sounds
			AssetsLoader.prepareSounds();
		}

		public static function getMovieClip(item:String):DisplayObject
		{
			switch (item)
			{
				case GameConstants.ENEMY:
				{
					if (EnemyList.length > 0 )
					{
//						trace("Enemy was given from List");
						return EnemyList.shift();
					}
					else
					{
						EnemyList.push(new Sprite());
						EnemyList[EnemyList.length-1].addChild(createMovieClip(GameConstants.ENEMY_TEXTURE_NAME,GameConstants.ENEMY_ANIM_CONFIG));
						trace("Enemy was created")
						return EnemyList.shift();
					}
					break;
				}

				case GameConstants.VICTIM:
				{
					if (VictimList.length > 0 )
					{
//						trace("Victim was given from List");
						return VictimList.shift();
					}
					else
					{
						VictimList.push(new Sprite());
						VictimList[VictimList.length-1].addChild(createMovieClip(GameConstants.VICTIM_TEXTURE_NAME,GameConstants.VICTIM_ANIM_CONFIG));
						trace("Victim was created")
						return VictimList.shift();
					}
					break;
				}

				case GameConstants.BOSS:
				{
					if (BossList.length > 0 )
					{
//						trace("Boss was given from List");
						return BossList.shift();
					}
					else
					{
						BossList.push(new Sprite());
						BossList[BossList.length-1].addChild(createMovieClip(GameConstants.BOSS_TEXTURE_NAME,GameConstants.BOSS_ANIM_CONFIG));
						trace("Boss was created")
						return BossList.shift();
					}
					break;
				}

				case GameConstants.PLAYER:
				{
					if (PlayerList.length > 0 )
					{
//						trace("Player was given from List");
						return PlayerList.shift();
					}
					else
					{
						PlayerList.push(new Sprite());
						PlayerList[PlayerList.length-1].addChild(createMovieClip(GameConstants.PLAYER_TEXTURE_NAME,GameConstants.PLAYER_ANIM_CONFIG));
						PlayerList[PlayerList.length-1].addChild(createMovieClip(GameConstants.PLAYER_ARM_TEXTURE_NAME, GameConstants.PLAYER_ARM_ANIM_CONFIG));
						trace("Player was created")
						return PlayerList.shift();
					}
					break;
				}

				case GameConstants.PLAYER_BULLET:
				{
					if (PlayerBulletList.length > 0 )
					{
						//trace("Bullet was given from List");
						return PlayerBulletList.shift();
					}
					else
					{
						PlayerBulletList.push(new Sprite());
						PlayerBulletList[PlayerBulletList.length-1].addChild(createMovieClip(GameConstants.PLAYER_BULLET_TEXTURE_NAME,GameConstants.PLAYER_BULLET_ANIM_CONFIG));
						trace("Player Bullet was created")
						return PlayerBulletList.shift();
					}
					break;
				}

				case GameConstants.ENEMY_BULLET:
				{
					if (EnemyBulletList.length > 0 )
					{
						//trace("Bullet was given from List");
						return EnemyBulletList.shift();
					}
					else
					{
						EnemyBulletList.push(new Sprite());
						EnemyBulletList[EnemyBulletList.length-1].addChild(createMovieClip(GameConstants.ENEMY_BULLET_TEXTURE_NAME,GameConstants.ENEMY_BULLET_ANIM_CONFIG));
						trace("Enemy Bullet was created")
						return EnemyBulletList.shift();
					}
					break;
				}

				default :
				{
				throw new ArgumentError(item+" does not Exist! Only Player,Enemy,Boss or Victim");
				}
			}
		}

		public static function getImage(item:String):Image
		{
			var newImage:Image = new Image(AssetsLoader.getTexture(item));
			return newImage;
		}

		public static function getParticleSystem(item:String):ParticleSystem
		{
			switch (item)
			{
				case GameConstants.PARTICLE:
				{
					if (ParticleList.length != 0 )
					{
						trace("Particle System was given from List");
						return ParticleList.shift();
					}
					else
					{
						ParticleList.push(createParticleSystem(GameConstants.PARTICLE_CONFIG,GameConstants.PARTICLE_TEXTURE));
						trace("Particle System created")
						return ParticleList.shift();
					}
					break;
				}

				default :
				{
					throw new ArgumentError(item+" does not Exist! Only 'Particle' is valid");
				}
			}
		}

		public static function getSound(item:String):Sound
		{
			var newSound:Sound = AssetsLoader.getSound(item);
			return newSound;
		}

		private static function createMovieClip(assetName:String, v:Vector.<int>):DisplayObject
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

		public static function addMovieClip(clip:DisplayObject,item:String):void
		{
			switch (item)
			{
				case GameConstants.ENEMY:
				{
					EnemyList.push(clip);
					trace("Enemy was added to EnemyList")
					break;
				}

				case GameConstants.VICTIM:
				{
					VictimList.push(clip);
					trace("Victim was added to VictimList")
					break;
				}

				case GameConstants.BOSS:
				{
					BossList.push(clip);
					trace("Boss was added to BossList")
					break;
				}

				case GameConstants.PLAYER:
				{
					PlayerList.push(clip);
					trace("Player was added to PlayerList");
					break;
				}

				case GameConstants.PLAYER_BULLET:
				{
					PlayerBulletList.push(clip);
					//trace("Player Bullet was added to PlayerBulletList")
					break;
				}

				case GameConstants.ENEMY_BULLET:
				{
					EnemyBulletList.push(clip);
					trace("Enemy Bullet was added to EnemyBulletList")
					break;
				}

				default :
				{
					throw new ArgumentError(item+" does not Exist! Only Player,Enemy,Boss or Victim can be added");
				}
			}
		}

	}
}
