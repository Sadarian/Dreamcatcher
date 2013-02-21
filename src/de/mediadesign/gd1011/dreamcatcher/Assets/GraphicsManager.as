package de.mediadesign.gd1011.dreamcatcher.Assets
{
	import avmplus.typeXml;

	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
    import starling.textures.TextureAtlas;
    import starling.utils.AssetManager;

    public class GraphicsManager extends AssetManager
	{
        private static var self:GraphicsManager;

        private var Player_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
        private var PlayerBullet_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private var Enemy_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
        private var EnemyBullet_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private var Victim1_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private var Boss_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();

        public function GraphicsManager():void
        {
            super(Starling.contentScaleFactor, true);

            Player_List = new Vector.<DisplayObjectContainer>();
            PlayerBullet_List = new Vector.<DisplayObjectContainer>();
            Enemy_List = new Vector.<DisplayObjectContainer>();
            EnemyBullet_List = new Vector.<DisplayObjectContainer>();
            Victim1_List = new Vector.<DisplayObjectContainer>();
            Boss_List = new Vector.<DisplayObjectContainer>();
        }

        public static function get graphicsManager():GraphicsManager
        {
            if (!self)
                self = new GraphicsManager();
            return self;
        }

		public function init():void
		{
            enqueue(EmbeddedAssets);
		}

		public function getImage(item:String):Image
		{
			return new Image(getTexture(item));
		}

		public function addMovieClip(clip:DisplayObject, item:String):void
		{
            if(this[item+"_List"])
                this[item+"_List"].push(clip);
            else
                throw new ArgumentError(item + " does not Exist!");
		}

        public function getMovieClip(item:String):DisplayObject
        {
            if(this[item+"_List"])
            {
              //  if(this[item+"_List"].length > 0)
              //      return this[item+"_List"].shift();
              //  else
                {
                    var sprite:Sprite = new Sprite();
                    sprite.addChild(createMovieClip(item));
                    if(item == GameConstants.PLAYER)
                        sprite.addChild(createMovieClip(item+"Arm"));
                    return sprite;
                }
            }
            else
                throw new ArgumentError(item + " does not Exist!");
        }

        //The following Functions will be removed and/or adjusted after transforming the Animations into Atlases!
        private function createMovieClip(type:String):DisplayObject
        {
            var newClip:AnimatedModel;
            newClip = new AnimatedModel(type, GameConstants[type.toUpperCase()+"_STATES"]);
            return newClip;
        }

        public function createAtlasAnim(name:String,w:int,h:int,frames:int):TextureAtlas
        {
            var texture:Texture = getTexture(name);

            var atlas:TextureAtlas = new TextureAtlas (texture);
            var hNew:int = texture.height / h;
            var wNew:int = texture.width / w;

            for (var i:int = 0; i < frames; i++)
            {
                var x:int = i%w;
                var y:int = i/w;

                var nameNew:String = String(i);
                while ( nameNew.length < 3 )
                {
                    nameNew = "0" + nameNew;
                }
                atlas.addRegion(name+nameNew, new Rectangle(x*wNew,y*hNew, wNew, hNew));

            }
            return atlas;
        }
	}
}
