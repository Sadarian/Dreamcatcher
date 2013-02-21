package de.mediadesign.gd1011.dreamcatcher.Assets
{
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
        private var Player_Bullet_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private var Enemy_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
        private var Enemy_Bullet_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private var Victim_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
		private var Boss_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();
        private var Boss_Bullet_List:Vector.<DisplayObjectContainer> = new Vector.<DisplayObjectContainer>();

        public function GraphicsManager():void
        {
            super(Starling.contentScaleFactor, true);

            Player_List = new Vector.<DisplayObjectContainer>();
            Player_Bullet_List = new Vector.<DisplayObjectContainer>();
            Enemy_List = new Vector.<DisplayObjectContainer>();
            Enemy_Bullet_List = new Vector.<DisplayObjectContainer>();
            Victim_List = new Vector.<DisplayObjectContainer>();
            Boss_List = new Vector.<DisplayObjectContainer>();
            Boss_Bullet_List = new Vector.<DisplayObjectContainer>();
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
                if(this[item+"_List"].length > 0)
                    return this[item+"_List"].shift();
                else
                {
                    var sprite:Sprite = new Sprite();
                    sprite.addChild(createMovieClip(GameConstants[item.toUpperCase()+"_TEXTURE_NAME"], GameConstants[item.toUpperCase()+"_ANIM_CONFIG"]));
                    if(item == GameConstants.PLAYER)
                        sprite.addChild(createMovieClip(GameConstants[item.toUpperCase()+"_ARM_TEXTURE_NAME"], GameConstants[item.toUpperCase()+"_ARM_ANIM_CONFIG"]));
                    return sprite;
                }
            }
            else
                throw new ArgumentError(item + " does not Exist!");
        }

        //The following Functions will be removed and/or adjusted after transforming the Animations into Atlases!
        private function createMovieClip(assetName:String, v:Vector.<int>):DisplayObject
        {
            var newClip:MovieClip;
            var frames:Vector.<Texture> = createAtlasAnim(assetName,v[0],v[1],v[2]).getTextures(assetName);
            newClip = new MovieClip(frames, v[3]);
            newClip.play();
            Starling.juggler.add(newClip);
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
