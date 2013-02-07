package de.mediadesign.gd1011.dreamcatcher
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
	import flash.geom.Point;

	public class GameConstants
    {
        /*
         All variables are private, with an public getter.
         They shouldn't be changed from anywhere else!
         */
	    private static var _player:String;
		private static var _bossName:String;
	    private static var _playerStartPosition:Point;

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
            if(data.playerStartXPosition && data.playerStartYPosition) _playerStartPosition = new Point(data.playerStartXPosition, data.playerStartYPosition);
	        _player = "Player";
	        _bossName = "Boss";
        }

	    public static function get playerName():String
	    {
		    return _player;
	    }

		public static function get playerStartPosition():Point {
			return _playerStartPosition;
		}

		public static function get bossName():String {
			return _bossName;
		}
	}
}
