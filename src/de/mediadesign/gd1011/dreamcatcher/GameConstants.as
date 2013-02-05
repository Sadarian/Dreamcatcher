package de.mediadesign.gd1011.dreamcatcher
{
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
	[SWF(width="1280", height="800", frameRate="60", backgroundColor="#ffffff")]
    public class GameConstants
    {
        /*
         All variables are private, with an public getter.
         They shouldn't be changed from anywhere else!
         */
        private static var _testNumber:Number;
        private static var _testString:String;
        private static var _testBoolean:Boolean;
	    private static var _player:String;

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
            if(data.testNumber) _testNumber = data.testNumber;
            if(data.testString) _testString = data.testString;
            if(data.testBoolean) _testBoolean = data.testBoolean;
	        _player = "Player";
        }

        public static function get testNumber():Number
        {
            return _testNumber;
        }

        public static function get testString():String
        {
            return _testString;
        }

        public static function get testBoolean():Boolean
        {
            return _testBoolean;
        }

	    public static function get playerName():String
	    {
		    return _player;
	    }
    }
}
