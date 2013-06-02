package de.mediadesign.gd1011.dreamcatcher.AssetsClasses
{
    import de.mediadesign.gd1011.dreamcatcher.Dreamcatcher;
    import de.mediadesign.gd1011.dreamcatcher.Game;
    import de.mediadesign.gd1011.dreamcatcher.GameConstants;
    import de.mediadesign.gd1011.dreamcatcher.View.AnimatedModel;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;
	import de.mediadesign.gd1011.dreamcatcher.View.Menu.TutorialMenu;

	import flash.filesystem.File;
    import flash.media.SoundChannel;
    import flash.media.SoundMixer;
    import flash.media.SoundTransform;
    import flash.utils.Dictionary;
    import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
    import starling.utils.AssetManager;
    import de.mediadesign.gd1011.dreamcatcher.View.ProgressBar;

	public class GraphicsManager extends AssetManager
	{
        private static var self:GraphicsManager;
        private var mContainers:Dictionary;
        private var mInit:Boolean;
        private var mLast:String;
        private var mProgressBar:ProgressBar;

        private var contents:Array = ["assets/textures/atlases/STATIC", "assets/audio", "assets/textures/atlases/UI"];

        public function GraphicsManager():void
        {
            super(0.5, false);
            mContainers = new Dictionary();
            SoundMixer.soundTransform = new SoundTransform((Dreamcatcher.localObject.data.soundOn)?1:0, 0);
            mProgressBar = new ProgressBar(3);
            mInit = false;
            mLast = "UI";
            enqueue(EmbeddedAssets);
        }

        public static function get graphicsManager():GraphicsManager
        {
            if (!self)
                self = new GraphicsManager();
            return self;
        }

		public function init():void
		{
            if(contents.length==3)
                (Starling.current.root as Game).addChild(mProgressBar);
            if(contents.length>0)
                initContent(contents.shift(), init);
            else
            {
                (Starling.current.root as Game).resumeInit();
                (Starling.current.root as Game).removeChild(mProgressBar);
                mProgressBar.dispose();
            }

		}

        private function initContent(path:String, func:Function):void
        {
            enqueue(File.applicationDirectory.resolvePath(path));

            loadQueue(function(ratio:Number):void
            {
                mProgressBar.setRatio(2-contents.length, ratio/3);
                if(ratio==1)
                {
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
		            TutorialMenu.resetTutorial();
	                if (Game.currentLvl == GameConstants.TUTORIAL)
	                {
		                deleteStream = GameConstants.LEVEL_TUTORIAL_LIST;
	                }
		            else
	                {
		                deleteStream = GameConstants["LEVEL" + Game.currentLvl + "_LIST"];
	                }
                    blendGraphic = true;
                    break;

                default:
		            TutorialMenu.resetTutorial();
                    mContainers = new Dictionary();
					if (mLast == "UI")
					{
						deleteStream = GameConstants.UI_LIST
					}
					else if (mLast == "LEVEL"+GameConstants.TUTORIAL)
					{
						deleteStream = GameConstants.LEVEL_TUTORIAL_LIST;
					}
					else deleteStream = GameConstants["LEVEL"+(Game.currentLvl-1)+"_LIST"];
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
                var pB:ProgressBar = new ProgressBar();
                (Starling.current.root as Game).addChild(pB);
                loadQueue(function(ratio:Number):void
                {
                    pB.setRatio(0, ratio);
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
                        Starling.juggler.delayCall(functionAfter, 0.15);
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

        override public function playSound(name:String, startTime:Number=0, loops:int=0,
                                  transform:SoundTransform=null):SoundChannel
        {
            if (name in mSounds)
                return getSound(name).play(startTime, loops, transform);
            else
                return null;
        }

        public function get initCompleted():Boolean {
            return mInit;
        }

        public function set initCompleted(value:Boolean):void {
            mInit = value;
        }
    }
}
