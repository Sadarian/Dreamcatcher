package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementCharger;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementMiniBoss;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponBoss;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementEnemy;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementPowerUp;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponEnemy;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponMiniBoss;

    import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;

	public class GameConstants
    {
        //noinspection JSUnusedGlobalSymbols
        public static const UI_LIST_HD:Array = ["Credits", "Menu"];
        //noinspection JSUnusedGlobalSymbols
        public static var ENDLESS_LIST_HD:Array = ["Background1_lvl1", "Background2_lvl1","Feedback", "Intro", "Victims_Charger_Enemy_lvl2", "Boss_lvl2_Die", "Boss_lvl2", "MiniBoss"];
        //noinspection JSUnusedGlobalSymbols
        public static const LEVEL1_LIST_HD:Array = ["Background1_lvl1", "Background2_lvl1", "Boss_lvl1" ,"Feedback", "Intro", "Victims_Charger_Enemy_lvl2"];
        //noinspection JSUnusedGlobalSymbols
        public static const LEVEL2_LIST_HD:Array = ["Background1_lvl2", "Background2_lvl2", "Boss_lvl2", "Boss_lvl2_Die", "Feedback", "Intro", "Victims_Charger_Enemy_lvl2"];
		//noinspection JSUnusedGlobalSymbols
		public static const TUTORIAL_LIST_HD:Array = ["Background1_lvl1", "Background2_lvl1", "Feedback", "Victims_Charger_Enemy_lvl2"];

        //noinspection JSUnusedGlobalSymbols
        public static const UI_LIST_SD:Array = ["Credits_Menu_Tutorial"];
        //noinspection JSUnusedGlobalSymbols
        public static var ENDLESS_LIST_SD:Array = ["MiniBoss", "Boss_lvl2", "Background_Intro_lvl1_1", "Victims_Charger_Enemy_lvl2"];
        //noinspection JSUnusedGlobalSymbols
        public static const LEVEL1_LIST_SD:Array = ["Background_Intro_lvl1_1", "Boss_lvl1" ,"Victims_Charger_Enemy_lvl2"];
        //noinspection JSUnusedGlobalSymbols
        public static const LEVEL2_LIST_SD:Array = ["Background_lvl2", "Boss_lvl2", "Victims_Charger_Enemy_lvl2"];
		//noinspection JSUnusedGlobalSymbols
		public static const TUTORIAL_LIST_SD:Array = ["Background_Intro_lvl1", "Victims_Charger_Enemy_lvl2"];

        public static const COLLISION_RECTANGLE:String = "CollisionRectangle";
        //noinspection JSUnusedGlobalSymbols
        public static const COLLISION_CIRCLE:String = "CollisionCircle";
	    public static const BULLET:String = "Bullet";
		public static const POWERUP:String = "PowerUp";
		public static const TEXTBOXBUTTON:String = "TextBoxButton";

		public static const TEST_SOUND:String = "TestSound";
        //noinspection JSUnusedGlobalSymbols
		public static const SOUND_LIST:Vector.<String> = new <String>[TEST_SOUND];

		public static const BACKGROUND:String = "StaticBackground";
        //noinspection JSUnusedGlobalSymbols
		public static const BUTTON:String ="Button";

		//Properties of the GameStage (LVL1)
		public static const MAIN_STAGE_IMAGE_LIST:Array = ["Main_1","Main_2"];
		public static const BUSH_IMAGE_LIST:Array = ["Bush_1","Bush_2","Bush_3"];
        public static const BUSH_IMAGE_LIST_LVL2:Array = ["Bush_1","Bush_2"];
		public static const FOREST_LIST:Array = [["Forest_1"], ["Forest_2"], ["Forest_3"]];
		public static const FOG_LIST:Array = [["FogAnim1_1"],["FogAnim2_1"],["FogAnim3_1"]];
		public static const BACKGROUND_IMAGE_LIST:Array = ["ScrollingBackground","ScrollingBackground"];
		public static const FOREGROUND_IMAGE_LIST:Array = ["Front_1","Front_2","Front_3","Front_4","Front_5"];
		public static const GAME_STAGE_MOVEMENT_SPEEDS:Vector.<Number> = new <Number>[1,2,3,6,7,8];

		public static const MAIN_STAGE_IMAGE_LIST_BOSS:Array = ["Main_1","Main_2"];
		public static const BUSH_IMAGE_LIST_BOSS:Array = ["Bush_1","Bush_2"];
		public static const FOREST_LIST_BOSS:Array = [["Forest_1"], ["Forest_2"], ["Forest_3"]];
        public static const FOREST_LIST_BOSS_LVL2:Array = [["BossForest_1"],["BossForest_1"]];
		public static const FOG_LIST_BOSS:Array = [["FogAnim1_1"],["FogAnim2_1"],["FogAnim3_1"]];
        public static const FOG_LIST_BOSS_LVL2:Array = [["BossFront_1"],["BossFront_1"]];
		public static const BACKGROUND_IMAGE_LIST_BOSS:Array = ["ScrollingBackground","ScrollingBackground"];
        public static const BACKGROUND_IMAGE_LIST_BOSS_LVL2:Array = ["BossScrollingBackground","BossScrollingBackground"];
		public static const FOREGROUND_IMAGE_LIST_BOSS:Array = ["Front_1","Front_2","Front_3","Front_4","Front_5"];
		public static const BOSS_SPEED_REDUCTION:Number = 0.15;
		public static const TUTORIAL:Number = -2;

		public static const CREDITS:String = "CreditsText_";

		public static const PLAYER:String = "Player";
	    public static const PLAYERARM:String = "PlayerArm";
		public static const VICTIM1:String = "Victim1";
        public static const VICTIM2:String = "Victim2";
        public static const ENEMY:String = "Enemy";
        public static const CHARGER:String = "Charger";
        public static const BOSS1:String = "Boss1";
		public static const BOSS2:String = "Boss2";
        public static const MINIBOSS:String = "MiniBoss";

		public static const PLAYER_BULLET:String = "PlayerBullet";
		public static const PLAYER_STRONG_BULLET:String = "PlayerStrongBullet";
		public static const PLAYER_POWERSHOT:String = "PlayerPowershot";
	    public static const ENEMY_BULLET:String = "EnemyBullet";
        public static const BOSS1_BULLET:String = "Boss1Bullet";
        public static const BOSS2_BULLET:String = "Boss2Bullet";
        public static const BOSS2_BULLET_WEB:String = "Boss2BulletWeb";
        public static const MINIBOSS_BULLET_WEB:String = "MiniBossBulletWeb";

        public static const POWERUP_FIRE_RATE:String = "PowerUpFireRate";
        public static const POWERUP_FREEZE:String = "PowerUpFreeze";
        public static const POWERUP_HEALTH:String = "PowerUpHealth";

        private static var _meleeDamage:Vector.<Number>;
	    private static var _playerMovementBorder:Rectangle;
        private static var _playerStartPosition:Point;
        private static var _victimTimeUntilMid:Number;
        private static var _playerBulletsPowerUpSpeed:Number;

        //States and Defaults for Animations:
        //noinspection JSUnusedGlobalSymbols
        public static const Player_States:Array =["CloseCombat", "Die", "Hit", "Stand"];
        public static var Player_Default:String = "Walk";
        //noinspection JSUnusedGlobalSymbols
        public static const PlayerArm_States:Array =["CloseCombat", "Die", "Hit", "Stand"];
        //noinspection JSUnusedGlobalSymbols
        public static const PlayerBullet_States:Array =["Die"];

        //noinspection JSUnusedGlobalSymbols
        public static const Enemy_States:Array =["Die", "Hit", "DieCloseCombat", "DeadWalk"];
        //noinspection JSUnusedGlobalSymbols
        public static const Charger_States:Array =["Die", "DieCloseCombat"];

        //noinspection JSUnusedGlobalSymbols
        public static const Victim1_States:Array =["Die", "Walk", "Fear"];
        //noinspection JSUnusedGlobalSymbols
        public static const Victim1_Default:String = "Eat";

        //noinspection JSUnusedGlobalSymbols
        public static const Victim2_States:Array =["Die", "Walk", "Fear", "DieHead"];
        //noinspection JSUnusedGlobalSymbols
        public static const Victim2_Default:String = "Eat";

        //noinspection JSUnusedGlobalSymbols
        public static const Boss1_States:Array =["CloseCombat", "Die", "Shoot"];

        //noinspection JSUnusedGlobalSymbols
        public static const Boss2_States:Array =["CloseCombat", "Die", "Shoot", "ShootWeb"];

        //noinspection JSUnusedGlobalSymbols
        public static const MiniBoss_States:Array =["CloseCombat", "Die", "ShootWeb"];

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
		private static var _fanAngle:Number;

        private static var _bossWebSlow:Number;
        private static var _bossWebShotAfter:Number;

        private static var _playerBlinkInvulnerableTime:Number;
        private static var _playerBlinkDuration:Number;
        private static var _playerBlinkAmount:int;
        private static var _generalBlinkDuration:Number;
        private static var _generalBlinkAmount:int;
		private static var _growFadeSpeed:Number;
		private static var _moveToSpeed:Number;
		private static var _introTextRotation:Number;
		private static var _introTextSize:Number;
		private static var _introTextLvl1:String;
		private static var _introTextLvl2:String;
		private static var _introTextLvlEndless:String;

        private static var _endlessBossWait:Number;
        private static var _endlessMultiplierFactor:Number;

        public static function init(path:String = "Configs/"):void
        {
            new WeaponBoss();
            new MovementCharger();
	        new MovementPowerUp();
            new MovementBullet();
            new MovementEnemy();
            new MovementMiniBoss();
            new MovementVictim();
            new WeaponEnemy();
            new WeaponMiniBoss();

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
            if(data.boss2MeleeDamage) _meleeDamage.push(data.boss2MeleeDamage);
            if(data.chargerMeleeDamage) _meleeDamage.push(data.chargerMeleeDamage);
            if(data.miniBossMeleeDamage) _meleeDamage.push(data.miniBossMeleeDamage);
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
            if(data.playerBulletsPowerUpSpeed) _playerBulletsPowerUpSpeed = data.playerBulletsPowerUpSpeed;
            if(data.bossWebSlow)_bossWebSlow = data.bossWebSlow;
            if(data.bossWebShotAfter)_bossWebShotAfter = data.bossWebShotAfter;

            if(data.playerBlinkInvulnerableTime)_playerBlinkInvulnerableTime = data.playerBlinkInvulnerableTime;
            if(data.playerBlinkDuration)_playerBlinkDuration = data.playerBlinkDuration;
            if(data.playerBlinkAmount)_playerBlinkAmount = data.playerBlinkAmount;
            if(data.generalBlinkDuration)_generalBlinkDuration = data.generalBlinkDuration;
            if(data.generalBlinkAmount)_generalBlinkAmount = data.generalBlinkAmount;

			if(data.growFadeSpeed)_growFadeSpeed = data.growFadeSpeed;
			if(data.moveToSpeed)_moveToSpeed = data.moveToSpeed;
	        if(data.introTextRotation)_introTextRotation = data.introTextRotation;
	        if(data.introTextSize)_introTextSize = data.introTextSize;
	        if(data.introTextLvl1)_introTextLvl1 = data.introTextLvl1;
	        if(data.introTextLvl2)_introTextLvl2 = data.introTextLvl2;
	        if(data.introTextLvlEndless)_introTextLvlEndless = data.introTextLvlEndless;
            if(data.endlessBossWait) _endlessBossWait = data.endlessBossWait;
            if(data.endlessMultiplierFactor) _endlessMultiplierFactor = data.endlessMultiplierFactor;
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
			if(data.fanAngle) _fanAngle = data.fanAngle;
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
                case(BOSS2):
                    pos = 3;
                    break;
                case(CHARGER):
                    pos = 4;
                    break;
                case(MINIBOSS):
                    pos = 5;
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

        public static function get playerBulletsPowerUpSpeed():Number
        {
            return _playerBulletsPowerUpSpeed;
        }

        public static function get bossWebSlow():Number
        {
            return _bossWebSlow;
        }

        public static function get bossWebShotAfter():Number
        {
            return _bossWebShotAfter;
        }
        public static function get playerBlinkInvulnerableTime():Number {
            return _playerBlinkInvulnerableTime;
        }

        public static function blinkDuration(name:String):Number
        {
            if(name == PLAYER)
                return _playerBlinkDuration;
            return _generalBlinkDuration;
        }

        public static function blinkAmount(name:String):int
        {
            if(name == PLAYER)
                return _playerBlinkAmount;
            return _generalBlinkAmount;
        }
		
		public static function get fanAngle():Number {
			return _fanAngle;
		}

		public static function get moveToSpeed():Number {
			return _moveToSpeed;
		}

		public static function get growFadeSpeed():Number {
			return _growFadeSpeed;
		}
		
		public static function get introTextSize():Number {
			return _introTextSize;
		}

		public static function get introTextLvl1():String {
			return _introTextLvl1;
		}

		public static function get introTextLvl2():String {
			return _introTextLvl2;
		}

		public static function get introTextLvlEndless():String {
			return _introTextLvlEndless;
		}

		public static function get introTextRotation():Number {
			return _introTextRotation;
		}

        public static function get endlessBossWait():Number
        {
            return _endlessBossWait;
        }

        public static function get endlessMultiplierFactor():Number
        {
            return _endlessMultiplierFactor;
        }
    }
}
