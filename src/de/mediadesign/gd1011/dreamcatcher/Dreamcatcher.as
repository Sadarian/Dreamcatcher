package de.mediadesign.gd1011.dreamcatcher
{
    import de.mediadesign.gd1011.dreamcatcher.Assets.GraphicsManager;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.MainMenu;
    import de.mediadesign.gd1011.dreamcatcher.View.Menu.PauseMenu;
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
    import flash.net.SharedObject;
    import starling.core.Starling;
    import flash.events.*;
    import starling.events.ResizeEvent;

    [SWF(width="1280", height="800", frameRate="60", backgroundColor="#ffffff")]
	public class Dreamcatcher extends Sprite
    {
        public static const debugMode:Boolean = false;

        public static var localObject:SharedObject = SharedObject.getLocal("Dreamcatcher");

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
            GameConstants.init();

			_starling = new Starling(Game, stage);
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
            if(!MainMenu.isActive() && !PauseMenu.isActive() && GraphicsManager.graphicsManager.initCompleted)
                PauseMenu.showAndHide();
            _starling.start();
            (_starling.root as Game).setStartTimeStamp();
        }

        private function onDeactivate(event:Event):void
        {
            _starling.stop();
        }

        private function onExiting(event:Event):void
        {
        }
	}
}
