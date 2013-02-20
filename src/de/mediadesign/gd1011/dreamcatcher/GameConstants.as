package de.mediadesign.gd1011.dreamcatcher
{
	import de.mediadesign.gd1011.dreamcatcher.Assets.AssetsManager;
	import de.mediadesign.gd1011.dreamcatcher.Gameplay.PowerUps.PowerUps;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementEnemy;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponEnemy;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerStraight;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;

	public class GameConstants
    {

        public static const COLLISION_RECTANGLE:String = "CollisionRectangle";
        public static const COLLISION_CIRCLE:String = "CollisionCircle";
	    public static const BULLET:String = "Bullet";

		public static const TEST_SOUND:String = "TestSound";
		public static const SOUND_LIST:Vector.<String> = new <String>[TEST_SOUND];

		public static const BACKGROUND:String = "Background";
		public static const BUTTON:String ="Button";

		//Properties of the GameStage (LVL1)
		public static const MAIN_STAGE_IMAGE_LIST:Array = ["GameStage","GameStage2","GameStage3"];
		public static const BUSH_IMAGE_LIST:Array = ["GameStageFront","GameStageFront2","GameStageFront3"];
		public static const ANIMATIONS_LIST:Array = [["GameStageAnimLayer1"], ["GameStageAnimLayer2"], ["GameStageAnimLayer3"]];
		public static const FOG_LIST:Array = [["GameStageFog"],["GameStageFog2"],["GameStageFog3"]];
		public static const BACKGROUND_IMAGE_LIST:Array = ["ScrollingBackground","ScrollingBackground","ScrollingBackground"];
		public static const FOREGROUND_IMAGE_LIST:Array = ["ScrollingForeground","ScrollingForeground2","ScrollingForeground3","ScrollingForeground4","ScrollingForeground5"];
		public static const GAME_STAGE_MOVMENT_SPEEDS:Vector.<Number> = new <Number>[1,2,3,6,7,8];

		public static const MAIN_STAGE_IMAGE_LIST_BOSS:Array = ["GameStageBoss","GameStageBoss","GameStageBoss"];
		public static const BUSH_IMAGE_LIST_BOSS:Array = ["GameStageFrontBoss","GameStageFrontBoss","GameStageFrontBoss"];
		public static const ANIMATIONS_LIST_BOSS:Array = [["GameStageAnimLayerBoss"],["GameStageAnimLayerBoss"],["GameStageAnimLayerBoss"]];
		public static const FOG_LIST_BOSS:Array = [["GameStageFog"],["GameStageFog2"],["GameStageFog3"]];
		public static const BACKGROUND_IMAGE_LIST_BOSS:Array = ["ScrollingBackgroundBoss","ScrollingBackgroundBoss","ScrollingBackgroundBoss"];
		public static const FOREGROUND_IMAGE_LIST_BOSS:Array = ["ScrollingForegroundBoss","ScrollingForegroundBoss","ScrollingForegroundBoss"];
		public static const BOSS_SPEED_REDUCTION:Number = 0.15;

		public static const ENEMY:String = "Enemy";
		public static const ENEMY_ANIM_CONFIG:Vector.<int> = new <int>[4,2,8,10];
		public static const ENEMY_TEXTURE_NAME:String = "EnemyWalk";

		public static const BOSS:String = "Boss";
		public static const BOSS_ANIM_CONFIG:Vector.<int> = new <int>[3,2,6,8];
		public static const BOSS_TEXTURE_NAME:String = "BossWalk";

		public static const PLAYER:String = "Player";
		public static const PLAYER_ANIM_CONFIG:Vector.<int> = new <int>[4,2,6,12];
		public static const PLAYER_TEXTURE_NAME:String = "PlayerOnly";

	    public static const PLAYER_ARM:String = "Player_Arm";
	    public static const PLAYER_ARM_ANIM_CONFIG:Vector.<int> = new <int>[4,2,6,12];
	    public static const PLAYER_ARM_TEXTURE_NAME:String = "PlayerArm";

		public static const VICTIM:String = "Victim";
		public static const VICTIM_ANIM_CONFIG:Vector.<int> = new <int>[4,2,6,12];
		public static const VICTIM_TEXTURE_NAME:String = "VictimWalk";

		public static const PLAYER_BULLET:String = "Player_Bullet";
		public static const PLAYER_BULLET_ANIM_CONFIG:Vector.<int> = new <int>[1,1,1,12];
		public static const PLAYER_BULLET_TEXTURE_NAME:String = "PlayerBullet";

	    public static const ENEMY_BULLET:String = "Enemy_Bullet";
	    public static const ENEMY_BULLET_ANIM_CONFIG:Vector.<int> = new <int>[2,1,2,12];
	    public static const ENEMY_BULLET_TEXTURE_NAME:String = "EnemyBullet";

		public static const POWERUP_FIRE_RATE:String = "Fire_Rate";
		public static const POWERUP_FREEZE:String = "Freeze";
		public static const POWERUP_HEALTH:String = "Health";

		public static const PARTICLE:String = "Particle";
		public static const PARTICLE_CONFIG:String = "testParticleConfig";
		public static const PARTICLE_TEXTURE:String = "testParticleTexture";

		public static const BITMAP_FONT_TEXTURE:String = "testBitmapFont";
		public static const BITMAP_FONT_CONFIG:String = "testBitmapFontXml";

		public static const SHAREDOBJECT:String = "Dreamcatcher";

        private static var _meleeDamage:Vector.<Number>;
	    private static var _playerMovementBorder:Rectangle;
		private static var _victimMovementBorderMax:Number;
		private static var _victimMovementBorderMin:Number;
		private static var _victimDirectionBorderMax:Number;
		private static var _victimDirectionBorderMin:Number;
        private static var _playerStartPosition:Point;
        private static var _victimTimeUntilMid:Number;

		private static var _dropChanceFireRateEnemy:Number;
		private static var _dropChanceFireRateSpecial:Number;
		private static var _durationFireRate:Number;
		private static var _fireRateIncrease:Number;
		private static var _dropChanceFreezeEnemy:Number;
		private static var _dropChanceFreezeSpecial:Number;
		private static var _durationFreeze:Number;
		private static var _slowEffect:Number;
		private static var _dropDistance:Number;
		private static var _healthGiven:Number;

        public static function init(path:String = "Configs/"):void
        {
	        new WeaponPlayerStraight();
            new MovementBullet();
            new MovementEnemy();
            new MovementVictim();
            new WeaponEnemy();

            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath(path+"Config.json"), FileMode.READ);
            setConstants(JSON.parse(stream.readUTFBytes(stream.bytesAvailable)));
            stream.close();

	        stream.open(File.applicationDirectory.resolvePath(path+"ConfigPowerUps.json"), FileMode.READ);
	        setPowerUps(JSON.parse(stream.readUTFBytes(stream.bytesAvailable)));
	        stream.close();
        }

        private static function setConstants(data:Object):void
        {
            _meleeDamage = new Vector.<Number>();
            if(data.playerMeleeDamage) _meleeDamage.push(data.playerMeleeDamage);
            if(data.enemyMeleeDamage) _meleeDamage.push(data.enemyMeleeDamage);
            if(data.bossMeleeDamage) _meleeDamage.push(data.bossMeleeDamage);
            if(data.playerMovementBorder) _playerMovementBorder = new Rectangle(data.playerMovementBorder[0],
                                                                                data.playerMovementBorder[1],
                                                                                data.playerMovementBorder[2],
                                                                                data.playerMovementBorder[3]);
	        if(data.victimMovementBorder) _victimMovementBorderMax = data.victimMovementBorder[0];
	        if(data.victimMovementBorder) _victimMovementBorderMin = data.victimMovementBorder[1];
	        if(data.victimDirectionBorders) _victimDirectionBorderMax = data.victimDirectionBorders[0];
	        if(data.victimDirectionBorders) _victimDirectionBorderMin = data.victimDirectionBorders[1];
            if(data.playerStartPosition) _playerStartPosition = new Point(data.playerStartPosition[0],
                                                                          data.playerStartPosition[1]);
            if(data.victimTimeUntilMid) _victimTimeUntilMid = data.victimTimeUntilMid;
        }

		private static function setPowerUps(data:Object):void
		{
			if(data.dropChanceFireRateEnemy) _dropChanceFireRateEnemy = data.dropChanceFireRateEnemy;
			if(data.dropChanceFireRateSpecial) _dropChanceFireRateSpecial = data.dropChanceFireRateSpecial;
			if(data.durationFireRate) _durationFireRate = data.durationFireRate;
			if(data.fireRateIncrease) _fireRateIncrease = data.fireRateIncrease;
			if(data.dropChanceFreezeEnemy) _dropChanceFreezeEnemy = data.dropChanceFreezeEnemy;
			if(data.dropChanceFreezeSpecial) _dropChanceFreezeSpecial = data.dropChanceFreezeSpecial;
			if(data.durationFreeze) _durationFreeze = data.durationFreeze;
			if(data.slowEffect) _slowEffect = data.slowEffect;
			if(data.dropDistance) _dropDistance = data.dropDistance;
			if(data.healthGiven) _healthGiven = data.healthGiven;

		}

        public static function getData(type:String):Array
        {
            var dataArray:Array = [];
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath("Configs/Config"+type+".json"), FileMode.READ);
            var data:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));

            if(data.name) dataArray[0] = (data.name as String); else throw new ArgumentError(type + " has no name declared!");
            if(data.health) dataArray[1] = (data.health as Number); else throw new ArgumentError(type + " has no health declared!");
            if(data.movementSystem) dataArray[2] = (data.movementSystem == "null")?null:new(getDefinitionByName("de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement." + data.movementSystem) as Class)();
              //  else throw new ArgumentError(type + " has no movementSystem declared!");
            if(data.movementSpeed) dataArray[3] = (data.movementSpeed as Number); else throw new ArgumentError(type + " has no movementSpeed declared!");
            if(data.weaponSystem) dataArray[4] = (data.weaponSystem == "null")?null:new(getDefinitionByName("de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon." + data.weaponSystem) as Class)();
             //   else throw new ArgumentError(type + " has no weaponSystem declared!");
            if(data.weaponSpeed) dataArray[5] = (data.weaponSpeed == 0)?0:(data.weaponSpeed as Number); else throw new ArgumentError(type + " has no weaponSpeed declared!");
            if(data.collisionMode) dataArray[6] = (data.collisionMode as String); else throw new ArgumentError(type + " has no collisionMode declared!");
            if(data.collisionPoint) dataArray[7] = new Point(data.collisionPoint[0], data.collisionPoint[1]); else throw new ArgumentError(type + " has no collisionPoint declared!");
	        if(data.collisionValues) dataArray[8] = new Point(data.collisionValues[0], data.collisionValues[1]); else throw new ArgumentError(type + " has no collisionValues declared!");
            dataArray[9] = AssetsManager.getMovieClip(type);
	        if(data.points) dataArray[10] = (data.points[0]); else throw new ArgumentError(type + " has no Points declared!");

            stream.close();
            return dataArray;
        }

        public static function loadSpawnData():Array
        {
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath("Configs/ConfigSpawn.json"), FileMode.READ);
            var data:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));
            return data.enemies;
        }

        public static function get playerMovementBorder():Rectangle
        {
            return _playerMovementBorder;
        }

        public static function get playerStartPosition():Point
        {
            return _playerStartPosition;
        }

        public static function meleeDamage(name:String):Number {
            var pos:int;
            switch (name)
            {
                case(PLAYER):
                    pos = 0;
                    break;
                case(ENEMY):
                    pos = 1;
                    break;
                case(BOSS):
                    pos = 2;
                    break;
            }
            return _meleeDamage[pos];
        }

        public static function get victimTimeUntilMid():Number {
            return _victimTimeUntilMid;
        }

		public static function get victimMovementBorderMax():Number {
			return _victimMovementBorderMax;
		}

		public static function get victimMovementBorderMin():Number {
			return _victimMovementBorderMin;
		}

		public static function get victimDirectionBorderMax():Number {
			return _victimDirectionBorderMax;
		}

		public static function get victimDirectionBorderMin():Number {
			return _victimDirectionBorderMin;
		}

		public static function get dropChanceFireRateEnemy():Number {
			return _dropChanceFireRateEnemy;
		}

		public static function get dropChanceFireRateSpecial():Number {
			return _dropChanceFireRateSpecial;
		}

		public static function get durationFireRate():Number {
			return _durationFireRate;
		}

		public static function get fireRateIncrease():Number {
			return _fireRateIncrease;
		}

		public static function get dropChanceFreezeEnemy():Number {
			return _dropChanceFreezeEnemy;
		}

		public static function get dropChanceFreezeSpecial():Number {
			return _dropChanceFreezeSpecial;
		}

		public static function get durationFreeze():Number {
			return _durationFreeze;
		}

		public static function get slowEffect():Number {
			return _slowEffect;
		}

		public static function get dropDistance():Number {
			return _dropDistance;
		}

		public static function get healthGiven():Number {
			return _healthGiven;
		}
	}
}
