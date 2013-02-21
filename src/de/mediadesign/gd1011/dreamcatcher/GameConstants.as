package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementBullet;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementEnemy;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Movement.MovementVictim;
    import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponEnemy;
	import de.mediadesign.gd1011.dreamcatcher.Interfaces.Weapon.WeaponPlayerStraight;
	import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

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

		public static const ENEMY:String = "Enemy";
		public static const ENEMY_STATES:Array =["Walk","DeadWalk","DieCloseCombat","DieShoot","Hit"];

		public static const BOSS:String = "Boss";
		public static const BOSS_STATES:Array =["Walk","CloseCombat","Shoot","Hit"];

		public static const PLAYER:String = "Player";
		public static const PLAYER_STATES:Array =["CloseCombat","Walk","Hit","Die"];

	    public static const PLAYERARM:String = "PlayerArm";
		public static const PLAYERARM_STATES:Array =["CloseCombat","Walk","Hit","Die"];

		public static const VICTIM:String = "Victim";
		public static const VICTIM1_STATES:Array =["Die","Walk","Eat","Fear"];

		public static const PLAYER_BULLET:String = "PlayerBullet";
		public static const PLAYERBULLET_STATES:Array =["Walk"];

	    public static const ENEMY_BULLET:String = "EnemyBullet";
		public static const ENEMYBULLET_STATES:Array =["Walk"];

		public static const BOSS_BULLET:String = "BossBullet";
		public static const BOSSBULLET_STATES:Array =["Walk"];

        private static var _meleeDamage:Vector.<Number>;
	    private static var _playerMovementBorder:Rectangle;
        private static var _playerStartPosition:Point;
        private static var _victimTimeUntilMid:Number;

        public static function init(path:String = "Configs/Config.json"):void
        {
	        new WeaponPlayerStraight();
            new MovementBullet();
            new MovementEnemy();
            new MovementVictim();
            new WeaponEnemy();

            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath(path), FileMode.READ);
            setConstants(JSON.parse(stream.readUTFBytes(stream.bytesAvailable)));
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
            if(data.victimTimeUntilMid) _victimTimeUntilMid = data.victimTimeUntilMid;
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
                case(BOSS):
                    pos = 2;
                    break;
            }
            return _meleeDamage[pos];
        }

        public static function get victimTimeUntilMid():Number {
            return _victimTimeUntilMid;
        }
    }
}
