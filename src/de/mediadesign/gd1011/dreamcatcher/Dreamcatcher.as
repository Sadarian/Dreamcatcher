package de.mediadesign.gd1011.dreamcatcher
{
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
	import flash.display.StageOrientation;
	import flash.display.StageScaleMode;
    import flash.events.Event;
	import flash.events.StageOrientationEvent;
	import flash.geom.Orientation3D;
	import flash.geom.Rectangle;
    import starling.core.Starling;
    import starling.events.Event;
    import starling.events.ResizeEvent;

    [SWF(width="1280", height="800", frameRate="60", backgroundColor="#ffffff")]
	public class Dreamcatcher extends Sprite
    {
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
            stage.stageHeight = stage.fullScreenHeight;
            stage.stageWidth = stage.fullScreenWidth;
			_starling = new Starling(Game, stage, new Rectangle(0, 0 , 1280, 800));
			_starling.showStats = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, startStarling);
		}

		private function startStarling(event:starling.events.Event):void
        {
			_starling.start();
            (_starling.root as Game).setStartTimeStamp();
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onActivate);
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING, onExiting);
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
