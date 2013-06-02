package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.AssetsClasses.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.View.HighScore;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.HighScoreMenu;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.PauseMenu;

    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
    import flash.media.SoundMixer;
    import flash.media.SoundTransform;
    import flash.net.SharedObject;
    import flash.system.Capabilities;

    import starling.core.Starling;
    import flash.events.*;
    import starling.events.ResizeEvent;

    [SWF(width="1280", height="800", frameRate="60", backgroundColor="#000000")]
	public class Dreamcatcher extends Sprite
    {
        public static const debugMode:Boolean = false;

        public static var localObject:SharedObject = SharedObject.getLocal("Dreamcatcher");

        public static var scaleFactor:Number;

		private var _starling:Starling;

		public function Dreamcatcher()
        {
			Starling.handleLostContext = true;
            Starling.multitouchEnabled = true;

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.frameRate = 60;

            init();

            stage.addEventListener(ResizeEvent.RESIZE, onResize);
		}

		private function init():void
        {
            if(!localObject.data.Progress)
                localObject.data.Progress = 1;
            if(localObject.data.soundOn == null)
                localObject.data.soundOn = true;
            if(localObject.data.Endless == null)
                localObject.data.Endless = false;

            HighScore.initHighScore();
            GameConstants.init();
			_starling = new Starling(Game, stage, new Rectangle(0, 0 ,
                    Math.max(stage.fullScreenHeight, stage.fullScreenWidth),
                    Math.min(stage.fullScreenHeight, stage.fullScreenWidth)));

            scaleFactor = (Math.min(Capabilities.screenResolutionX, Capabilities.screenResolutionY)<800)?0.5:1;

			_starling.showStats = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
		}

        private function onResize(e:Event):void
        {
            _starling.viewPort = new Rectangle(0, 0 ,
                    Math.max(stage.fullScreenHeight, stage.fullScreenWidth),
                    Math.min(stage.fullScreenHeight, stage.fullScreenWidth));
            _starling.stage.stageWidth = _starling.viewPort.width;
            _starling.stage.stageHeight = _starling.viewPort.height;
        }

		private function onRootCreated():void
        {
            NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, onActivate);
            NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, onDeactivate);
            NativeApplication.nativeApplication.addEventListener(Event.EXITING, onExiting);

			_starling.start();
            (_starling.root as Game).setStartTimeStamp();
            (_starling.root as Game).init();
		}

        private function onActivate(event:Event):void
        {
            if(!MainMenu.isActive() && !PauseMenu.isActive() && !HighScoreMenu.isActive() && GraphicsManager.graphicsManager.initCompleted)
                PauseMenu.showAndHide();
            SoundMixer.soundTransform = new SoundTransform((Dreamcatcher.localObject.data.soundOn)?1:0, 0);
            _starling.start();
            (_starling.root as Game).setStartTimeStamp();
        }

        private function onDeactivate(event:Event):void
        {
            SoundMixer.soundTransform = new SoundTransform(0, 0);
            _starling.stop();
        }

        private function onExiting(event:Event):void
        {
        }
	}
}
