package de.mediadesign.gd1011.dreamcatcher
{
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
        public static const COLLISION_BITMAP:String = "CollisionBitmap";

        public static const PLAYER_DATA:String = "ConfigPlayer.json";

        /*
         All variables are private, with an public getter.
         They shouldn't be changed from anywhere else!
         */
<<<<<<< HEAD
	    private static var _player:String;
		private static var _bossName:String;
	    private static var _playerStartPosition:Point;
=======

	    private static var _playerMovementBorder:Rectangle;
        private static var _playerStartPosition:Point;
>>>>>>> feature/shooting

        /*
         Allows the usage of custom configs, but normally uses Config.json,
         also it will only overwrite data of the config which exists!
         */
        public static function init(path:String = "Config.json"):void
        {
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath(path), FileMode.READ);
            setConstants(JSON.parse(stream.readUTFBytes(stream.bytesAvailable)));
            stream.close();
        }

        private static function setConstants(data:Object):void
        {
<<<<<<< HEAD
            if(data.playerStartXPosition && data.playerStartYPosition) _playerStartPosition = new Point(data.playerStartXPosition, data.playerStartYPosition);
	        _player = "Player";
	        _bossName = "Boss";
=======
            if(data.playerMovementBorder) _playerMovementBorder = new Rectangle(data.playerMovementBorder[0],
                                                                                data.playerMovementBorder[1],
                                                                                data.playerMovementBorder[2],
                                                                                data.playerMovementBorder[3]);
            if(data.playerStartPosition) _playerStartPosition = new Point(data.playerStartPosition[0],
                                                                          data.playerStartPosition[1]);
        }

        public static function getData(type:String):Array
        {
            var dataArray:Array = [];
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath(type), FileMode.READ);
            var data:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));

            if(data.name) dataArray[0] = (data.name as String); else throw new ArgumentError(type + " has no name declared!");
            if(data.health) dataArray[1] = (data.health as Number); else throw new ArgumentError(type + " has no health declared!");
            if(data.movementSystem) dataArray[2] = new(getDefinitionByName("de.mediadesign.gd1011.dreamcatcher.Interfaces." + data.movementSystem) as Class)();
                else throw new ArgumentError(type + " has no movementSystem declared!");
            if(data.movementSpeed) dataArray[3] = (data.movementSpeed as Number); else throw new ArgumentError(type + " has no movementSpeed declared!");
            if(data.movementSystem) dataArray[4] = new(getDefinitionByName("de.mediadesign.gd1011.dreamcatcher.Interfaces." + data.weaponSystem) as Class)();
                else throw new ArgumentError(type + " has no weaponSystem declared!");
            if(data.weaponSpeed) dataArray[5] = (data.weaponSpeed as Number); else throw new ArgumentError(type + " has no weaponSpeed declared!");
            if(data.collisionMode) dataArray[6] = (data.collisionMode as String); else throw new ArgumentError(type + " has no collisionMode declared!");
            if(data.collisionPoint) dataArray[7] = new Point(data.collisionPoint[0], data.collisionPoint[1]); else throw new ArgumentError(type + " has no collisionPoint declared!");
            if(data.collisionValues) dataArray[8] = (data.collisionValues as Array); else throw new ArgumentError(type + " has no collisionValues declared!");
            dataArray[9] = AssetManager.playerWalkCycle();

            stream.close();
            return dataArray;
>>>>>>> feature/shooting
        }

        public static function get playerMovementBorder():Rectangle
        {
            return _playerMovementBorder;
        }

<<<<<<< HEAD
		public static function get playerStartPosition():Point {
			return _playerStartPosition;
		}

		public static function get bossName():String {
			return _bossName;
		}
	}
=======
        public static function get playerStartPosition():Point
        {
            return _playerStartPosition;
        }
    }
>>>>>>> feature/shooting
}
