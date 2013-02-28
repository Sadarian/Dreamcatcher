package de.mediadesign.gd1011.dreamcatcher.AssetsClasses
{
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;

    import flash.filesystem.File;
	import flash.utils.Dictionary;
    import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
    import starling.utils.AssetManager;
    import starling.utils.ProgressBar;

	public class GraphicsManager extends AssetManager
	{
        private static var self:GraphicsManager;

        private var mContainers:Dictionary;
        private var mInit:Boolean;
        private var mLast:String;

        private var contents:Array = ["assets/textures/atlases/STATIC", "assets/audio"];

        public function GraphicsManager():void
        {
            super(Starling.contentScaleFactor, false);

            mContainers = new Dictionary();
            mInit = false;
            mLast = null;
            enqueue(EmbeddedFonts);
        }

        public static function get graphicsManager():GraphicsManager
        {
            if (!self)
                self = new GraphicsManager();
            return self;
        }

		public function init():void
		{
            if(contents.length>0)
                initContent(contents.shift(), init);
            else
                loadDataFor("UI", (Starling.current.root as Game).resumeInit);
		}

        private function initContent(path:String, func:Function):void
        {
            enqueue(File.applicationDirectory.resolvePath(path));

            var pB:ProgressBar = new ProgressBar(240, 80);
            pB.x = Starling.current.stage.stageWidth/2 - pB.width/2;
            pB.y = Starling.current.stage.stageHeight/2 - pB.height/2;
            (Starling.current.root as Game).addChild(pB);
            loadQueue(function(ratio:Number):void
            {
                pB.ratio = ratio;
                if(ratio==1)
                {
                    (Starling.current.root as Game).removeChild(pB);
                    pB.dispose();
                    Starling.juggler.delayCall(func, 0.15);
                }
            });
        }

        public function loadDataFor(dataSet:String, functionAfter:Function):void
        {
            if(dataSet == mLast){Starling.juggler.delayCall(functionAfter, 0.15); return;}
            mInit = false;
            var deleteStream:Array;
            var blendScreen:Image;
            var blendGraphic:Boolean = false;
            switch (dataSet)
            {
                case("UI"):
                    MainMenu.resetMainMain();
                    deleteStream = GameConstants["LEVEL"+Game.currentLvl+"_LIST"];
                    blendGraphic = true;
                    break;

                default:
                    deleteStream = (mLast == "UI")?GameConstants.UI_LIST:GameConstants["LEVEL"+(Game.currentLvl-1)+"_LIST"];;
                    blendScreen = getImage("tutorialScreen_"+(1+Math.round(Math.random()*3)));
                    break;
            }
            var i:int;
            for(i = 0;i<deleteStream.length;i++)
                removeTextureAtlas(deleteStream[i]+"Texture");
            enqueue(File.applicationDirectory.resolvePath("assets/textures/atlases/"+dataSet));
            mLast = dataSet;

            if(blendGraphic)
            {
                var pB:ProgressBar = new ProgressBar(240, 80);
                pB.x = Starling.current.stage.stageWidth/2 - pB.width/2;
                pB.y = Starling.current.stage.stageHeight/2 - pB.height/2;
                (Starling.current.root as Game).addChild(pB);
                loadQueue(function(ratio:Number):void
                {
                    pB.ratio = ratio;
                    if(ratio==1)
                    {
                        (Starling.current.root as Game).removeChild(pB);
                        pB.dispose();
                        Starling.juggler.delayCall(functionAfter, 0.15);
                    }
                });
            }
            else
            {
                (Starling.current.root as Game).addChild(blendScreen);
                loadQueue(function(ratio:Number):void
                {
                    if(ratio==1)
                    {
                        (Starling.current.root as Game).removeChild(blendScreen);
                        blendScreen.dispose();
                        Starling.juggler.delayCall(functionAfter, 2.0);
                    }
                });
            }
        }

		public function getImage(item:String):Image
		{
            var img:Image = new Image(getTexture(item));
            img.name = item;
            return img;
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
