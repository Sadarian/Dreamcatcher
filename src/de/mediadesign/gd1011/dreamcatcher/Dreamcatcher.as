package de.mediadesign.gd1011.dreamcatcher
{
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
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

			init();
		}

		private function init():void
        {
            GameConstants.init();
            stage.stageHeight = stage.fullScreenHeight;
            stage.stageWidth = stage.fullScreenWidth;
			_starling = new Starling(Game, stage, new Rectangle(0, 0 , stage.stageWidth, stage.stageHeight));
			_starling.showStats = true;
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, startStarling);
            //_starling.addEventListener(ResizeEvent.RESIZE, resize)
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

        private function resize(e:ResizeEvent):void
        {
        }
	}
}
