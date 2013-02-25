package de.mediadesign.gd1011.dreamcatcher.Assets
{
	import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import flash.utils.Dictionary;
    import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
    import starling.utils.AssetManager;

    public class GraphicsManager extends AssetManager
	{
        private static var self:GraphicsManager;

        private var mContainers:Dictionary;
        private var mInit:Boolean;

        public function GraphicsManager():void
        {
            super(Starling.contentScaleFactor, true);

            mContainers = new Dictionary();
            mInit = false;
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
            return new Image(getTexture(item))
		}

		public function addMovieClip(clip:DisplayObject, item:String):void
		{
			if (clip is Image)
			{
				clip.dispose();
			}
			else
			{
                if(item in mContainers)
                {
                    for(var i:int=0;i<(clip as DisplayObjectContainer).numChildren;i++)
                       ((clip as DisplayObjectContainer).getChildAt(i) as AnimatedModel).reset();
                    mContainers[item].push(clip);
                }
                else
                {
                    mContainers[item] = new Vector.<DisplayObjectContainer>();
                    addMovieClip(clip, item);
                }
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
                    {
                        for(var i:int=0;i<(mContainers[item][0] as DisplayObjectContainer).numChildren;i++)
                            ((mContainers[item][0] as DisplayObjectContainer).getChildAt(i) as AnimatedModel).start();
                        return mContainers[item].shift();
                    }
                    else
                    {
                        var container:Sprite = new Sprite();
                        container.addChild(AnimatedModel.createByType(item));
                        if(item == GameConstants.PLAYER)
                            container.addChild(AnimatedModel.createByType(item+"Arm"));
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

        public function get initCompleted():Boolean {
            return mInit;
        }

        public function set initCompleted(value:Boolean):void {
            mInit = value;
        }
    }
}
