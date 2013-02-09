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

		public static const TEST_SOUND:String = "TestSound";
		public static const SOUND_LIST:Vector.<String> = new <String>[TEST_SOUND];

		public static const GAME_STAGE_LIST:Vector.<String> = new <String>[GAME_STAGE,GAME_STAGE_FRONT];

		public static const BACKGROUND:String = "Background";
		public static const GAME_STAGE:String ="GameStage";
		public static const GAME_STAGE2:String ="GameStage2";
		public static const GAME_STAGE3:String ="GameStage3";
		public static const GAME_STAGE_FRONT:String ="GameStageFront";
		public static const GAME_STAGE_ANIM:String ="GameStageAnimLayer";
		public static const GAME_STAGE_MOVMENT_SPEEDS:Vector.<Number> = new <Number>[5,2,1];

		public static const ENEMY:String = "Enemy";
		public static const ENEMY_ANIM_CONFIG:Vector.<int> = new <int>[4,2,7,8];
		public static const ENEMY_TEXTURE_NAME:String = "testAnimation";

		public static const BOSS:String = "Boss";
		public static const BOSS_ANIM_CONFIG:Vector.<int> = new <int>[3,2,6,12];
		public static const BOSS_TEXTURE_NAME:String = "Boss";

		public static const PLAYER:String = "Player";
		public static const PLAYER_ANIM_CONFIG:Vector.<int> = new <int>[4,2,6,12];
		public static const PLAYER_TEXTURE_NAME:String = "PlayerOnly";

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

	    private static var _playerMovementBorder:Rectangle;
        private static var _playerStartPosition:Point;
	    private static var _bossStartPosition:Point;

        public static function init(path:String = "Config.json"):void
        {
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath(path), FileMode.READ);
            setConstants(JSON.parse(stream.readUTFBytes(stream.bytesAvailable)));
            stream.close();
        }

        private static function setConstants(data:Object):void
        {
            if(data.playerMovementBorder) _playerMovementBorder = new Rectangle(data.playerMovementBorder[0],
                                                                                data.playerMovementBorder[1],
                                                                                data.playerMovementBorder[2],
                                                                                data.playerMovementBorder[3]);
            if(data.playerStartPosition) _playerStartPosition = new Point(data.playerStartPosition[0],
                                                                          data.playerStartPosition[1]);
	        if(data.bossStartPosition) _bossStartPosition = new Point(data.bossStartPosition[0],
			                                                          data.bossStartPosition[1]);
        }

        public static function getData(type:String):Array
        {
            var dataArray:Array = [];
            var stream:FileStream = new FileStream();
            stream.open(File.applicationDirectory.resolvePath("Config"+type+".json"), FileMode.READ);
            var data:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));

            if(data.name) dataArray[0] = (data.name as String); else throw new ArgumentError(type + " has no name declared!");
            if(data.health) dataArray[1] = (data.health as Number); else throw new ArgumentError(type + " has no health declared!");
            if(data.movementSystem) dataArray[2] = (data.movementSystem == "null")?null:new(getDefinitionByName("de.mediadesign.gd1011.dreamcatcher.Interfaces." + data.movementSystem) as Class)();
                else throw new ArgumentError(type + " has no movementSystem declared!");
            if(data.movementSpeed) dataArray[3] = (data.movementSpeed as Number); else throw new ArgumentError(type + " has no movementSpeed declared!");
            if(data.weaponSystem) dataArray[4] = (data.weaponSystem == "null")?null:new(getDefinitionByName("de.mediadesign.gd1011.dreamcatcher.Interfaces." + data.weaponSystem) as Class)();
                else throw new ArgumentError(type + " has no weaponSystem declared!");
            if(data.weaponSpeed) dataArray[5] = (data.weaponSpeed as Number); else throw new ArgumentError(type + " has no weaponSpeed declared!");
            if(data.collisionMode) dataArray[6] = (data.collisionMode as String); else throw new ArgumentError(type + " has no collisionMode declared!");
            if(data.collisionPoint) dataArray[7] = new Point(data.collisionPoint[0], data.collisionPoint[1]); else throw new ArgumentError(type + " has no collisionPoint declared!");
	        if(data.collisionValues) dataArray[8] = new Point(data.collisionValues[0], data.collisionValues[1]); else throw new ArgumentError(type + " has no collisionValues declared!");
            dataArray[9] = AssetsManager.getMovieClip(PLAYER);

            stream.close();
            return dataArray;
        }

        public static function get playerMovementBorder():Rectangle
        {
            return _playerMovementBorder;
        }

        public static function get playerStartPosition():Point
        {
            return _playerStartPosition;
        }

	    public static function get bossStartPosition():Point {
		    return _bossStartPosition;
	    }
    }
}
