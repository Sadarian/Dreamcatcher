package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponBoss;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementEnemy;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPowerUp;
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
		public static const POWERUP:String = "PowerUp";

		public static const TEST_SOUND:String = "TestSound";
		public static const SOUND_LIST:Vector.<String> = new <String>[TEST_SOUND];

		public static const BACKGROUND:String = "StaticBackground";
		public static const BUTTON:String ="Button";

		//Properties of the GameStage (LVL1)
		public static const MAIN_STAGE_IMAGE_LIST:Array = ["Main_1","Main_2","Main_3"];
		public static const BUSH_IMAGE_LIST:Array = ["Bush_1","Bush_2","Bush_3"];
		public static const FOREST_LIST:Array = [["Forest_1"], ["Forest_2"], ["Forest_3"]];
		public static const FOG_LIST:Array = [["FogAnim1_1"],["FogAnim1_1"],["FogAnim1_1"]];
		public static const BACKGROUND_IMAGE_LIST:Array = ["ScrollingBackground","ScrollingBackground","ScrollingBackground"];
		public static const FOREGROUND_IMAGE_LIST:Array = ["Front_1","Front_2","Front_3","Front_4","Front_5"];
		public static const GAME_STAGE_MOVMENT_SPEEDS:Vector.<Number> = new <Number>[1,2,3,6,7,8];

		public static const MAIN_STAGE_IMAGE_LIST_BOSS:Array = ["Main_1","Main_2","Main_3"];
		public static const BUSH_IMAGE_LIST_BOSS:Array = ["Bush_1","Bush_2","Bush_3"];
		public static const FOREST_LIST_BOSS:Array = [["Forest_1"], ["Forest_2"], ["Forest_3"]];
		public static const FOG_LIST_BOSS:Array = [["FogAnim1_1"],["FogAnim1_1"],["FogAnim1_1"]];
		public static const BACKGROUND_IMAGE_LIST_BOSS:Array = ["ScrollingBackground","ScrollingBackground","ScrollingBackground"];
		public static const FOREGROUND_IMAGE_LIST_BOSS:Array = ["Front_1","Front_2","Front_3","Front_4","Front_5"];
		public static const BOSS_SPEED_REDUCTION:Number = 0.15;

		public static const PLAYER:String = "Player";
	    public static const PLAYERARM:String = "PlayerArm";
		public static const VICTIM1:String = "Victim1";
        public static const VICTIM2:String = "Victim2";
        public static const ENEMY:String = "Enemy";
        public static const CHARGER:String = "Charger";
        public static const BOSS1:String = "Boss1";

		public static const PLAYER_BULLET:String = "PlayerBullet";
	    public static const ENEMY_BULLET:String = "EnemyBullet";
        public static const BOSS1_BULLET:String = "Boss1Bullet";

        public static const POWERUP_FIRE_RATE:String = "PowerUpFireRate";
        public static const POWERUP_FREEZE:String = "PowerUpFreeze";
        public static const POWERUP_HEALTH:String = "PowerUpHealth";

        private static var _meleeDamage:Vector.<Number>;
	    private static var _playerMovementBorder:Rectangle;
        private static var _playerStartPosition:Point;
        private static var _victimTimeUntilMid:Number;

        //States and Defaults for Animations:
        public static const Player_States:Array =["CloseCombat", "Die", "Hit"];

        public static const PlayerArm_States:Array =["CloseCombat", "Die", "Hit"];

        public static const Enemy_States:Array =["Die", "Hit", "DieCloseCombat", "DeadWalk"];
        public static const Charger_States:Array =["Die", "CloseCombat", "DieCloseCombat"];

        public static const Victim1_States:Array =["Die", "Walk", "Fear"];
        public static const Victim1_Default:String = "Eat";

        public static const Victim2_States:Array =["Die", "Walk", "Fear", "DieHead"];
        public static const Victim2_Default:String = "Eat";

        public static const Boss1_States:Array =["CloseCombat", "Die", "Shoot"];

        private static var _victimMovementBorderMax:Number;
        private static var _victimMovementBorderMin:Number;
        private static var _victimDirectionBorderMax:Number;
        private static var _victimDirectionBorderMin:Number;

        private static var _bossShootsUntilCharge:Number;
        private static var _bossFadingInTime:Number;
        private static var _bossDistanceBorder:Number;
        private static var _bossChargeSpeedMultiplier:Number;

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
            new WeaponBoss();
	        new MovementPowerUp();
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
            if(data.playerStartPosition) _playerStartPosition = new Point(data.playerStartPosition[0],
                                                                          data.playerStartPosition[1]);

            if(data.victimMovementBorder) _victimMovementBorderMax = data.victimMovementBorder[0];
            if(data.victimMovementBorder) _victimMovementBorderMin = data.victimMovementBorder[1];
            if(data.victimDirectionBorders) _victimDirectionBorderMax = data.victimDirectionBorders[0];
            if(data.victimDirectionBorders) _victimDirectionBorderMin = data.victimDirectionBorders[1];

            if(data.victimTimeUntilMid) _victimTimeUntilMid = data.victimTimeUntilMid;
            if(data.bossShootsUntilCharge) _bossShootsUntilCharge = data.bossShootsUntilCharge;
            if(data.bossFadingInTime) _bossFadingInTime = data.bossFadingInTime;
            if(data.bossDistanceBorder) _bossDistanceBorder = data.bossDistanceBorder;
            if(data.bossChargeSpeedMultiplier) _bossChargeSpeedMultiplier = data.bossChargeSpeedMultiplier;
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
            dataArray[9] = GraphicsManager.graphicsManager.getMovieClip(dataArray[0]);
			if(data.points) dataArray[10] = (data.points[0]); else throw new ArgumentError(type + " has no Points declared!");

            stream.close();
            return dataArray;
        }

        public static function loadSpawnData(levelIndex:int = 1):Array
        {
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath("Configs/ConfigSpawnLevel"+levelIndex+".json"), FileMode.READ);
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
                case(BOSS1):
                    pos = 2;
                    break;
                default:
                    return 0;
            }
            return _meleeDamage[pos];
        }

        public static function get victimTimeUntilMid():Number {
            return _victimTimeUntilMid;
        }

        public static function get bossShootsUntilCharge():Number
        {
            return _bossShootsUntilCharge;
        }

        public static function get bossFadingInTime():Number
        {
            return _bossFadingInTime;
        }
        public static function get bossDistanceBorder():Number
        {
            return _bossDistanceBorder;
        }

        public static function get bossChargeSpeedMultiplier():Number
        {
            return _bossChargeSpeedMultiplier;
        }

        public static function get victimMovementBorderMax():Number
        {
            return _victimMovementBorderMax;
        }

        public static function get victimMovementBorderMin():Number
        {
            return _victimMovementBorderMin;
        }

        public static function get victimDirectionBorderMax():Number
        {
            return _victimDirectionBorderMax;
        }

        public static function get victimDirectionBorderMin():Number
        {
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
