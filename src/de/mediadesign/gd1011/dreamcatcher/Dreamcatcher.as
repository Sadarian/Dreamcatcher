package de.mediadesign.gd1011.dreamcatcher
{
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
    import flash.events.Event;
	import flash.geom.Rectangle;
    import flash.net.SharedObject;
    import flash.system.Capabilities;

    import starling.core.Starling;
    import starling.events.Event;
    import starling.events.ResizeEvent;

    [SWF(width="1280", height="800", frameRate="60", backgroundColor="#000000")]
	public class Dreamcatcher extends Sprite
    {
        public static const debugMode:Boolean = true;

        public static var localObject:SharedObject = SharedObject.getLocal("Dreamcatcher");

		private var _starling:Starling;

		public function Dreamcatcher()
        {
			Starling.handleLostContext = true;
            Starling.multitouchEnabled = true;

			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			stage.autoOrients = false;
			stage.setOrientation(StageOrientation.ROTATED_RIGHT);

			init();
		}

		private function init():void
        {
            GameConstants.init();

			_starling = new Starling(Game, stage, new Rectangle(0, 0 ,
                    Math.max(stage.fullScreenHeight, stage.fullScreenWidth),
                    Math.min(stage.fullScreenHeight, stage.fullScreenWidth)));
			_starling.showStats = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
		}

		private function onRootCreated(event:starling.events.Event):void
        {
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onActivate);
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING, onExiting);

			_starling.start();
            (_starling.root as Game).setStartTimeStamp();
            (_starling.root as Game).init();
		}

        private function onActivate(event:flash.events.Event):void
        {
            _starling.start();
            (_starling.root as Game).setStartTimeStamp();
        }

        private function onDeactivate(event:flash.events.Event):void
        {
            _starling.stop();
        }

        private function onExiting(event:flash.events.Event):void
        {
        }
	}
}
