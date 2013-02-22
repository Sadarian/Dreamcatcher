package de.mediadesign.gd1011.dreamcatcher.Assets
{
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;

import flash.geom.Rectangle;
import flash.utils.Dictionary;

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

        private var mContainers:Dictionary;

        public function GraphicsManager():void
        {
            super(Starling.contentScaleFactor, true);

            mContainers = new Dictionary();
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
			if (clip is Image)
			{
				clip.dispose();
			}
			else
			{
                /*
                if(item in mContainers)
                {
                    if(clip)
                    {
                        mContainers[item].push(clip);
                        for(var i:int=0;i<(clip as DisplayObjectContainer).numChildren;i++)
                        {
                           ((clip as DisplayObjectContainer).getChildAt(i) as AnimatedModel).reset();
                           ((clip as DisplayObjectContainer).getChildAt(i) as AnimatedModel).start();
                        }
                    }
                }
                else
                {
                    mContainers[item] = new Vector.<DisplayObjectContainer>();
                    addMovieClip(clip, item);
                }
                */
			}
		}

        public function getMovieClip(item:String):DisplayObject
        {
            if (item.search(GameConstants.POWERUP) >= 0)
            {
                return getImage(item);
            }
            else
            {
                if(item in mContainers)
                {
                    if(mContainers[item].length > 0)
                        return mContainers[item].shift();
                    else
                    {
                        var container:Sprite = new Sprite();
                        container.addChild(createMovieClip(item));
                        if(item == GameConstants.PLAYER)
                            container.addChild(createMovieClip(item+"Arm"));
                        return container;
                    }
                }
                else
                {
                    mContainers[item] = new Vector.<DisplayObjectContainer>();
                    return getMovieClip(item);
                }
            }
        }

        //The following Functions will be removed and/or adjusted after transforming the Animations into Atlases!
        private function createMovieClip(type:String):DisplayObject
        {
            var getStates:Array = (GameConstants[type+"_States"])?GameConstants[type+"_States"]:null;
            var getDefault:String = (GameConstants[type+"_Default"])?GameConstants[type+"_Default"]:AnimatedModel.WALK;
            return new AnimatedModel(type,  getStates, getDefault);
        }
	}
}
